# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action :member_state, only: [:create]
  
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  
  # 退会しているかを判断するメソッド
  def member_state
    ## 【処理内容1】 入力されたemailからアカウントを1件取得
    @member = Member.find_by(email: params[:member][:password])
    ## アカウントを取得できなかった場合、このメソッドを終了する
    if @member
    ## 【処理内容2】 取得したアカウントのパスワードと入力されたパスワードが一致してるかを判別
      if @member.valid_password?(params[:member][:password]) && (@member.is_deleted == false)
        flash[:notice] = "退会済みです。再度ご登録をしてご利用ください。"
        redirect_to new_member_registration_path
      else
        flash[:notice] = "項目を入力してください"
      end
    end
  end
  
  def guest_sign_in
    member = Member.guest
    sign_in member
    redirect_to posts_path, notice: 'ゲストユーザーとしてログインしました。'
  end
  
  def after_sign_in_path_for(resource)
    member_path(current_member)
  end
  
end
