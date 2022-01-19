# frozen_string_literal: true

Rails.application.routes.draw do
  passwordless_for :users, at: '/'

  root 'alerts#index'

  resources :alerts
  resources :users, only: %i[new create]
end
