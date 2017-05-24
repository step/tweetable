RSpec.describe PassagesController, type: :controller do

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

  let(:users) {

    [
        {
            name: 'Kamal Hasan', admin: false, auth_id: '132271', image_url: 'http://graph.facebook.com/demo1'
        },
        {
            name: 'Vimal Hasan', admin: false, auth_id: '132273', image_url: 'http://graph.facebook.com/demo1'
        },
        {
            name: 'Rajanikanth', admin: false, auth_id: '132272', image_url: 'http://graph.facebook.com/demo2'
        }
    ]
  }

  let(:passages) {
    [
        {
            title: 'Climate Change', text: 'climate change passage', start_time: DateTime.now, close_time: (DateTime.now+2), duration: '1'
        },

        {
            title: 'Person', text: 'person passage', start_time: DateTime.now, close_time: (DateTime.now+1), duration: '2'
        },

        {
            title: 'News', text: 'news passage', start_time: (DateTime.now-2), close_time: (DateTime.now-1), duration: '2'
        },
        {
            title: 'Program', text: 'program passage', start_time: (DateTime.now-3), close_time: (DateTime.now+1), duration: '2'
        },
        {
            title: 'Class', text: 'class passage', start_time: (DateTime.now-3), close_time: (DateTime.now-1), duration: '2'
        }
    ]

  }
  let(:responses) {[
      {
          text: "respose for Climate Changed", user_id: User.find_by(auth_id: '132271').id, passage_id: Passage.find_by(title: 'Climate Change').id
      },
      {
          text: "respose for Climate Changed", user_id: User.find_by(auth_id: '132273').id, passage_id: Passage.find_by(title: 'Climate Change').id
      },
      {
          text: "respose for Person", user_id: User.find_by(auth_id: '132271').id, passage_id: Passage.find_by(title: 'Person').id
      },
      {
          text: "respose for Person", user_id: User.find_by(auth_id: '132273').id, passage_id: Passage.find_by(title: 'Person').id
      },
      {
          text: "News Response", user_id: User.find_by(auth_id: '132273').id, passage_id: Passage.find_by(title: 'News').id
      }
  ]
  }
  before(:each) do
    stub_logged_in(true)
  end

  describe 'POST #create' do

    context 'with valid params' do
      it 'redirects to the created passage' do
        post :create, params: {passage: valid_attributes}
        expect(response).to redirect_to(passages_path)
        expect(flash[:success]).to match('Passage was successfully created.')
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: {passage: invalid_attributes}
        expect(response).to redirect_to(new_passage_path)
        expect(flash[:danger]).to match("Text can't be blank")
      end
    end
  end

  describe 'filter methods' do
    before(:each) do
      @passages = Passage.create!(passages)
    end

    after(:each) do
      @passages.each(&:delete)
    end

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
      it 'should give all the yet to open passages' do
        get :opened
        expect(response).to be_success
        should render_template('passages/admin/passages_pane',)
      end

      it 'redirects to the created passage' do
        expect(Passage).to receive(:open_passages)
        get :opened
      end
    end

    describe "GET #closed" do
      it 'should give all the yet to open passages' do
        get :closed
        expect(response).to be_success
        should render_template('passages/admin/passages_pane',)
      end

      it 'redirects to the created passage' do
        expect(Passage).to receive(:closed_passages)
        get :closed
      end
    end

    describe "GET #open_for_candidate" do
      it 'should give all the yet to open passages' do
        stub_current_user(double('User', passages: []))
        get :open_for_candidate
        expect(response).to be_success
        should render_template('passages/candidate/passages_pane',)
      end

      it 'redirects to the created passage' do
        expect(Passage).to receive(:open_for_candidate).with(@user)
        get :open_for_candidate
      end
    end

  end

end
