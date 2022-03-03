class Player < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search,
                  against: %i[first_name last_name],
                  using: [:trigram],
                  ignoring: :accents

  has_many :matches

  def name
    "#{first_name} #{last_name}"
  end
end
