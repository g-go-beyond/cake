class Order < ApplicationRecord
    belongs_to :member
    has_many :items, through: :ordered_items
end
