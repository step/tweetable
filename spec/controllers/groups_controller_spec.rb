# frozen_string_literal: true

describe GroupsController do
  let(:groups) {
    [
        {
            name: 'step-15-17', description: '4th batch'
        }
    ]
  }

  context 'admin specific features' do
    before(:each) do
      stub_logged_in(true)
      stub_current_active_admin_user
    end

    describe 'POST #create' do
      context 'with valid params' do
        it 'redirects to the created passage' do
          group = double('group')
          valid_attributes = {name: 'step-17-19', description: '5th batch'}
          expect(Group).to receive(:new).and_return(group)
          expect(group).to receive(:save).and_return(true)

          post :create, params: {group: valid_attributes}

          expect(response).to redirect_to(groups_path)
          expect(flash[:success]).to match('Group was successfully created.')
        end
      end
      context 'with invalid params' do
        it "returns a success response (i.e. to display the 'new' template)" do
          group = double('group')
          invalid_attributes = {name:''}

          expect(Group).to receive(:new).and_return(group)
          expect(group).to receive(:save).and_return(false)
          allow_any_instance_of(GroupsController).to receive(:display_flash_error)

          post :create, params: {group: invalid_attributes}

          expect(response).to redirect_to(new_group_path)
        end
      end
    end
  end
end
