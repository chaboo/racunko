class User < ApplicationRecord

  validates :telegram_id, uniqueness: true
end
