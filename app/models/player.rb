class Player < ApplicationRecord
  include PgSearch::Model
  multisearchable against: [:first_name, :last_name]
                  using: :trigram

  has_many :matches


  def name
    "#{first_name} #{last_name}"
  end
end
