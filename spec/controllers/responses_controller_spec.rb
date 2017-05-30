describe ResponsesController, type: :controller do

  describe 'GET #new' do

    let(:passage) {Passage.new(id: 1)}

    context 'When passage id exists' do

      it 'renders the new template' do
        stub_logged_in(true)
        user = double('User', admin: false, id: 1)
        stub_current_user(user)

        expect(Passage).to receive(:find).and_return(passage)
        expect(ResponsesTracking).to receive(:remaining_time).and_return(6000)

        get :new, params: {passage_id: passage.id}

        expect(response).to render_template(:new)
      end
    end

    context 'When passage does not exists' do

      it 'renders the new template' do
        stub_logged_in(true)
        get :new, params: {passage_id: passage.id}
        expect(response).to redirect_to(passages_path)
      end
    end
  end

  describe 'Post #create' do

    let(:passage) {Passage.create(title: 'Test passage title', text: 'Test passage text', duration: 1)}
    let(:intern) {User.create(name: 'Intern', auth_id: '1243234324')}

    context 'When user and passage exists' do
      context 'When Responding time is over' do
        context 'Response length is valid' do
          it 'should create  response' do
            stub_logged_in(true)
            user = double('User', admin: false, id: 1)
            stub_current_user(user)
            expect(ResponsesTracking).to receive(:remaining_time).and_return(0)

            post :create, params: {passage_id: passage.id, user_id: intern.id, text: 'Response to test passage'}
            expect(response).to redirect_to(passages_path)
            expect(flash[:danger]).to match('Your response submission time is expired!')
          end
        end
        context 'Response length is invalid' do
          it 'should not create  response' do
            stub_logged_in(true)
            user = double('User', admin: false, id: 1)
            stub_current_user(user)
            expect(ResponsesTracking).to receive(:remaining_time).and_return(-1)

            post :create, params: {passage_id: passage.id, user_id: intern.id, text: 'This is an invalid response because its contains more that 140 characters. This is an invalid response because its contains more that 140 chars.'}
            expect(response).to redirect_to(passages_path)
            expect(flash[:danger]).to match('Your response submission time is expired!')
          end
        end
      end
      context 'When Responding time is not over' do
        context 'Response length is valid' do
          it 'should create  response' do
            stub_logged_in(true)
            user = double('User', admin: false, id: 1)
            stub_current_user(user)
            expect(ResponsesTracking).to receive(:update_end_time)
            expect(ResponsesTracking).to receive(:remaining_time).and_return(2)

            post :create, params: {passage_id: passage.id, user_id: intern.id, text: 'Response to test passage'}
            expect(response).to redirect_to(passages_path)
            expect(flash[:success]).to match('Response was successfully created.')
          end
        end
        context 'Response length is invalid' do
          it 'should not create  response' do
            stub_logged_in(true)
            user = double('User', admin: false, id: 1)
            stub_current_user(user)
            expect(ResponsesTracking).to receive(:remaining_time).and_return(2)

            post :create, params: {passage_id: passage.id, user_id: intern.id, text: 'This is an invalid response because its contains more that 140 characters. This is an invalid response because its contains more that 140 chars.'}
            expect(response).to redirect_to(new_passage_response_path(passage))
            expect(flash[:danger]).to match('Response was invalid!')
          end
        end
      end
    end
  end
end
