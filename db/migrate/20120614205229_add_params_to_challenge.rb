class AddParamsToChallenge < ActiveRecord::Migration
  def change
      add_column :challenges, :client_param, :text
      add_column :challenges, :server_param, :text
      add_column :challenges, :kind, :text
  end
end
