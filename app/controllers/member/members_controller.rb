class Member::MembersController < ApplicationController
  before_action :authenticate_member!

  def index
  end

  def show
    @member = current_member
  end

  def edit
    @member = current_member
    #@member = Member.find(params[:id])
  end

  def update
   @member = current_member
   if @member.update(member_params)
    redirect_to member_path(current_member)
   else
    render :edit
   end
  end

  def unsubscribe
  end

  def withdraw
    member = current_member
    member.update(is_deleted: true) 
    reset_session #データをリセットする
    redirect_to new_member_registration_path
  end



  def member_params
    params.require(:member).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :phone_number, :postal_code, :address,:email)
  end
end
