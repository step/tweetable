# frozen_string_literal: true

describe ResponsesController, type: :controller do
  describe 'GET #new' do
    let(:passage) { Passage.new(id: 1) }

    before(:each) do
      stub_logged_in(true)
      user_params = { id: 1, active: true }
      stub_current_user_with_attributes(user_params, false)
    end

    context 'When passage id exists' do
      it 'renders the new template' do
        expect(Passage).to receive(:find).and_return(passage)
        expect(ResponsesTracking).to receive(:remaining_time).and_return(6000)

        get :new, params: { passage_id: passage.id }

        expect(response).to render_template(:new)
      end
    end

    context 'When passage does not exists' do
      it 'renders the new template' do
        stub_logged_in(true)
        get :new, params: { passage_id: passage.id }
        expect(response).to redirect_to(passages_path)
      end
    end
  end

  describe 'Post #create' do
    let(:passage) { double('passage', id: 'passage_id', title: 'Test passage title', text: 'Test passage text', duration: 1) }
    let(:intern) { double('intern', id: 'user_id', name: 'Intern', auth_id: 'auth_id', active: true) }

    before(:each) do
      stub_logged_in(true)
      stub_current_user(intern)
    end

    context 'When user and passage exists' do
      context 'When Responding time is over' do
        context 'Response length is valid' do
          it 'should create  response' do
            expect(ResponsesTracking).to receive(:remaining_time).and_return(0)
            expect(Passage).to receive(:find).and_return(passage)

            post :create, params: { passage_id: passage.id, user_id: intern.id, text: 'Response to test passage' }
            expect(response).to redirect_to(passages_path)
            expect(flash[:danger]).to match('Sorry, Your response submission time is expired!')
          end
        end

        context 'Response length is invalid' do
          it 'should not create  response' do
            expect(ResponsesTracking).to receive(:remaining_time).and_return(-1)
            expect(Passage).to receive(:find).and_return(passage)

            post :create, params: { passage_id: passage.id, user_id: intern.id, text: 'This is an invalid response because its contains more that 140 characters. This is an invalid response because its contains more that 140 chars.' }
            expect(response).to redirect_to(passages_path)
            expect(flash[:danger]).to match('Sorry, Your response submission time is expired!')
          end
        end
      end

      context 'When Responding time is not over' do
        let(:response) { double('response') }

        context 'Response length is valid' do
          it 'should create  response' do
            expect(ResponsesTracking).to receive(:update_end_time)
            expect(ResponsesTracking).to receive(:remaining_time).and_return(2)
            expect(Passage).to receive(:find).and_return(passage)
            expect(Response).to receive(:new).and_return(response)
            expect(response).to receive(:save).and_return(true)

            post :create, params: { passage_id: passage.id, user_id: intern.id, text: 'Response to test passage' }
            expect(response).to redirect_to(passages_path)
            expect(flash[:success]).to match('Your response was successfully recorded.')
          end
        end

        context 'Response length is invalid' do
          it 'should not create  response' do
            expect(ResponsesTracking).to receive(:remaining_time).and_return(2)
            expect(Passage).to receive(:find).and_return(passage)
            expect(Passage).to receive(:find).and_return(passage)
            expect(Response).to receive(:new).and_return(response)
            expect(response).to receive(:save).and_return(false)

            post :create, params: { passage_id: passage.id, user_id: intern.id, text: 'This is an invalid response because its contains more that 140 characters. This is an invalid response because its contains more that 140 chars.' }
            expect(response).to redirect_to(new_passage_response_path(passage))
            expect(flash[:danger]).to match('Sorry, Your response was invalid!')
          end
        end
      end
    end
  end

  describe 'GET #index' do
    context 'When user is Admin' do
      it 'renders the index page with response_evaluation' do
        stub_logged_in(true)
        stub_current_active_admin_user

        passage_id = 'passage_id'
        passage = double('passage')
        responses = double('responses')

        expect(Passage).to receive(:find).with(passage_id).and_return(passage)
        expect(passage).to receive(:responses).and_return(responses)
        expect(responses).to receive(:order).with('created_at DESC')

        get :index, params: { passage_id: passage_id }
        should render_template('index')
      end
    end

    context 'When user is Candidate' do
      it 'renders the new template' do
        stub_logged_in(true)
        stub_current_active_intern_user

        passage_id = 'passage_id'
        passage = double('passage')
        responses = double('responses')

        expect(Passage).to receive(:find).with(passage_id).and_return(passage)
        expect(passage).to receive(:responses).and_return(responses)
        expect(responses).to receive(:order).with('created_at DESC')

        get :index, params: { passage_id: passage_id }
        should render_template('index')
      end
    end
  end
end
