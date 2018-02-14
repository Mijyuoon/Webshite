class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      if params[:remember]
        # This is *** V e R y S e C u R e ***
        cookies.permanent.signed[:session] = user.id
      end

      render json: {
        success: true,
      }
    else
      render json: {
        success: false,
        messages: [ t('rails.controllers.sessions.errors.bad_login') ],
      }
    end
  end

  def destroy
    session.delete(:user_id)
    cookies.delete(:session)

    render json: {
      success: true,
    }
  end
end
