json.extract! tipo_relacion, :id, :nombre, :comentario, :created_at, :updated_at
json.url tipo_relacion_url(tipo_relacion, format: :json)
