class Machine < ApplicationRecord
  has_many :matches


  def ipdb_url
    return "" if ipdb_id.blank?

    "https://www.ipdb.org/machine.cgi?id=#{ipdb_id.to_s}#"
  end

  def tournaments
    matches.map { |m| m.tournament }.uniq.sort_by(&:name)
  end
end
