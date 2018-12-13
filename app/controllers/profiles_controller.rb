# frozen_string_literal: true

class ProfilesController < ApplicationController
  before_action :set_user, only: %i[show edit update upgrade]

  def show; end

  def edit; end

  def update; end

  def upgrade
    if @user.upgrade!
      redirect_to profile_path, notice: '成功升級'
    else
      redirect_to profile_path, alert: '升級失敗'
    end
  end

  private

  def set_user
    @user = current_user
  end
end
