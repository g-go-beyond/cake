class Item < ApplicationRecord
    has_many :ordered_items
    has_many :orders, through: :ordered_items
    has_many :cart_items
    belongs_to :genre
    attachment :image
    
    
    
end
