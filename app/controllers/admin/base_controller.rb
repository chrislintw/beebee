# frozen_string_literal: true

module Admin
  class BaseController < ::ApplicationController
    before_action :authenticate_user!
    before_action :admin_only!
    private

    def admin_only!
      unless current_user.admin
        flash[:alert] = '沒有權限'
        redirect_to root_path 
      end
    end
  end
end
