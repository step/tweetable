json.extract! user, :id, :name, :admin, :auth_id, :created_at, :updated_at
json.url user_url(user, format: :json)
