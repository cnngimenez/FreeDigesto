Rails.application.routes.draw do
  resources :relaciona_con_normas
  resources :tipo_relacions
  resources :cambio_aplicados
  resources :cambio_estados
  resources :causa_cambio_estados
  resources :logins
  resources :agregar_privilegios
  resources :patron_privilegios
  resources :tiene_privilegios
  resources :privilegios
  resources :usuarios
  resources :posee_desc_parts
  resources :posee_descriptors
  resources :normas
  resources :tipo_normas
  resources :descriptor_particulars
  resources :descriptor_generals
  resources :lugar_publicacions
  resources :estados
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
