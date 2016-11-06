class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.integer :telegram_message_id
      t.jsonb :message
      t.integer :transaction_id
      t.timestamps
    end
  end
end
