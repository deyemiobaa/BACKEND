Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :memories do
        collection do
          get :public, to: 'memories#public_memories'
        end
      end
    end
  end
  devise_for :users,
  controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations'
  }, defaults: { format: :json }

end
