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

describe ClientCategoriesController do

  # This should return the minimal set of attributes required to create a valid
  # ClientCategory. As you add validations to ClientCategory, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "name" => "MyString" } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ClientCategoriesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all client_categories as @client_categories" do
      client_category = ClientCategory.create! valid_attributes
      get :index, params: {}, session: valid_session
      assigns(:client_categories).should eq([client_category])
    end
  end

  describe "GET show" do
    it "assigns the requested client_category as @client_category" do
      client_category = ClientCategory.create! valid_attributes
      get :show, params: {:id => client_category.to_param}, session: valid_session
      assigns(:client_category).should eq(client_category)
    end
  end

  describe "GET new" do
    it "assigns a new client_category as @client_category" do
      get :new, params: {}, session: valid_session
      assigns(:client_category).should be_a_new(ClientCategory)
    end
  end

  describe "GET edit" do
    it "assigns the requested client_category as @client_category" do
      client_category = ClientCategory.create! valid_attributes
      get :edit, params: {:id => client_category.to_param}, session: valid_session
      assigns(:client_category).should eq(client_category)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new ClientCategory" do
        expect {
          post :create, params: {:client_category => valid_attributes}, session: valid_session
        }.to change(ClientCategory, :count).by(1)
      end

      it "assigns a newly created client_category as @client_category" do
        post :create, params: {:client_category => valid_attributes}, session: valid_session
        assigns(:client_category).should be_a(ClientCategory)
        assigns(:client_category).should be_persisted
      end

      it "redirects to the created client_category" do
        post :create, params: {:client_category => valid_attributes}, session: valid_session
        response.should redirect_to(ClientCategory.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved client_category as @client_category" do
        # Trigger the behavior that occurs when invalid params are submitted
        ClientCategory.any_instance.stub(:save).and_return(false)
        post :create, params: {:client_category => { "name" => "invalid value" }}, session: valid_session
        assigns(:client_category).should be_a_new(ClientCategory)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        ClientCategory.any_instance.stub(:save).and_return(false)
        post :create, params: {:client_category => { "name" => "invalid value" }}, session: valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested client_category" do
        client_category = ClientCategory.create! valid_attributes
        # Assuming there are no other client_categories in the database, this
        # specifies that the ClientCategory created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        ClientCategory.any_instance.should_receive(:update_attributes).with({ "name" => "MyString" })
        put :update, params: {:id => client_category.to_param, :client_category => { "name" => "MyString" }}, session: valid_session
      end

      it "assigns the requested client_category as @client_category" do
        client_category = ClientCategory.create! valid_attributes
        put :update, params: {:id => client_category.to_param, :client_category => valid_attributes}, session: valid_session
        assigns(:client_category).should eq(client_category)
      end

      it "redirects to the client_category" do
        client_category = ClientCategory.create! valid_attributes
        put :update, params: {:id => client_category.to_param, :client_category => valid_attributes}, session: valid_session
        response.should redirect_to(client_category)
      end
    end

    describe "with invalid params" do
      it "assigns the client_category as @client_category" do
        client_category = ClientCategory.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        ClientCategory.any_instance.stub(:save).and_return(false)
        put :update, params: {:id => client_category.to_param, :client_category => { "name" => "invalid value" }}, session: valid_session
        assigns(:client_category).should eq(client_category)
      end

      it "re-renders the 'edit' template" do
        client_category = ClientCategory.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        ClientCategory.any_instance.stub(:save).and_return(false)
        put :update, params: {:id => client_category.to_param, :client_category => { "name" => "invalid value" }}, session: valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested client_category" do
      client_category = ClientCategory.create! valid_attributes
      expect {
        delete :destroy, params: {:id => client_category.to_param}, session: valid_session
      }.to change(ClientCategory, :count).by(-1)
    end

    it "redirects to the client_categories list" do
      client_category = ClientCategory.create! valid_attributes
      delete :destroy, params: {:id => client_category.to_param}, session: valid_session
      response.should redirect_to(client_categories_url)
    end
  end

end
