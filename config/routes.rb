# frozen_string_literal: true

Rails.application.routes.draw do
  passwordless_for :users, at: '/', as: :auth

  root 'pages#home'

  resources :alerts, except: [:show]

  # turbo conditions
  get 'conditions/fields', to: 'conditions#fields'
  get 'conditions/value', to:  'conditions#value'
  get 'conditions/add', to: 'conditions#add'
  get 'conditions/delete', to: 'conditions#delete'

  # turbo provider search
  get 'provider_search/open', to: 'provider_search#open'
  get 'provider_search/search', to: 'provider_search#search'

  resources :users, only: %i[new create]
end
