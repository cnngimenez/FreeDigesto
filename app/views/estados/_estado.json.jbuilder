json.extract! estado, :id, :nombre, :comentario, :created_at, :updated_at
json.url estado_url(estado, format: :json)
