Texter::Application.routes.draw do

  resources :messages, :only => [:index, :create]
  post 'receiver', :to => 'messages#create'
  post 'instructions', :to => 'welcome#send_instructions'

  resources :welcome, :only => [:index]
  resources :responses, :only => [:index]

  root :to => 'welcome#index'
end
