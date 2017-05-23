describe ResponsesController, type: :controller do

  describe 'GET #new' do

    let(:passage) {Passage.new(id: 1)}

    context 'When passage id exists' do

      it 'renders the new template' do
        stub_logged_in(true)

        expect(Passage).to receive(:find).and_return(passage)

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
      context 'Response length is valid' do
        it 'should create  response' do
          stub_logged_in(true)
          post :create, params: {passage_id: passage.id, user_id: intern.id, text: 'Response to test passage'}
          expect(response).to redirect_to(passages_path)
          expect(flash[:success]).to match('Response was successfully created.')
        end
      end
    end
    context 'Response length is invalid' do
      it 'should not create  response' do
        stub_logged_in(true)
        post :create, params: {passage_id: passage.id, user_id: intern.id, text: 'This is an invalid response because its contains more that 140 characters. This is an invalid response because its contains more that 140 chars.'}
        expect(response).to redirect_to(new_passage_response_path(passage))
        expect(flash[:error]).to match('Response was invalid!')
      end
    end
  end
end
