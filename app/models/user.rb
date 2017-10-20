class User < ApplicationRecord
  include Hashid::Rails

  validates_uniqueness_of :username, case_sensitive: false
  validates_presence_of :username

  has_secure_password

  has_many :shots

  def to_token_payload
    { sub: hashid }
  end

  def self.from_token_payload(payload)
    self.find payload["sub"]
  end

  def self.from_token_request(request)
    username = request.params["auth"] && request.params["auth"]["username"]
    self.find_by(username: username)
  end
end
