class CreateTournaments < ActiveRecord::Migration[7.0]
  def change
    create_table :tournaments do |t|
      t.string :name
      t.string :video_id
      t.string :video_host
      t.string :video_duration
      t.integer :ifpa_id
      t.datetime :event_started_at

      t.timestamps
    end
  end
end
