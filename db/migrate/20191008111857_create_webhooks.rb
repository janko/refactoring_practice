class CreateWebhooks < ActiveRecord::Migration[6.0]
  def change
    create_table :webhooks do |t|
      t.integer :account_id
      t.string :url
      t.text :payload
      t.jsonb :headers

      t.timestamps
    end
  end
end
