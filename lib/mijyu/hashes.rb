module Mijyu
  module Hashes
    class << self
      def new_bcrypt(secret, cost = nil)
        cost ||= ActiveModel::SecurePassword.min_cost ?
          BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
        BCrypt::Password.create(secret, cost: cost)
      end

      def new_random(length = nil, url = true)
        url ? SecureRandom.urlsafe_base64(length) : SecureRandom.base64(length)
      end

      def test_bcrypt(hash, raw)
        BCrypt::Password.new(hash).is_password?(raw)
      end
    end
  end
end
