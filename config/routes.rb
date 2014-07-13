Broggle::Engine.routes.draw do
  resources :broggles, except: :new, path: '/' do
    collection do
      get 'search/:query', action: 'search', as: 'search'
    end
  end
end
