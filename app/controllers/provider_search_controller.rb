# frozen_string_literal: true

require 'alerts/configuration'
Dir[Rails.root.join('lib/alerts/searchers/**/*.rb')].each { |file| require file }

class ProviderSearchController < ApplicationController
  before_action :require_user!

  def open
    @provider_type = params[:provider_type]

    respond_to do |format|
      format.turbo_stream
    end
  end

  def search
    # should be formatted like [[name, id]]
    @options =
      if params[:query].present?
        fetch_options
      else
        []
      end

    respond_to do |format|
      format.turbo_stream
    end
  end

  private

  def fetch_options
    searcher_klass = Alerts::Configuration.new.search_klass(params[:provider_type])

    searcher_klass.new.search(params[:query])
  end
end
