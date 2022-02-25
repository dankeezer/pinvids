class Machine < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search,
                  against: :name,
                  using: [:trigram],
                  ignoring: :accents

  has_many :matches

  def ipdb_url
    return "" if ipdb_id.blank?

    "https://www.ipdb.org/machine.cgi?id=#{ipdb_id}#"
  end

  def tournaments
    matches.map(&:tournament).uniq.sort_by(&:name)
  end
end
