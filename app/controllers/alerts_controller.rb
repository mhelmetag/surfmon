# frozen_string_literal: true

require 'alerts/configuration'

class AlertsController < ApplicationController
  before_action :set_alerts_configuration

  def index
    @alerts =
      if current_user
        current_user.alerts.preload(:condition)
      else
        Alert.none
      end
  end

  def new
    @alert = current_user.alerts.new
    @alert.condition = Condition.new
  end

  def create
    @alert = current_user.alerts.new(alert_params)

    if @alert.save
      redirect_to alerts_path, flash: { notice: 'Alert created' }
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @alert = current_user.alerts.find(params[:id])
  end

  def update
    @alert = current_user.alerts.find(params[:id])

    if @alert.update(alert_params)
      redirect_to alerts_path, flash: { notice: 'Alert updated' }
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @alert = current_user.alerts.find(params[:id])

    if @alert.destroy
      redirect_to alerts_path, flash: { notice: 'Alert deleted' }
    else
      redirect_to alerts_path, flash: { error: "Alert couldn't be deleted" }
    end
  end

  private

  def set_alerts_configuration
    @alerts_configuration = Alerts::Configuration.new
  end

  def alert_params
    params.require(:alert).permit(
      :name,
      :subregion_id,
      condition_attributes: %i[source field comparator value]
    )
  end
end
