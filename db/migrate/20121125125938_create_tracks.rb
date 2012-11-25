class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.references :user

      t.timestamps
    end
    add_index :tracks, :user_id
  end
end
