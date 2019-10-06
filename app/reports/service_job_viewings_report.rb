class ServiceJobViewingsReport < BaseReport
  ReportRecord = Struct.new(:time, :job_id, :ticket_number, :viewer, :sum)

  attr_accessor :department_id

  def call
    location_id = Location.where(code: 'done', department_id: department_id).first.id
    viewings = ServiceJobViewing.includes(:service_job, :user)
                 .where(time: period, service_jobs: {location_id: location_id})

    result[:records] = viewings.map do |viewing|
      ReportRecord.new(
                    viewing.time,
                    viewing.service_job_id,
                    viewing.service_job.ticket_number,
                    viewing.user_presentation,
                    viewing.service_job.tasks_cost
      )
    end
  end

  def only_day?
    true
  end
end
