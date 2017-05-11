# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(
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

Passage.create!(
    [
        {
            title: 'Climate Changed', text: 'Climate change will have serious implications as numerous adverse impacts are expected in terms of access to clean water,
food and ecosystem resources. By 2020, it is feared that in some African countries yields from rain fed agriculture could be reduced by up to 50%.', start_time: '02 May 2017', close_time: '02 May 2017', duration: '1', status: 'OPEN'
        },

        {
            title: 'Person', text: 'hello world', start_time: '02 May 2017', close_time: '02 May 2017', duration: '2', status: 'OPEN'
        },

        {
            title: 'Missed person', text: 'hello world', start_time: '02 May 2017', close_time: '02 May 2017', duration: '2', status: 'CLOSED'
        },
        {
            title: 'OPEN without responses', text: 'hello world', start_time: '02 May 2017', close_time: '02 May 2017', duration: '2', status: 'OPEN'
        },
        {
            title: 'CLOSED without responses', text: 'hello world', start_time: '02 May 2017', close_time: '02 May 2017', duration: '2', status: 'CLOSED'
        }
    ]
)

Response.create!(
    [
        {
            text: "First respose for Climate Changed", user_id: User.find_by(auth_id: '132271').id, passage_id: Passage.find_by(title: 'Climate Changed').id
        },
        {
            text: "Second respose for Climate Changed", user_id: User.find_by(auth_id: '132273').id, passage_id: Passage.find_by(title: 'Climate Changed').id
        },
        {
            text: "First respose for Person", user_id: User.find_by(auth_id: '132271').id, passage_id: Passage.find_by(title: 'Person').id
        },
        {
            text: "Second respose for Person", user_id: User.find_by(auth_id: '132273').id, passage_id: Passage.find_by(title: 'Person').id
        },
        {
            text: "First respose for Missed person", user_id: User.find_by(auth_id: '132271').id, passage_id: Passage.find_by(title: 'Missed person').id
        },
        {
            text: "Second respose for Missed person", user_id: User.find_by(auth_id: '132273').id, passage_id: Passage.find_by(title: 'Missed person').id
        }
    ]
)

Tag.create!(
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

Tagging.create!(
           [
               {
                   response_id:Response.find_by(text:'First respose for Climate Changed').id, tag_id:Tag.find_by(name:'Grammatical Error').id
               },
               {
                   response_id:Response.find_by(text:'Second respose for Climate Changed').id, tag_id:Tag.find_by(name:'Grammatical Excellence').id
               }
           ]
)

