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
    @alert = current_user.alerts.find(params[:alert_id])
    @index = @alert.conditions.count # already +1 since not zero based
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
