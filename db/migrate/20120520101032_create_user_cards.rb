class CreateUserCards < ActiveRecord::Migration
  def change
    create_table :user_cards do |t|

      t.timestamps
    end
  end
end
