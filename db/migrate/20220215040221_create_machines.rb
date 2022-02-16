class CreateMachines < ActiveRecord::Migration[7.0]
  def change
    create_table :machines do |t|
      t.string :name
      t.integer :ipdb_id

      t.timestamps
    end
  end
end
