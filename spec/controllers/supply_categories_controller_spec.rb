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

describe SupplyCategoriesController do

  # This should return the minimal set of attributes required to create a valid
  # SupplyCategory. As you add validations to SupplyCategory, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "name" => "MyString" } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # SupplyCategoriesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all supply_categories as @supply_categories" do
      supply_category = SupplyCategory.create! valid_attributes
      get :index, params: {}, session: valid_session
      assigns(:supply_categories).should eq([supply_category])
    end
  end

  describe "GET show" do
    it "assigns the requested supply_category as @supply_category" do
      supply_category = SupplyCategory.create! valid_attributes
      get :show, params: {:id => supply_category.to_param}, session: valid_session
      assigns(:supply_category).should eq(supply_category)
    end
  end

  describe "GET new" do
    it "assigns a new supply_category as @supply_category" do
      get :new, params: {}, session: valid_session
      assigns(:supply_category).should be_a_new(SupplyCategory)
    end
  end

  describe "GET edit" do
    it "assigns the requested supply_category as @supply_category" do
      supply_category = SupplyCategory.create! valid_attributes
      get :edit, params: {:id => supply_category.to_param}, session: valid_session
      assigns(:supply_category).should eq(supply_category)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new SupplyCategory" do
        expect {
          post :create, params: {:supply_category => valid_attributes}, session: valid_session
        }.to change(SupplyCategory, :count).by(1)
      end

      it "assigns a newly created supply_category as @supply_category" do
        post :create, params: {:supply_category => valid_attributes}, session: valid_session
        assigns(:supply_category).should be_a(SupplyCategory)
        assigns(:supply_category).should be_persisted
      end

      it "redirects to the created supply_category" do
        post :create, params: {:supply_category => valid_attributes}, session: valid_session
        response.should redirect_to(SupplyCategory.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved supply_category as @supply_category" do
        # Trigger the behavior that occurs when invalid params are submitted
        SupplyCategory.any_instance.stub(:save).and_return(false)
        post :create, params: {:supply_category => { "name" => "invalid value" }}, session: valid_session
        assigns(:supply_category).should be_a_new(SupplyCategory)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        SupplyCategory.any_instance.stub(:save).and_return(false)
        post :create, params: {:supply_category => { "name" => "invalid value" }}, session: valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested supply_category" do
        supply_category = SupplyCategory.create! valid_attributes
        # Assuming there are no other supply_categories in the database, this
        # specifies that the SupplyCategory created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        SupplyCategory.any_instance.should_receive(:update_attributes).with({ "name" => "MyString" })
        put :update, params: {:id => supply_category.to_param, :supply_category => { "name" => "MyString" }}, session: valid_session
      end

      it "assigns the requested supply_category as @supply_category" do
        supply_category = SupplyCategory.create! valid_attributes
        put :update, params: {:id => supply_category.to_param, :supply_category => valid_attributes}, session: valid_session
        assigns(:supply_category).should eq(supply_category)
      end

      it "redirects to the supply_category" do
        supply_category = SupplyCategory.create! valid_attributes
        put :update, params: {:id => supply_category.to_param, :supply_category => valid_attributes}, session: valid_session
        response.should redirect_to(supply_category)
      end
    end

    describe "with invalid params" do
      it "assigns the supply_category as @supply_category" do
        supply_category = SupplyCategory.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        SupplyCategory.any_instance.stub(:save).and_return(false)
        put :update, params: {:id => supply_category.to_param, :supply_category => { "name" => "invalid value" }}, session: valid_session
        assigns(:supply_category).should eq(supply_category)
      end

      it "re-renders the 'edit' template" do
        supply_category = SupplyCategory.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        SupplyCategory.any_instance.stub(:save).and_return(false)
        put :update, params: {:id => supply_category.to_param, :supply_category => { "name" => "invalid value" }}, session: valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested supply_category" do
      supply_category = SupplyCategory.create! valid_attributes
      expect {
        delete :destroy, params: {:id => supply_category.to_param}, session: valid_session
      }.to change(SupplyCategory, :count).by(-1)
    end

    it "redirects to the supply_categories list" do
      supply_category = SupplyCategory.create! valid_attributes
      delete :destroy, params: {:id => supply_category.to_param}, session: valid_session
      response.should redirect_to(supply_categories_url)
    end
  end

end
