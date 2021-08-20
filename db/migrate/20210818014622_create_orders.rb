 class CreateOrders < ActiveRecord::Migration[5.2]
   def change
    create_table :orders do |t|
      t.integer :member_id, null: false
      t.integer :postage, null: false
      t.integer :total_payment, null:false
      t.integer :payment_method, null: false
      t.string :sipping_name, null: false
      t.string :shipping_address, null:false
      t.string :shipping_post_code, null:false
      t.integer :status, null: false
      t.integer :status, null: false

      t.timestamps
    end
   end
  end