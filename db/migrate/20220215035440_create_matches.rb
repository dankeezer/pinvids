class CreateMatches < ActiveRecord::Migration[7.0]
  def change
    create_table :matches do |t|
      t.string :video_segment_start_time
      t.integer :bracket
      t.boolean :invalidated, :default => false
      t.integer :machine_id
      t.integer :tournament_id

      t.timestamps
    end
  end
end
