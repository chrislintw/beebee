module Admin 
  class User < ::User

    def change_role!
      update(admin: !admin)
    end
  end
end