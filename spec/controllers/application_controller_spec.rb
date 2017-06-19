# frozen_string_literal: true

describe ApplicationController, type: :controller do
  describe '#active_user' do
    context 'if the user is active' do
      it 'should return 200' do
        user = double('user')
        expect(controller).to receive(:current_user).and_return(user)
        expect(user).to receive(:active).and_return(true)

        controller.send(:active_user?)

        expect(response).to be_success
      end
    end

    context 'if the user is not active' do
      it 'should redirect to clearance_url' do
        user = double('user')

        expect(controller).to receive(:current_user).and_return(user)
        expect(user).to receive(:active).and_return(false)
        expect(controller).to receive(:redirect_to).with(clearance_url)

        controller.send(:active_user?)
      end
    end
  end
end
