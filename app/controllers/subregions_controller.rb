# frozen_string_literal: true

require 'alerts/providers/surfline_provider'

class SubregionsController < ApplicationController
  before_action :require_user!

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
    response = Alerts::SurflineProvider.new.search(params[:query])
    return ['Error! Does not compute!', ''] unless response.code == 200

    subregion_response = response.parsed_response[1]
    subregion_hits = subregion_response.dig('hits', 'hits') || []
    subregion_hits.map do |subregion_hit|
      name = subregion_hit.dig('_source', 'name')
      id = subregion_hit.dig('_source', 'href').split('/')[5]

      [name, id]
    end
  end
end
