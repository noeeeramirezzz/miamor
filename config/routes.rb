Rails.application.routes.draw do
  root "home#index"

  # Clientes, eventos, contratos
  resources :clientes
  resources :eventos
  resources :contratos
  resources :detalles_contratos

  # Empleados
  resources :empleados do
    collection do
      get :por_categoria
    end
  end

  # Asignaciones
  resources :asignaciones

  # Cargos
  resources :cargos, only: [:show]

  # Servicios + rutas adicionales
  resources :servicios do
    member do
      get :precio
    end

    # 🔥 ESTA ES LA RUTA QUE FALTABA
    get :empleados   # /servicios/:id/empleados
  end

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check
end
