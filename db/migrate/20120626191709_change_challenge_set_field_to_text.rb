class ChangeChallengeSetFieldToText < ActiveRecord::Migration
  def change
    change_column :challenges, :set, :text
  end
end
