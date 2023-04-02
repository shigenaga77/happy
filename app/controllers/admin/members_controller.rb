class Admin::MembersController < ApplicationController
    def index
        @member = Member.all
    end
    
    def show
        @member = Member.find(params[:id])
    end
    
    def edit
        @member = Member.find(params[:id])
    end
    
    def update
        @member =Member.find(params[:id])
        @member.update(member_params)
        redirect_to admin_members_path
    end
    
    private
    
    def member_params
        params.require(:member).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :nickname, :email)
    end
end