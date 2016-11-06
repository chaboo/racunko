class Account < ApplicationRecord
  belongs_to :user
  has_many :incoming_transactions, class_name: 'Transaction', foreign_key: 'receiver_id'
  has_many :outgoing_transactions, class_name: 'Transaction', foreign_key: 'sender_id'
end
