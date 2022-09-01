# frozen_string_literal: true

require 'alerts/configuration'

class ConditionsController < ApplicationController
  before_action :require_user!
  before_action :set_alerts_configuration

  def fields
    @index = params[:index]
    @provider_type = params[:provider_type]
    @source = params[:source]
    @field = @alerts_configuration.source_fields(@provider_type, @source).first

    respond_to do |format|
      format.turbo_stream
    end
  end

  def value
    @index = params[:index]
    @provider_type = params[:provider_type]
    @source = params[:source]
    @field = params[:field]

    respond_to do |format|
      format.turbo_stream
    end
  end

  def add
    @index = params[:index].to_i
    @alert =
      if params[:alert_id]
        current_user.alerts.find(params[:alert_id])
      else
        current_user.alerts.new
      end
    @provider_type = params[:provider_type]
    @condition = @alert.conditions.build

    respond_to do |format|
      format.turbo_stream
    end
  end

  def delete
    @index = params[:index].to_i
    @alert = current_user.alerts.find(params[:alert_id])
    @condition = @alert.conditions[@index]

    respond_to do |format|
      format.turbo_stream
    end
  end

  private

  def set_alerts_configuration
    @alerts_configuration = Alerts::Configuration.new
  end
end
