class CreateUserChallenges < ActiveRecord::Migration
  def change
    create_table :user_challenges do |t|
      t.integer :user_id
      t.integer :challenge_id

      t.timestamps
    add_foreign_key "user_challenges", "users", :name => "user_challenges_user_id_fk"
    add_foreign_key "user_challenges", "challenges", :name => "user_challenges_challenge_id_fk"
    end
  end
end
