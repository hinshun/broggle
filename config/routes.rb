Broggle::Engine.routes.draw do
  resources :broggles, except: :new, path: '/' do
    collection do
      get 'search/:query', action: 'search', as: 'search'
      post 'deploy', action: 'deploy', as: 'deploy'
    end
  end
end
