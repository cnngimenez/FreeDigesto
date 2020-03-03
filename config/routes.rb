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

  get 'pagina_principal', to: 'pagina_principal#index'
  get 'banner', to: 'banner#index'
  get 'cambio_estados_a_vencer', to: 'cambio_estados_a_vencer#index'

  get 'buscar_por_descriptores', to: 'buscar_desc_part#index'
  get 'buscar_por_descriptores/index'
  get 'buscar_por_descriptores/buscar_desc_part'
  get 'buscar_por_descriptores/elegir_desc_part'
  get 'buscar_por_descriptores/otras_opciones'
  get 'buscar_por_descriptores/buscar_normas'
  get 'buscar_por_descriptores/vista_impresion'

  get 'buscar_por_fecha', to: 'buscar_por_fecha#index'
  get 'buscar_por_fecha/index'
  get 'buscar_por_fecha/resultados'
  get 'buscar_por_fecha/vista_impresion'

  get 'buscar_por_texto', to: 'buscar_por_texto#index'
  get 'buscar_por_texto/index'
  get 'buscar_por_texto/buscar_texto'
  get 'buscar_por_texto/vista_impresion'  
  
  get 'buscar_por_numero', to: 'buscar_por_numero#index'
  get 'buscar_por_numero/index'
  get 'buscar_por_numero/buscar_numero'
  get 'buscar_por_numero/vista_impresion'
  
  get ':controller/:action/:id'
  get ':controller/:action/:id.:format'
end
