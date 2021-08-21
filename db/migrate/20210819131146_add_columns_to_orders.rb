class AddColumnsToOrders < ActiveRecord::Migration[5.2]
  def change
      add_column :orders, :member_id, :integer
      add_column :orders, :postage, :integer
      add_column :orders, :total_payment, :integer
      add_column :orders, :payment_method, :integer, default: 0
      add_column :orders, :shipping_name, :string
      add_column :orders, :shipping_address, :string
      add_column :orders, :shipping_post_code, :string
      add_column :orders, :status, :integer, default: 0
  end 
end
