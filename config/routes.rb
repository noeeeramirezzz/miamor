Rails.application.routes.draw do
  root "home#index"

    resources :clientes
    resources :eventos
    resources :contratos
    resources :detalles_contratos
    resources :empleados
    resources :asignaciones

  resources :cargos, only: [:show]
  resources :servicios do
    member do
      get :precio
    end
    end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  resources :servicios do
    get "empleados", to: "servicios#empleados"
  end
end
