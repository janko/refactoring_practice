class CreateAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :accounts do |t|
      t.jsonb :github_auth
      t.jsonb :twitter_auth

      t.timestamps
    end
  end
end
