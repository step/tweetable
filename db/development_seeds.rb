def seed_development_data
  role_id = Role.admin.id
  User.create(id: 1,
              name: 'Admin Bob',
              auth_id: 1234,
              email: 'admin_email@domain.com',
              role_id: role_id,
              active: true)
end
