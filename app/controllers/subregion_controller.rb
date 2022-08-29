# frozen_string_literal: true

require 'alerts/providers/surfline_provider'

class SubregionController < ApplicationController
  before_action :require_user!

  def open
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
    response = Alerts::SurflineProvider.new.search(params[:query])
    return ['Error! Does not compute!', ''] unless response.code == 200

    spot_response = response.parsed_response[0]
    spot_hits = spot_response.dig('hits', 'hits') || []
    spot_hits.map do |spot_hit|
      name = spot_hit.dig('_source', 'name')
      id = spot_hit.dig('_source', 'href').split('/')[5] # https://www.surfline.com/surf-forecasts/south-san-diego/58581a836630e24c4487900d

      [name, id]
    end
  end
end
