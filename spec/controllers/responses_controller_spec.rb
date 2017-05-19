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
end