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

  get 'ultimas_normas', to: 'ultimas_normas#index'

  get 'nueva_norma', to: 'nueva_norma#index'
  get 'nueva_norma/guardar_norma'
  get 'nueva_norma/agregar_comentarios'
  get 'nueva_norma/guardar_comentarios'
  get 'nueva_norma/agregar_citas'
  get 'nueva_norma/guardar_citas'
  get 'nueva_norma/subir_texto'
  get 'nueva_norma/guardar_texto'
  get 'nueva_norma/planificar_vencimientos'
  get 'nueva_norma/planificar'
  get 'nueva_norma/otro_plan'
  get 'nueva_norma/crear_relaciones'
  get 'nueva_norma/guardar_relacion'
  get 'nueva_norma/otra_relacion'

  get 'modificar_norma', to: 'modificar_norma#index'
  get 'modificar_norma/buscar_norma'
  get 'modificar_norma/modificar_norma'

  get 'agregar_descriptores', to: 'agregar_descriptores#index'
  get 'agregar_descriptores/seleccionar_desc_gen'
  get 'agregar_descriptores/agregar_desc_gen'
  get 'agregar_descriptores/seleccionar_desc_part'
  get 'agregar_descriptores/agregar_desc_part'
  get 'agregar_descriptores/otro'

  get 'quitar_descriptor', to: 'quitar_descriptor#index'
  get 'quitar_descriptor/quitar_desc_gen'
  get 'quitar_descriptor/quitar_desc_part'
  get 'quitar_descriptor/eliminar_posee_desc'

  get 'asignar_privilegios', to: 'asignar_privilegios#index'
  get 'asignar_privilegios/asignar_patron'
  get 'asignar_privilegios/aplicar_privilegios'
  get 'asignar_privilegios/agregar_privilegios'
  
  get ':controller/:action/:id'
  get ':controller/:action/:id.:format'
end
