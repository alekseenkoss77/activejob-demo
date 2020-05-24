Rails.application.routes.draw do
  resources :reports, only: [:index] do
    collection do
      post :generate
    end
  end

  root to: 'home#index'
end
