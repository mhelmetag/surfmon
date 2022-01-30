# frozen_string_literal: true

require 'alerts/configuration'

class ConditionsController < ApplicationController
  before_action :set_alerts_configuration

  def fields
    @id = params[:id]
    @source = params[:source]

    respond_to do |format|
      format.turbo_stream
    end
  end

  private

  def set_alerts_configuration
    @alerts_configuration = Alerts::Configuration.new
  end
end
