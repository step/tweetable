RSpec.describe PassagesController, type: :controller do

  let(:valid_attributes) {
    {
        title: "title",
        text: "passage text",
        duration: "1234"
    }
  }

  let(:invalid_attributes) {
    {
        duration: 1234
    }}

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

  describe "POST #create" do

    context "with valid params" do
      it "creates a new Passage" do
        expect {
          post :create, params: {passage: valid_attributes}
        }.to change(Passage, :count).by(1)

      end

      it "redirects to the created passage" do
        post :create, params: {passage: valid_attributes}
        expect(response).to redirect_to(passages_url)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: {passage: invalid_attributes}
        expect(response).to be_success
      end
    end
  end

  describe "filter methods" do
    before(:each) do
      @passages = Passage.create!(passages)
    end

    after(:each) do
      @passages.each(&:delete)
    end

    describe "GET #drafts" do
      it 'should give all the yet to open passages' do
        get :drafts
        expect(response).to be_success
        should render_template('passages/admin/passages_pane',)
      end

      it 'redirects to the created passage' do
        expect(Passage).to receive(:draft_passages)
        get :drafts
      end
    end

    describe "GET #opened" do
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
