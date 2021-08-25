class Member::AddressesController < ApplicationController
    before_action :authenticate_member!

    def index
     @address = Address.new
     @addresses = current_member.addresses.all
    end
    
    def create
     address = Address.new(address_params)
     address.member_id = current_member.id
     address.save
     redirect_to addresses_path
    end
    
    def edit
     @address = Address.find(params[:id])
    end
    
    def update
     address = Address.find(params[:id])
     address.member_id = current_member.id
     address.update(address_params)
     redirect_to addresses_path
    end
    
    def destroy
     address = Address.find(params[:id])
     address.member_id = current_member.id
     address.destroy
     redirect_to addresses_path
    end
    
    private
    
 	def address_params
  	params.require(:address).permit(:member_id, :post_code, :address, :name)
  	end
  	
end
