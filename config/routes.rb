# frozen_string_literal: true

Rails.application.routes.draw do
  passwordless_for :users, at: '/', as: :auth

  root 'pages#home'

  resources :alerts
  resources :conditions, only: [] do
    collection do
      get :fields
      get :value
    end
  end
  resources :users, only: %i[new create]
end
