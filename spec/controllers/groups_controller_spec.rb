# frozen_string_literal: true
# # frozen_string_literal: true
#
# describe GroupsController do
#   let(:groups) do
#     [
#       {
#         name: 'step-15-17', description: '4th batch'
#       }
#     ]
#   end
#
#   context 'admin specific features' do
#     before(:each) do
#       stub_logged_in(true)
#       stub_current_active_admin_user
#     end
#
#     describe 'POST #create' do
#       context 'with valid params' do
#         skip 'redirects to the groups path with success message' do
#           group = double('Group')
#           valid_attributes = { name: 'step-17-19', description: '5th batch' }
#           expect(Group).to receive(:new).and_return(group)
#           expect(group).to receive(:save).and_return(true)
#           expect(group).to receive(:name).and_return valid_attributes[:name]
#
#           post :create, params: { group: valid_attributes }
#
#           expect(response).to redirect_to(groups_path)
#           expect(flash[:success]).to match('Group step-17-19 was successfully created.')
#         end
#       end
#       context 'with invalid params' do
#         skip "returns a error flash msg response (i.e. to display the 'new' template)" do
#           group = double('group')
#           invalid_attributes = { name: '' }
#           errors = double('errors')
#           error = { name: ["can't be blank"] }
#
#           expect(Group).to receive(:new).and_return(group)
#           expect(group).to receive(:save).and_return(false)
#           expect(group).to receive(:errors).and_return(errors)
#           expect(errors).to receive(:messages).and_return error
#
#           post :create, params: { group: invalid_attributes }
#
#           expect(response).to redirect_to(groups_path)
#         end
#       end
#     end
#   end
# end
