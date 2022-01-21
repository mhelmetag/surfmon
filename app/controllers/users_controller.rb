# frozen_string_literal: true

class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if verify_recaptcha(model: @user) && @user.save
      sign_in @user
      redirect_to alerts_path, flash: { notice: 'Welcome!' }
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email)
  end
end
