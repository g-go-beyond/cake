class Order < ApplicationRecord
    belongs_to :member
    has_many :ordered_items
    has_many :items, through: :ordered_items
<<<<<<< HEAD
   # enum status: { waiting: 0,paid_up: 1, making: 2,preparing: 3, shipped: 4}

enum status: {
     "入金待ち":0, 
     "入金確認":1, 
     "製作中":2, 
     "発送準備中":3, 
     "発送済み":4
  }
end
=======
    enum payment_method: ["クレジットカード", "銀行振込"]
end
>>>>>>> acc0d8e93037ddd38e1423f048002aa5618acc5f
