Rails.application.routes.draw do
  resources :votes
  resources :candidates
  resources :elecoms
  resources :members
  resources :positions
  resources :events
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
   root "pages#home"

   get "voter_code", to: 'pages#voter_code'
   get "page_vote", to: 'pages#vote'
   post "enter_code", to: 'pages#enter_code'
end
