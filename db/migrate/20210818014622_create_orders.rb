 class CreateOrders < ActiveRecord::Migration[5.2]
   def change
    create_table :orders do |t|
      t.integer :member_id, null: false
      t.integer :postage, null: false
      t.integer :total_payment, null:false
      t.integer :payment_method, null: false, default: 0
      t.string :shipping_name, null: false
      t.string :shipping_address, null:false
      t.string :shipping_post_code, null:false
      t.integer :status, null: false, default: 0

      t.timestamps
    end
   end
  end