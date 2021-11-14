Rails.application.routes.draw do
  root to: 'tweets#home'
  devise_for :users
  resources :tweets, only: [:new, :create, :update] do
    resources :comment, only: [:index, :new, :create, :update], controller: "comments" do
      get "draft_comment", on: :collection
      get "list_comment", on: :collection
    end
    get "draft", on: :collection
    # post "create_comment", on: :member
    # put "update_comment", on: :member
    # get "list_comment", on: :member
    # get "new_comment", on: :member
    get 'new_retweet', on: :member
    post 'create_retweet', on: :member
    get 'list_retweets', on: :member
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
