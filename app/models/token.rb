class Token < ApplicationRecord
  class Payload
    def self.load(data)
      Marshal.load(data) unless data.nil?
    end

    def self.dump(data)
      Marshal.dump(data) unless data.nil?
    end
  end

  belongs_to :tokenable, polymorphic: true, optional: true

  serialize :payload, Payload

  def self.generate(kind:, target: nil, length: nil, expires: nil, payload: nil)
    Token.new(kind: kind, value: Mijyu::Hashes.new_random(length),
      tokenable: target, expires_at: expires, payload: payload)
  end

  def verify_expired!
    return self if expires_at.nil?
    valid = Time.now <= expires_at
    delete unless valid
    valid && self
  end
end
