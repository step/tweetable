# frozen_string_literal: true
def seed_test_data

  climate_change_passage = 'Investigating what is sometimes seen as one of the more favorable effects of
climate change, a pair of scientists from UCLA has done a careful analysis of the melting
 of Arctic sea ice and concluded that it could lead to ships traversing the ice-free Northwest
 Passage (NWP) by 2050. It would also lead to much shorter transit times through the
existing North Sea Passage (NSR). These developments may greatly reduce the time and cost
of shipping but would also lead to unforeseen economic and geopolitical complications.'.freeze

  person_passage = 'This passage was very moving to me. The story finally comes full circle,
and Amir is able to come to terms with himself. I think that the fact that he quoted Hassan
 when Hassan went to run his winning kite shows that Amir realizes now how incredibly
important he was to Hassan, because he now feels the same about Hassan’s son, Sohrab.
 What do you think this passage means for Amir and Sohrab’s relationship in the future?
Do you think Amir would love Sohrab equally and/or in the same way that he would love his own
biological son? Why?'.freeze

  program_passage = 'The Brotherhood/Sister Sol’s Rites of Passage (ROP) Program is the foundation
of the organization. Our goal is to empower youth through discovery and discussion of history,
culture, social problems, and the political forces surrounding them. We establish partnerships
with public secondary schools to develop gender-specific (Brotherhood or Sister Sol) chapters,
each consisting of 10 to 18 youth members and two adult Chapter Leaders. The Chapter Leaders
facilitate weekly sessions and serve as mentors, supporters, confidantes, counselors, teachers,
and more. They build trusting relationships and offer guidance to the chapter members as they
face the challenges of young adulthood.'.freeze

  computer_passage = 'Now computers have noticeable impact on social relations. They have enabled
entirely new forms of social interaction, activities, and organizing. With the Internet, working
with computers has become part of our daily lives thanks to its basic features such as widespread
usability and access. In addition to face to face communication that characterized humans for centuries,
a new form of virtual communication has become more predominant.'.freeze

  human_passage = 'There is compelling evidence that both human immunodeficiency virus (HIV) types emerged
from two dissimilar simian immunodeficiency viruses (SIVs) in separate geographical regions of Africa.
Each of the two HIVs has its own simian progenitor and specific genetic precursor, and all of the primates
that carry these SIVs have been in close contact with humans for thousands of years without the emergence of
epidemic HIV. To date no plausible mechanism has been identified to account for the sudden emergence in
the mid-20th century of these epidemic HIVs. In this study we examine the conditions needed for SIV to
complete the genetic transition from individual human SIV infections to epidemic HIV in humans.
The genetic distance from SIV to HIV and the mutational activity needed to achieve this degree of adaptation
to human hosts is placed within a mathematical model to estimate the probabilities of SIV completing this
transition within a single SIV-infected human host'.freeze

  # --------------- User Seeds ---------------------
  intern_role_id = Role.intern.id
  User.create(
      [
          {
              name: 'Kamal Hasan', role_id: intern_role_id, email: 'kamalhasan@email.com', auth_id: '132271', image_url: 'http://images.indianexpress.com/2015/02/kamal-hassan-759.jpg'
          },
          {
              name: 'Vimal Hasan', role_id: intern_role_id, email: 'vimalhasan@email.com', auth_id: '132273', image_url: 'http://images.indianexpress.com/2015/02/kamal-hassan-759.jpg'
          },
          {
              name: 'Rajanikanth', role_id: intern_role_id, email: 'rajinikanth@email.com', auth_id: '132272', image_url: 'http://www.tehelka.com/wp-content/uploads/2015/09/Rajnikanth-300x270.jpg'
          }
      ]
  )

  # --------------- Passage Seeds ---------------------

  Passage.create(
      [
          {
              title: 'Climate Change', text: climate_change_passage, commence_time: Time.current, conclude_time: (Time.current + 2.days.days), duration: '3600'
          },

          {
              title: 'Person', text: person_passage, commence_time: Time.current, conclude_time: (Time.current + 1.days), duration: '7200'
          },
          {
              title: 'Program', text: program_passage, commence_time: (Time.current - 3.days), conclude_time: (Time.current + 1.days), duration: '7200'
          },
          {
              title: 'Computer', text: computer_passage, commence_time: (Time.current + 3.days), conclude_time: (Time.current + 7.days), duration: '7200'
          },
          {
              title: 'Human', text: human_passage, commence_time: nil, conclude_time: nil, duration: '7200'
          }
      ]
  )

  Passage.new(title: 'News', text: 'news passage', commence_time: (Time.current - 2.days), conclude_time: (Time.current - 1.days), duration: '7200').save(validate: false)
  Passage.new(title: 'Class', text: 'class passage', commence_time: (Time.current - 3.days), conclude_time: (Time.current - 1.days), duration: '7200').save(validate: false)


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
              name: 'Error', weight: -5, description: 'something'
          },
          {
              name: 'Excellence', weight: 5, description: 'something'
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
              response_id: Response.find_by(text: 'respose for Climate Changed').id, tag_id: Tag.find_by(name: 'Error').id
          },
          {
              response_id: Response.find_by(text: 'respose for Person').id, tag_id: Tag.find_by(name: 'Excellence').id
          }
      ]
  )

end