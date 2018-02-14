class ApplicationController < ActionController::Base
  include Include::SessionManager

  protect_from_forgery with: :exception

  before_action do
    frontend_data routes: {
      home: index_path,

      login: login_path,
      logout: logout_path,
    }

    if current_user
      frontend_data login: {
        id: current_user.id,
        name: current_user.username,
      }

      frontend_data routes: {
        profile: users_show_path(current_user),
        settings: users_edit_path(current_user),
      }
    else
      frontend_data login: nil
    end
  end

  def frontend_data(**data)
    @frontend_data ||= {}
    @frontend_data.deep_merge!(data)
  end

  def add_flash(name, msg, title = nil, close = false, now: false)
    f = now ? flash.now : flash
    f[name] ||= []
    f[name] << {text: msg, title: title, close: close}
  end

  def not_found(message = 'Not Found')
    raise ActionController::RoutingError, message
  end
end
