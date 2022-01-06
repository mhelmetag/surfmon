# frozen_string_literal: true

class AlertsController < ApplicationController
  def index
    @alerts = Alerts.all
  end

  def new
    @sources = alerts_configuration.sources
  end

  private

  def alerts_configuration
    @alerts_configuration ||= Alerts::Configuration.new
  end
end
