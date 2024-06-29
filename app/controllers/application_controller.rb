class ApplicationController < ActionController::Base
  # 管理者はnewとcreateメソッドは実行できないが、どのユーザーのupdateやdestroyメソッドも実行できる
  def authenticate_user_or_admin!
    if action_name == 'new' || action_name == 'create'
      unless user_signed_in?
        flash[:alert] = "ログインもしくはアカウント登録してください。"
        redirect_to new_user_session_path
      end
    else
      unless user_signed_in? || admin_signed_in?
        flash[:alert] = "ログインもしくはアカウント登録してください。"
        redirect_to new_user_session_path
      end
    end
  end
end
