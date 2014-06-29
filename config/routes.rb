Broggle::Engine.routes.draw do
  resources :broggles, except: :new, path: '/' do
    get 'search', on: :collection
  end
end
