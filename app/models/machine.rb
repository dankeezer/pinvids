class Machine < ApplicationRecord
  has_many :matches


  def ipdb_url
    return "" if ipdb_id.blank?

    "https://www.ipdb.org/machine.cgi?id=#{ipdb_id.to_s}#"
  end
end
