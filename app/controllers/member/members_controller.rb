class Member::MembersController < ApplicationController
  before_action :authenticate_member_member!

  def index
  end

  def show
    @member = current_member
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update
   @member = Member.find(params[:id])
   if  member.update
    redirect_to member_member_path(current_member)
   else
    render :edit
   end
  end

  def member_params
    params.require(:member).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :phone_number, :postal_code, :address,:email)
  end
end
