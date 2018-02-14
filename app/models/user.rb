class User < ApplicationRecord
  before_save { self.email = email.downcase }

  has_many :tokens, as: :tokenable, dependent: :destroy

  VALID_EMAIL_REGEX = /\A(.+)@(.+)\z/i

  validates :email,
    presence: true,
    length: {maximum: 255},
    format: VALID_EMAIL_REGEX,
    uniqueness: {case_sensitive: false}

  validates :username,
    presence: true,
    length: {maximum: 40}

  has_secure_password

  validates :password,
    presence: true,
    length: {minimum: 8},
    allow_nil: true

  validates :info_about,
    length: {maximum: 2000}

  def permission?(*keys, any: false)
    return false if keys.empty?
    init = any ? false : true
    keys.reduce(init) do |a,k|
      has = permissions.include?(k.to_s)
      any ? a || has : a && has
    end
  end
end
