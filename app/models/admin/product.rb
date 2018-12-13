module Admin
  class Product < ::Product
    def soft_destroy!
      update(destroyed_at: Time.zone.now)
    end
  end
end
