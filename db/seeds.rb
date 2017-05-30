# --------------- User Seeds ---------------------
User.create(
    [
        {
            name: 'Kamal Hasan', admin: false, auth_id: '132271', image_url: 'http://graph.facebook.com/demo1'
        },
        {
            name: 'Vimal Hasan', admin: false, auth_id: '132273', image_url: 'http://graph.facebook.com/demo1'
        },
        {
            name: 'Rajanikanth', admin: true, auth_id: '132272', image_url: 'http://graph.facebook.com/demo2'
        }
    ]
)

# --------------- Passage Seeds ---------------------

Passage.create(
    [
        {
            title: 'Climate Change', text: 'climate change passage', start_time: Time.current, close_time: (Time.current+2), duration: '3600'
        },

        {
            title: 'Person', text: 'person passage', start_time: Time.current, close_time: (Time.current+1), duration: '7200'
        },
        {
            title: 'Program', text: 'program passage', start_time: (Time.current-3), close_time: (Time.current+1), duration: '7200'
        },
        {
            title: 'Computer', text: 'computer passage', start_time: (Time.current+3), close_time: (Time.current+7), duration: '7200'
        },
        {
            title: 'Human', text: 'human passage', start_time: nil, close_time: nil, duration: '7200'
        }
    ]
)

Passage.new(title: 'News', text: 'news passage', start_time: (Time.current-2), close_time: (Time.current-1), duration: '7200').save(validate: false)
Passage.new(title: 'Class', text: 'class passage', start_time: (Time.current-3), close_time: (Time.current-1), duration: '7200').save(validate: false)


# --------------- Response Seeds ---------------------

Response.create(
    [
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
)

# --------------- Tag Seeds ---------------------

Tag.create(
    [
        {
            name: 'Grammatical Error', weight: -5, description: 'something'
        },
        {
            name: 'Grammatical Excellence', weight: 5, description: 'something'
        },
        {
            name: 'Vocabulary', weight: 4, description: 'something'
        }
    ]
)

# --------------- Tagging Seeds ---------------------

Tagging.create(
    [
        {
            response_id: Response.find_by(text: 'respose for Climate Changed').id, tag_id: Tag.find_by(name: 'Grammatical Error').id
        },
        {
            response_id: Response.find_by(text: 'respose for Person').id, tag_id: Tag.find_by(name: 'Grammatical Excellence').id
        }
    ]
)

