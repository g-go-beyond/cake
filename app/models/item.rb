class Item < ApplicationRecord
    has_many :ordered_items
    has_many :orders, through: :ordered_items
    has_many :cart_items
    belongs_to :genre
    attachment :image
    
    validates :image, presence: true
    validates :name, presence: true
    validates :description, presence: true
    validates :genre, presence: true
    validates :price, presence: true

end
