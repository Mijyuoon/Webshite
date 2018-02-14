class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      unless params[:remember].blank?
        token = Token.generate(kind: :session, to: user)
        token.save!

        cookies.permanent.signed[:session] = token.value
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
    if (sid = cookies.signed[:session])
      Token.destroy_all(kind: :session, value: sid)
    end

    session.delete(:user_id)
    cookies.delete(:session)

    render json: {
      success: true,
    }
  end
end
