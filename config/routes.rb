# frozen_string_literal: true

Rails.application.routes.draw do
  passwordless_for :users, at: '/', as: :auth

  root 'pages#home'

  resources :alerts, except: [:show]

  # turbo conditions
  get 'conditions/fields', to: 'conditions#fields'
  get 'conditions/value', to:  'conditions#value'
  get 'conditions/add', to: 'conditions#add'

  # turbo subregion
  get 'subregion/open', to: 'subregion#open'
  get 'subregion/search', to: 'subregion#search'

  resources :users, only: %i[new create]
end
