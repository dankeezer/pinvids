class Machine < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search,
                  against: :name,
                  using: [:trigram],
                  ignoring: :accents

  has_many :matches
  has_many :tournaments, through: :matches

  def ipdb_url
    return "" if ipdb_id.blank?

    "https://www.ipdb.org/machine.cgi?id=#{ipdb_id}#"
  end
end
