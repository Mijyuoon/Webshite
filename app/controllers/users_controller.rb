class UsersController < ApplicationController
  before_action(only: :edit) do
    @user ||= User.find(params[:id])

    verify_user_page(:manage_users, as: @user)
  end

  before_action(only: :update) do
    @user ||= User.find(params[:id])

    case params[:type]
      when 'profile', 'password'
        verify_user_api(:manage_users, as: @user)
      when 'permissions'
        verify_user_api(:manage_permissions)
    end
  end

  def show
    @user ||= User.find(params[:id])

    permissions = @user.permissions.each_with_index.map do |v, i|
      {
        id: i + 1,
        name: ":#{v}",
        desc: t(v, default: '',
          scope: 'rails.controllers.users.misc.permissions')
      }
    end

    frontend_data user: {
      permissions: permissions,
    }
  end

  def edit
    @user ||= User.find(params[:id])

    frontend_data user: {
      username: @user.username,
      info_about: @user.info_about,
      permissions: @user.permissions,
    }

    frontend_data routes: {
      users_edit: users_edit_path(@user),
    }
  end

  def update
    @user ||= User.find(params[:id])

    data = case params[:type]
      when 'profile'
        params.permit(:username, :info_about)

      when 'password'
        if @user.authenticate(params[:old_password])
          params.permit(:password, :password_confirmation)
        else
          @user.errors.add(:base, :old_password)
          false
        end

      when 'permissions'
        params.permit(permissions: [])

      else
        @user.errors.add(:base, :bad_request)
        false
    end

    if data && @user.update(data)
      render json: {
        success: true
      }
    else
      render json: {
        success: false,
        messages: @user.errors.full_messages
      }
    end
  end

  private

  def list_permissions
    @user.permissions.each_with_index.map do |v, i|
      {id: i + 1, name: v, desc: t(v, scope: 'rails.controllers.users.misc.permissions')}
    end
  end
end
