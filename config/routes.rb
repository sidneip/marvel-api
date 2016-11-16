Rails.application.routes.draw do
  root "logins#new"
  resources :logins, only: [:new, :create] do
    collection do
      get :auth_error
    end
  end

  resources :characters, only: [:index, :show]
  namespace :api do
    resources :characters
  end
end
