module Admin
  class UsersController < BaseController
    before_action :set_user, only: %i[show change_role]
    def index
      @users = Admin::User.all.page(params[:page])
    end

    def show;  end

    def change_role

      @user.change_role!
      respond_to do |format|
        format.js 
      end
    end
    private

    def set_user
      @user = Admin::User.find(params[:id])
    end
  end
end
