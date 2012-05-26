class RenameTypeToSetOnChallenge < ActiveRecord::Migration
  def change
    rename_column :challenges, :type, :set
  end
end
