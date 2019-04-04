require "administrate/base_dashboard"

class NoteDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    hashid: Field::String,
    user: Field::BelongsTo,
    actor_id: Field::Number,
    actor: Field::BelongsTo.with_options(class_name: "User"),
    cross_ref: Field::Polymorphic,
    variant: Field::String,
    meta: Field::Text,
    created_at: Field::DateTime,
    updated_at: Field::DateTime
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :hashid,
    :user,
    :actor,
    :cross_ref,
    :variant
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :id,
    :hashid,
    :user,
    :actor,
    :cross_ref,
    :variant,
    :meta,
    :created_at,
    :updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :user,
    :actor,
    :cross_ref,
    :variant,
    :meta
  ].freeze

  # Overwrite this method to customize how notes are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(note)
  #   "Note ##{note.id}"
  # end
end
