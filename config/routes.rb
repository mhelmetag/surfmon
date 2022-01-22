# frozen_string_literal: true

Rails.application.routes.draw do
  passwordless_for :users, at: '/', as: :auth

  root 'pages#home'

  resources :alerts
  resources :users, only: %i[new create]
end
