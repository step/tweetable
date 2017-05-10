# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create([{name: 'Kamal Hasan', admin:false, auth_id: '132271', image_url: 'http://graph.facebook.com/demo1'},
              {name: 'Rajanikanth', admin:true, auth_id: '132272', image_url: 'http://graph.facebook.com/demo2'}])