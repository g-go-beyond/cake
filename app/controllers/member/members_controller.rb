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
    @member = Member.find_by(name: params[:name])
  end

  def withdraw
    @member = member.find_by(name: params[:name])
    #@member = current_member
    @member.update(is_deleted: true)
    reset_session #データをリセットする
    flash[:notice] = "ありがとうございました。またのご利用を心よりお待ちしております。"
    redirect_to member_path(current_member) #トップ画面へ
  end



  def member_params
    params.require(:member).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :phone_number, :postal_code, :address,:email)
  end
end
