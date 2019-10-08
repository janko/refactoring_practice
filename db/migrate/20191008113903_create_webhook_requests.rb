class CreateWebhookRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :webhook_requests do |t|
      t.integer :webhook_id
      t.integer :status
      t.jsonb :headers
      t.text :body
      t.jsonb :exception

      t.timestamps
    end
  end
end
