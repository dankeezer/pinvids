class CreateTournaments < ActiveRecord::Migration[7.0]
  def change
    create_table :tournaments do |t|
      t.string :name
      t.string :video_id
      t.string :video_duration
      t.integer :ifpa_id

      t.timestamps
    end
  end
end
