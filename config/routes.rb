Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', to: 'rest#index'
  post '/record', to: 'rest#record'
  get '/webhooks/answer', to: 'rest#answer'
  post '/webhooks/event', to: 'rest#event'
end
