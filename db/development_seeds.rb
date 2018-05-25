def seed_development_data
  User.create(id: 1,
              name: 'Admin Bob',
              auth_id: 1234,
              email: 'admin_email@domain.com',
              admin: true,
              active: true)
end
