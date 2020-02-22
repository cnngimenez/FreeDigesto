json.extract! login, :id, :nombre_usuario, :clave, :created_at, :updated_at
json.url login_url(login, format: :json)
