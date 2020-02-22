json.extract! usuario, :id, :nombre, :contrasena, :created_at, :updated_at
json.url usuario_url(usuario, format: :json)
