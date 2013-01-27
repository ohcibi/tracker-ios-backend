class AddFinishedToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :finished, :boolean, default: false
  end
end
