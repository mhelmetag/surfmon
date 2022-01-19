# frozen_string_literal: true

require 'alerts/configuration'

class AlertsController < ApplicationController
  before_action :set_alerts_configuration

  def index
    @alerts = Alert.all.preload(:condition)
  end

  def new
    @alert = Alert.new
  end

  def create
    @alert = Alert.new(alert_params)

    if @alert.save
      redirect_to alerts_path, flash: { notice: 'Alert created' }
    else
      render 'new'
    end
  end

  def edit
    @alert = Alert.find(params[:id])
  end

  def update
    @alert = Alert.find(params[:id])

    if @alert.update(alert_params)
      redirect_to alerts_path, flash: { notice: 'Alert updated' }
    else
      render 'edit'
    end
  end

  def destroy
    @alert = Alert.find(params[:id])

    @alert.destroy

    redirect_to alerts_path, flash: { notice: 'Alert deleted' }
  end

  private

  def set_alerts_configuration
    @alerts_configuration = Alerts::Configuration.new
  end

  def alert_params
    params.require(:alert).permit(:name, condition_attributes: %i[source field comparator value alert_id])
  end
end
