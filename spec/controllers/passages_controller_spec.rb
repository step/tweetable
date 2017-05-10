require 'rails_helper'

RSpec.describe PassagesController, type: :controller do

  let(:valid_attributes) {
    {
        title: "title",
        text: "passage text",
        duration: "1234"
    }
  }

  let(:invalid_attributes) {
    {
      duration: 1234
  } }

  describe "POST #create" do
    before(:each) do
      user = User.create! auth_id: "auth_id"
      controller.session[:user_id] = user.auth_id
    end

    context "with valid params" do
      it "creates a new Passage" do
        expect {
          post :create, params: {passage: valid_attributes}, session: valid_session
        }.to change(Passage, :count).by(1)
      end

      it "redirects to the created passage" do
        post :create, params: {passage: valid_attributes}, session: valid_session
        expect(response).to redirect_to(Passage)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: {passage: invalid_attributes}, session: valid_session
        expect(response).to be_success
      end
    end
  end

  # describe "PUT #update" do
  #   context "with valid params" do
  #     let(:new_attributes) {
  #       skip("Add a hash of attributes valid for your model")
  #     }
  #
  #     it "updates the requested passage" do
  #       passage = Passage.create! valid_attributes
  #       put :update, params: {id: passage.to_param, passage: new_attributes}, session: valid_session
  #       passage.reload
  #       skip("Add assertions for updated state")
  #     end
  #
  #     it "redirects to the passage" do
  #       passage = Passage.create! valid_attributes
  #       put :update, params: {id: passage.to_param, passage: valid_attributes}, session: valid_session
  #       expect(response).to redirect_to(passage)
  #     end
  #   end
  #
  #   context "with invalid params" do
  #     it "returns a success response (i.e. to display the 'edit' template)" do
  #       passage = Passage.create! valid_attributes
  #       put :update, params: {id: passage.to_param, passage: invalid_attributes}, session: valid_session
  #       expect(response).to be_success
  #     end
  #   end
  # end

  # describe "DELETE #destroy" do
  #   it "destroys the requested passage" do
  #     passage = Passage.create! valid_attributes
  #     expect {
  #       delete :destroy, params: {id: passage.to_param}, session: valid_session
  #     }.to change(Passage, :count).by(-1)
  #   end
  #
  #   it "redirects to the passages list" do
  #     passage = Passage.create! valid_attributes
  #     delete :destroy, params: {id: passage.to_param}, session: valid_session
  #     expect(response).to redirect_to(passages_url)
  #   end
  # end

end
