
class DevicesController < ApplicationController
  #before_filter :store_location
  helper_method :sort_column, :sort_direction
  #autocomplete :client, :phone_number, full: true, extra_data: [:name], display_value: :name_phone
  load_and_authorize_resource except: :check_status
  skip_load_resource only: [:index, :history, :task_history]
  skip_before_filter :authenticate_user!, :set_current_user, only: :check_status
  
  def index
    @devices = Device.search params
    
    if params.has_key? :sort and params.has_key? :direction
      @devices = @devices.reorder 'devices.'+sort_column + ' ' + sort_direction
    end
    @devices = @devices.ordered.page params[:page]
    @location_name = params[:location].present? ? Location.find(params[:location]).full_name : 'everywhere'

    respond_to do |format|
      format.html
      format.json { render json: @devices }
      format.js { render 'shared/index' }
    end
  end

  def show
    @device = Device.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @device }
      format.pdf do
        pdf = TicketPdf.new @device, view_context
        send_data pdf.render, filename: "ticket_#{@device.ticket_number}.pdf",
                  type: "application/pdf", disposition: "inline"
      end
    end
  end

  def new
    @device = Device.new(params[:device])
    #@device.location = current_user.location

    respond_to do |format|
      format.html
      format.json { render json: @device }
    end
  end

  def edit
    @device = Device.find(params[:id])
  end

  def create
    #params[:device].merge! user_id: current_user.id
    @device = Device.new(params[:device])

    respond_to do |format|
      if @device.save
        format.html { redirect_to @device, notice: 'Device was successfully created.' }
        format.json { render json: @device, status: :created, location: @device }
      else
        format.html { render action: "new" }
        format.json { render json: @device.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @device = Device.find(params[:id])

    respond_to do |format|
      if @device.update_attributes(params[:device])
        format.html { redirect_to @device, notice: 'Device was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @device.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @device = Device.find(params[:id])
    @device.destroy

    respond_to do |format|
      format.html { redirect_to devices_url }
      format.json { head :no_content }
    end
  end
  
  def history
    device = Device.find params[:id]
    @records = device.history_records
    render 'shared/show_history'
  end
  
  def task_history
    device = Device.find params[:device_id]
    device_task = DeviceTask.find params[:id]
    @records = device_task.history_records
    render 'shared/show_history'
  end

  def device_type_select
    if params[:device_type_id].blank?
      render 'device_type_refresh'
    else
      @device_type = DeviceType.find params[:device_type_id]
      render 'device_type_select'
    end
  end

  def check_status
    @device = Device.find_by_ticket_number params[:ticket_number]

    respond_to do |format|
      if @device.present?
        format.js { render 'information' }
        format.json { render json: @device.status_info}
      else
        format.js { render t('device.not_found') }
        format.json { render json: {error: t('device.not_found')} }
      end
    end
  end

  def autocomplete_client
    @clients = Client.search(params).limit(10)
  end

  def select_client
    @client = Client.find params[:client_id]
  end
  
  private
  
  def sort_column
    Device.column_names.include?(params[:sort]) ? params[:sort] : ''
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : ''
  end
  
end
