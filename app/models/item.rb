class Item < ApplicationRecord
    has_many :ordered_items
    has_many :orders, through: :ordered_items
    has_many :cart_items
    belongs_to :genre
    attachment :image
    
def tax_included_price
  (item.price * 1.08).round
end
    
    
end
