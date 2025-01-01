Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: [] do
        collection do
          post :signup
          post :login
        end
      end
      resources :hostels, only: [:index, :create, :update, :destroy] do
        resources :rooms, only: [:index, :create]
      end
      resources :rooms, only: [:update, :destroy] do
        collection do
          get :search
        end
        resources :bookings, only: [:create]
      end
      resources :bookings, only: [:index, :destroy]  do
         member do
          put :approve
          put :reject
        end
      end
    end
  end

end
