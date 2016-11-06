class CreateTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :transactions do |t|
      t.string :sender_id
      t.string :receiver_id
      t.integer :amount
      t.string :amount_currency
      t.integer :state
      t.string :state_currency

      t.timestamps
    end
  end
end
