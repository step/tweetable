# frozen_string_literal: true

describe PassagesController do
  let(:passages) do
    [
      {
        title: 'Climate Change', text: 'climate change passage', commence_time: Time.current, conclude_time: (Time.current + 2), duration: '1'
      }
    ]
  end

  context 'admin specific features' do
    before(:each) do
      stub_logged_in(true)
      stub_current_active_admin_user
    end

    describe 'POST #create' do
      context 'with valid params' do
        it 'redirects to the created passage' do
          passage = double('passage')
          valid_attributes = { title: 'title', duration: 1234 }

          expect(Passage).to receive(:new).and_return(passage)
          expect(passage).to receive(:save).and_return(true)

          post :create, params: { passage: valid_attributes }

          expect(response).to redirect_to(passages_path)
          expect(flash[:success]).to match('Passage was successfully created.')
        end
      end

      context 'with invalid params' do
        it "returns a success response (i.e. to display the 'new' template)" do
          passage = double('passage')
          invalid_attributes = { title: 'title', text: 'passage text', duration: '1234' }

          expect(Passage).to receive(:new).and_return(passage)
          expect(passage).to receive(:save).and_return(false)
          allow_any_instance_of(PassagesController).to receive(:display_flash_error)

          post :create, params: { passage: invalid_attributes }

          expect(response).to redirect_to(new_passage_path)
        end
      end
    end

    describe 'POST #update' do
      context 'with valid params' do
        it 'redirects to the created passage' do
          passage = double('passage')
          valid_attributes = { title: 'title', duration: 1234 }

          expect(Passage).to receive(:find).and_return(passage)
          allow_any_instance_of(PassagesController).to receive(:permit_params).and_return(valid_attributes)
          expect(passage).to receive(:update_attributes).with(valid_attributes).and_return(true)

          post :update, params: { id: 'id', passage: valid_attributes }

          expect(response).to redirect_to(passages_path)
          expect(flash[:success]).to match('Passage was successfully updated.')
        end
      end

      context 'with invalid params' do
        it "returns a success response (i.e. to display the 'new' template)" do
          passage = double('passage')
          valid_attributes = { title: 'title', text: 'passage text', duration: '1234' }

          expect(Passage).to receive(:find).and_return(passage)
          allow_any_instance_of(PassagesController).to receive(:display_flash_error)
          allow_any_instance_of(PassagesController).to receive(:permit_params).and_return(valid_attributes)
          expect(passage).to receive(:update_attributes).with(valid_attributes).and_return(false)

          post :update, params: { id: 'id', passage: valid_attributes }

          expect(response).to redirect_to(edit_passage_path)
        end
      end
    end

    describe 'DELETE #destroy' do
      context 'with passage id' do
        it 'should delete the passage' do
          @passages = Passage.create!(passages)

          passage_find_by = Passage.find_by(title: 'Climate Change')
          delete :destroy, params: { id: passage_find_by.id }

          expect(Passage.find_by(title: 'Climate Change')).to eq(nil)
          expect(response).to redirect_to(passages_path)

          @passages.each(&:delete)
        end
      end
    end

    describe 'GET #edit' do
      it 'should give edit form for the passage' do
        passage = double('Passage', text: 'This is a passage text')

        expect(Passage).to receive(:find).with('12').and_return(passage)
        get :edit, params: { id: 12 }
        should render_template('passages/new')
      end
    end

    describe 'PUT #commence' do
      it 'should commence the passage' do
        past_time = Time.current + 2.days
        passage = double('Passage', commence: true)
        expect(Passage).to receive(:find).and_return(passage)
        put :commence, params: { id: 12, passage: { conclude_time: past_time } }
        expect(response).to redirect_to(passages_path)
      end

      it 'should not commence the passage' do
        past_time = Time.current - 1.days
        errors = double('Errors', messages: [['conclude_time', 'must be a future time']])
        passage = double('Passage', errors: errors)

        expect(passage).to receive(:commence)
        expect(Passage).to receive(:find).and_return(passage)

        put :commence, params: { id: 12, passage: { conclude_time: past_time } }

        expect(flash[:danger]).to eq('Conclude time must be a future time')
        expect(response).to redirect_to(passages_path)
      end
    end
  end

  describe 'filter methods' do
    context 'admin filters' do
      before(:each) do
        stub_current_active_admin_user
      end

      describe 'GET #drafts' do
        it 'should give all the yet to open passages' do
          get :drafts, params: { from_tab: true }
          expect(response).to be_success
          expect(flash[:danger]).to be_nil
          should render_template('passages/admin/passages_pane')
        end
      end

      describe 'GET #opened' do
        it 'should give all the yet to open passages' do
          get :ongoing, params: { from_tab: true }
          expect(response).to be_success
          expect(flash[:danger]).to be_nil
          should render_template('passages/admin/passages_pane')
        end
      end

      describe 'GET #concluded' do
        it 'should give all the yet to concluded passages' do
          get :concluded, params: { from_tab: true }

          expect(response).to be_success
          should render_template('passages/admin/passages_pane')
        end
      end
    end

    context 'candidate filters' do
      before(:each) do
        stub_current_active_intern_user
      end

      describe 'GET #commenced' do
        it 'should give all the yet to open passages' do
          expect(Passage).to receive(:commence_for_candidate)

          get :commenced

          expect(response).to be_success
          should render_template('passages/candidate/passages_pane')
        end
      end

      describe 'GET #missed' do
        it 'should give all the missed passages by user' do
          expect(Passage).to receive(:missed_by_candidate)

          get :missed

          expect(response).to be_success
          should render_template('passages/candidate/passages_pane')
        end
      end

      describe 'GET #attempted' do
        it 'should give all the passages that are already attempted by candidate' do
          expect(Passage).to receive(:attempted_by_candidate)

          get :attempted

          expect(response).to be_success
          should render_template('passages/candidate/attempted_passages_pane')
        end
      end
    end
  end

  describe 'validations' do
    before(:each) do
      stub_current_active_intern_user
    end

    it 'should not allow candidate to create a passage' do
      expect { post :create }.to raise_error(ActionController::RoutingError)
    end

    it 'should not allow candidate to edit a passage' do
      expect { post :update, params: { id: 'some_id' } }.to raise_error(ActionController::RoutingError)
    end

    it 'should not allow candidate to commence a passage' do
      expect { post :commence, params: { id: 'some_id' } }.to raise_error(ActionController::RoutingError)
    end

    it 'should not allow candidate to conclude a passage' do
      expect { post :conclude, params: { id: 'some_id' } }.to raise_error(ActionController::RoutingError)
    end

    it 'should not have access to concluded passages' do
      expect { get :concluded }.to raise_error(ActionController::RoutingError)
    end

    it 'should not have access to opened passages' do
      expect { get :ongoing }.to raise_error(ActionController::RoutingError)
    end

    it 'should not have access to drafts passages' do
      expect { get :drafts }.to raise_error(ActionController::RoutingError)
    end
  end
end
