class CreateBalls < ActiveRecord::Migration[7.0]
  def change
    create_table :balls do |t|
      t.integer :name
      t.integer :points
      t.integer :match_id
      t.integer :player_id

      t.timestamps
    end
  end
end
