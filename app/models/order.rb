class Order < ApplicationRecord
    belongs_to :member
    has_many :ordered_items
    has_many :items, through: :ordered_items
    enum payment_method: ["クレジットカード", "銀行振込"]