# frozen_string_literal: true

Rails.application.routes.draw do


  resources :books

  devise_for :users, skip: :all
  devise_scope :user do
    # sessions
    get "login", to: "users/sessions#new", as: :new_user_session
    post "login", to: "users/sessions#create", as: :user_session
    match "logout", to: "users/sessions#destroy", as: :destroy_user_session, via: Devise.mappings[:user].sign_out_via

    # registrations
    get "users/new", to: "users/registrations#new", as: :new_user_registration
    get "me/edit", to: "users/registrations#edit", as: :edit_user_registration
    patch "me", to: "users/registrations#update", as: :update_user_registration
    post "users", to: "users/registrations#create", as: :user_registration
  end

  # omniauth
  devise_for :users, only: [:omniauth_callbacks], controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }, path: "sso"

  # get "users/:username", to: "users#show", constraints: {
  #   username: ROUTING_USERNAME
  # }, as: :user

  # post "users/:username/follow", to: "users/follow#follow", constraints: {
  #   username: ROUTING_USERNAME
  # }, as: :user_follow

  # delete "users/:username/follow", to: "users/follow#unfollow", constraints: {
  #   username: ROUTING_USERNAME
  # }, as: :user_unfollow

  constraints(username: ROUTING_USERNAME) do
    resources :users, param: :username, only: [:show], as: :user do 
      post "follow", to: "users/follow#follow", as: :follow, on: :member
      delete "follow", to: "users/follow#unfollow", as: :unfollow, on: :member
    end
  end

  # 未ログイン時のルート画面
  unauthenticated do
    as :user do
      root to: "homes#index", as: :unauthenticated_root
    end
  end

  # ログイン時のルート画面
  authenticated do
    as :user do
      root to: "books#index", as: :authenticated_root
    end
  end
end
