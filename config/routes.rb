Rails.application.routes.draw do
  root "logins#new"
  resources :logins, only: [:new, :create] do
    collection do
      get :auth_error
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
