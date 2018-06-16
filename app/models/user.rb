class User < ApplicationRecord
  include Hashid::Rails

  validates_uniqueness_of :username, case_sensitive: false, allow_blank: false
  validates_uniqueness_of :email, case_sensitive: false, allow_blank: false

  validates_presence_of :username, :email

  has_secure_password
  validates_length_of :password, minimum: 6, if: :password_digest_changed?
  validates_presence_of :password_confirmation, if: :password_digest_changed?

  has_many :grabs, dependent: :destroy
  has_many :chomments, dependent: :destroy
  has_many :memos, dependent: :destroy

  has_many :notes
  has_many :invites

  before_validation :normalize_username

  scope :visible_in_directory, -> { all }

  def buttcoin_transaction(amount, note=nil)
    Buttcoin.create(user: self, amount: amount, note: note)
  end

  def buttcoin_balance
    Buttcoin.where(user: self).sum(:amount)
  end

  def gravatar_hash
    Digest::MD5.hexdigest(email || "")
  end

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

  private
  def normalize_username
    self.username = username.strip.downcase if username
  end
end
