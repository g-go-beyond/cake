class OrderedItem < ApplicationRecord
    belongs_to :order
    belongs_to :item

    enum making_status: {
     "製作不可":0,
     "製作待ち":1,
     "製作中":2,
     "製作終了":3
  }
    # def tax_included_price
    #   (self.price * 1.08).round
    # end
end
