Broggle::Engine.routes.draw do
  resources :broggles, except: :new do
    get 'search', on: :collection
  end
end
