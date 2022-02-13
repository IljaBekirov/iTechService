require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe SalariesController do

  # This should return the minimal set of attributes required to create a valid
  # Salary. As you add validations to Salary, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    { "user" => "" }
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # SalariesController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all salaries as @salaries" do
      salary = Salary.create! valid_attributes
      get :index, params: {}, session: valid_session
      assigns(:salaries).should eq([salary])
    end
  end

  describe "GET show" do
    it "assigns the requested salary as @salary" do
      salary = Salary.create! valid_attributes
      get :show, params: {:id => salary.to_param}, session: valid_session
      assigns(:salary).should eq(salary)
    end
  end

  describe "GET new" do
    it "assigns a new salary as @salary" do
      get :new, params: {}, session: valid_session
      assigns(:salary).should be_a_new(Salary)
    end
  end

  describe "GET edit" do
    it "assigns the requested salary as @salary" do
      salary = Salary.create! valid_attributes
      get :edit, params: {:id => salary.to_param}, session: valid_session
      assigns(:salary).should eq(salary)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Salary" do
        expect {
          post :create, params: {:salary => valid_attributes}, session: valid_session
        }.to change(Salary, :count).by(1)
      end

      it "assigns a newly created salary as @salary" do
        post :create, params: {:salary => valid_attributes}, session: valid_session
        assigns(:salary).should be_a(Salary)
        assigns(:salary).should be_persisted
      end

      it "redirects to the created salary" do
        post :create, params: {:salary => valid_attributes}, session: valid_session
        response.should redirect_to(Salary.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved salary as @salary" do
        # Trigger the behavior that occurs when invalid params are submitted
        Salary.any_instance.stub(:save).and_return(false)
        post :create, params: {:salary => { "user" => "invalid value" }}, session: valid_session
        assigns(:salary).should be_a_new(Salary)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Salary.any_instance.stub(:save).and_return(false)
        post :create, params: {:salary => { "user" => "invalid value" }}, session: valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested salary" do
        salary = Salary.create! valid_attributes
        # Assuming there are no other salaries in the database, this
        # specifies that the Salary created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Salary.any_instance.should_receive(:update_attributes).with({ "user" => "" })
        put :update, params: {:id => salary.to_param, :salary => { "user" => "" }}, session: valid_session
      end

      it "assigns the requested salary as @salary" do
        salary = Salary.create! valid_attributes
        put :update, params: {:id => salary.to_param, :salary => valid_attributes}, session: valid_session
        assigns(:salary).should eq(salary)
      end

      it "redirects to the salary" do
        salary = Salary.create! valid_attributes
        put :update, params: {:id => salary.to_param, :salary => valid_attributes}, session: valid_session
        response.should redirect_to(salary)
      end
    end

    describe "with invalid params" do
      it "assigns the salary as @salary" do
        salary = Salary.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Salary.any_instance.stub(:save).and_return(false)
        put :update, params: {:id => salary.to_param, :salary => { "user" => "invalid value" }}, session: valid_session
        assigns(:salary).should eq(salary)
      end

      it "re-renders the 'edit' template" do
        salary = Salary.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Salary.any_instance.stub(:save).and_return(false)
        put :update, params: {:id => salary.to_param, :salary => { "user" => "invalid value" }}, session: valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested salary" do
      salary = Salary.create! valid_attributes
      expect {
        delete :destroy, params: {:id => salary.to_param}, session: valid_session
      }.to change(Salary, :count).by(-1)
    end

    it "redirects to the salaries list" do
      salary = Salary.create! valid_attributes
      delete :destroy, params: {:id => salary.to_param}, session: valid_session
      response.should redirect_to(salaries_url)
    end
  end

end
