class Category < ApplicationRecord
  validates :name, presence: true

  VALID_COLOR_REGEX = /\A#(?:[0-9a-fA-F]{3}){1,2}\z/i

  validates :color, format: { with: VALID_COLOR_REGEX }
  validates :font_color, format: { with: VALID_COLOR_REGEX }
end
