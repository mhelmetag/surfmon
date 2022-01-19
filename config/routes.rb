# frozen_string_literal: true

Rails.application.routes.draw do
  root 'alerts#index'

  resources :alerts
end
