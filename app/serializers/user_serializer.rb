class UserSerializer < ActiveModel::Serializer
  attribute :hashid, key: :id

  attributes :username, :created_at, :gravatar_hash, :name, :bio, :blocked

  attribute :country_code
  attribute :country_emoji
  attribute :time_now

  attribute :email, if: :is_current_user?

  attribute :stats

  attribute :badges

  def stats
    stats = {
      grabs: object.grabs.size,
    }

    # private stats
    if is_current_user?
      stats[:buttcoins] = object.buttcoin_balance
    end

    stats
  end

  def is_current_user?
    begin
      object.id == current_user.id
    rescue
      false
    end
  end
end
