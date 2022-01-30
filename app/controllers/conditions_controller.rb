# frozen_string_literal: true

require 'alerts/configuration'

class ConditionsController < ApplicationController
  before_action :set_alerts_configuration

  def fields
    @index = params[:index]
    @source = params[:source]

    respond_to do |format|
      format.turbo_stream
    end
  end

  def value
    @index = params[:index]
    @source = params[:source]
    @field = params[:field]

    respond_to do |format|
      format.turbo_stream
    end
  end

  private

  def set_alerts_configuration
    @alerts_configuration = Alerts::Configuration.new
  end
end
