# frozen_string_literal: true

require 'alerts/configuration'

class AlertsController < ApplicationController
  before_action :require_user!
  before_action :set_alerts_configuration

  def index
    @alerts =
      if current_user
        current_user.alerts.preload(:conditions)
      else
        Alert.none
      end
  end

  def new
    @alert = current_user.alerts.new
    @provider_type = @alert.provider_type = params[:provider_type]
    @alert.conditions.build
  end

  def create
    @alert = current_user.alerts.new(alert_params)

    if @alert.save
      redirect_to alerts_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @alert = current_user.alerts.find(params[:id])
    @provider_type = @alert.provider_type
    @alert.conditions.build if @alert.conditions.blank?
  end

  def update
    @alert = current_user.alerts.find(params[:id])

    if @alert.update(alert_params)
      redirect_to alerts_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @alert = current_user.alerts.find(params[:id])

    @alert.destroy

    redirect_to alerts_path
  end

  private

  def set_alerts_configuration
    @alerts_configuration = Alerts::Configuration.new
  end

  def alert_params
    params.require(:alert).permit(
      :id,
      :name,
      :provider_type,
      :provider_search_name,
      :provider_search_id,
      conditions_attributes: %i[id source field comparator value _destroy]
    )
  end
end
