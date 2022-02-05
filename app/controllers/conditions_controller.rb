# frozen_string_literal: true

require 'alerts/configuration'

class ConditionsController < ApplicationController
  before_action :set_alerts_configuration

  def fields
    @index = params[:index]
    @source = params[:source]
    @field = @alerts_configuration.source_fields(@source).first

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

  def add
    @index = params[:index]
    @alert =
      if params[:alert_id]
        current_user.alerts.find(params[:alert_id])
      else
        current_user.alerts.new
      end
    @condition = @alert.conditions.build

    respond_to do |format|
      format.turbo_stream
    end
  end

  private

  def set_alerts_configuration
    @alerts_configuration = Alerts::Configuration.new
  end
end
