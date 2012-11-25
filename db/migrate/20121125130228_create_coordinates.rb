class CreateCoordinates < ActiveRecord::Migration
  def change
    create_table :coordinates do |t|
      t.float :lat
      t.float :lng
      t.references :track

      t.timestamps
    end
    add_index :coordinates, :track_id
  end
end
