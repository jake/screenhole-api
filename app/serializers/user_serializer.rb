class UserSerializer < ActiveModel::Serializer
  attribute :hashid, key: :id

  attributes :username, :created_at

  attribute :email, if: :is_current_user?

  has_many :shots

  def is_current_user?
    current_user && object.id == current_user.id
  end
end