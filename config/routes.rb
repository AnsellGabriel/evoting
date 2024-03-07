Rails.application.routes.draw do
  resources :referendums do
    post :submit_answers, on: :collection
  end

  devise_for :users
  resources :votes do 
    get "save_vote", to: 'votes#save_vote', on: :collection
    get "vote_review", to: "votes#vote_review", on: :collection
    get "vote_final", to: "votes#vote_final", on: :collection
    get "vote_success", to: "votes#vote_success", on: :collection
    get "result", to: "votes#result", on: :collection 
    get "vote_all", to: "votes#vote_all", on: :collection
    get "results_graph", on: :collection
  end
  resources :candidates
  resources :elecoms
  resources :members
  resources :positions
  resources :events
  resources :referendum_responses
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
   root "pages#home"

   get "voter_code", to: 'pages#voter_code'
   get "page_vote", to: 'pages#vote'
   post "enter_code", to: 'pages#enter_code'
end
