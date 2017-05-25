describe PassagesController do

  let(:valid_attributes) {
    {
        title: 'title',
        text: 'passage text',
        duration: '1234'
    }
  }

  let(:invalid_attributes) {
    {
        title: 'title',
        duration: 1234
    }
  }

  let(:passages) {
    [
        {
            title: 'Climate Change', text: 'climate change passage', start_time: DateTime.now, close_time: (DateTime.now+2), duration: '1'
        }
    ]
  }

  before(:each) do
    stub_logged_in(true)
  end

  describe 'POST #create' do

    context 'with valid params' do
      it 'redirects to the created passage' do
        passage = double('passage')
        expect(Passage).to receive(:new).and_return(passage)
        expect(passage).to receive(:save).and_return(true)
        post :create, params: {passage: valid_attributes}
        expect(response).to redirect_to(passages_path)
        expect(flash[:success]).to match('Passage was successfully created.')
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'new' template)" do
        passage = double('passage')
        expect(Passage).to receive(:new).and_return(passage)
        expect(passage).to receive(:save).and_return(false)
        allow_any_instance_of(PassagesController).to receive(:flash_error)

        post :create, params: {passage: invalid_attributes}
        expect(response).to redirect_to(new_passage_path)
      end
    end
  end


  describe 'POST #update' do

    context 'with valid params' do
      it 'redirects to the created passage' do
        passage = double('passage')

        expect(Passage).to receive(:find).and_return(passage)
        allow_any_instance_of(PassagesController).to receive(:permit_params).and_return(valid_attributes)
        expect(passage).to receive(:update_attributes).with(valid_attributes).and_return(true)

        post :update, params: {id: 'id', passage: valid_attributes}

        expect(response).to redirect_to(passages_path)
        expect(flash[:success]).to match('Passage was successfully updated...')
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'new' template)" do
        passage = double('passage')

        expect(Passage).to receive(:find).and_return(passage)
        allow_any_instance_of(PassagesController).to receive(:flash_error)
        allow_any_instance_of(PassagesController).to receive(:permit_params).and_return(valid_attributes)
        expect(passage).to receive(:update_attributes).with(valid_attributes).and_return(false)

        post :update, params: {id: 'id', passage: valid_attributes}

        expect(response).to redirect_to(edit_passage_path)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'with passage id' do
      it 'should delete the passage' do
        @passages = Passage.create!(passages)

        passage_find_by = Passage.find_by(title: 'Climate Change')
        delete :destroy, params: {id: passage_find_by.id}

        expect(Passage.find_by(title: 'Climate Change')).to eq(nil)
        expect(response).to redirect_to(passages_path)

        @passages.each(&:delete)
      end
    end

  end

  describe 'GET #edit' do
    it 'should give edit form for the passage' do
      passage = double('Passage',text:'This is a passage text')

      expect(Passage).to receive(:find).with('12').and_return(passage)
      get :edit, params: {id: 12}
      should render_template('passages/new')
    end
  end

  describe 'filter methods' do
    describe 'GET #drafts' do
      context 'Admin' do
        before(:each) do
          user = double('User', admin: true)
          stub_current_user(user)
        end

        context 'When the request is generated withing the tabs' do

          it 'should give all the yet to open passages' do
            get :drafts, params: {from_tab: true}
            expect(response).to be_success
            expect(flash[:danger]).to be_nil
            should render_template('passages/admin/passages_pane',)
          end

        end
        context 'When the request is generated out side of the tabs' do
          it 'redirects to the created passage' do
            get :drafts
            should redirect_to(passages_path)
          end
        end

      end

      context 'Candidate' do
        before(:each) do
          user = double('User', admin: false)
          stub_current_user(user)
        end
        it 'should not have access to drafts passages' do
          get :drafts
          expect(flash[:danger]).to match("Either the resource you have requested does not exist or you don't have access to them")
          should redirect_to(passages_path)
        end
      end
    end

    describe 'GET #opened' do
      context 'Admin' do
        before(:each) do
          user = double('User', admin: true)
          stub_current_user(user)
        end
        context 'When the request is generated withing the tabs' do
          it 'should give all the yet to open passages' do
            get :opened, params: {from_tab: true}
            expect(response).to be_success
            expect(flash[:danger]).to be_nil
            should render_template('passages/admin/passages_pane',)
          end
        end
        context 'When the request is generated out side of the tabs' do
          it 'redirects to the created passage' do
            get :opened
            should redirect_to(passages_path)
          end
        end
      end
      context 'Candidate' do
        before(:each) do
          user = double('User', admin: false)
          stub_current_user(user)
        end
        it 'should not have access to opened passages' do
          get :opened
          expect(flash[:danger]).to match("Either the resource you have requested does not exist or you don't have access to them")
          should redirect_to(passages_path)
        end
      end
    end

    describe 'GET #closed' do

      context 'Admin' do
        before(:each) do
          user = double('User', admin: true)
          stub_current_user(user)
        end
        context 'When the request is generated withing the tabs' do
          it 'should give all the yet to closed passages' do
            get :closed, params: {from_tab: true}

            expect(flash[:danger]).to be_nil
            expect(response).to be_success
            should render_template('passages/admin/passages_pane',)
          end
        end
        context 'When the request is generated out side of the tabs' do
          it 'redirects to the passages page with respective tab open' do

            get :closed
            expect(flash[:danger]).to be_nil
            should redirect_to(passages_path)

          end
        end
      end

      context 'Candidate' do
        before(:each) do
          user = double('User', admin: false)
          stub_current_user(user)
        end
        it 'should not have access to closed passages' do
          get :closed
          expect(flash[:danger]).to match("Either the resource you have requested does not exist or you don't have access to them")
          should redirect_to(passages_path)
        end
      end
    end

    describe 'PUT #roll_out' do
      it 'should roll out the passage' do
        past_time = DateTime.now+2.days
        passage = double('Passage')
        expect(passage).to receive(:roll_out)
        expect(Passage).to receive(:find).and_return(passage)
        put :roll_out, params: {id: 12, passage: {close_time: past_time}}
        expect(response).to redirect_to(passages_path)
      end
    end

    describe 'GET #open_for_candidate' do
      it 'should give all the yet to open passages' do
        stub_current_user(double('User', passages: []))
        get :open_for_candidate, params: {from_tab: true}
        expect(response).to be_success
        should render_template('passages/candidate/passages_pane',)
      end
    end


  end
end
