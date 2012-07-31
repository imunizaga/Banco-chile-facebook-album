class AddRepeatableToChallenges < ActiveRecord::Migration
  def change
    add_column :challenges, :repeatable, :boolean, :default => false
  end
end
