module Include
  module SessionManager
    def current_user
      if (uid = session[:user_id])
        @current_user ||= User.find_by(id: uid)
      elsif (token = cookies.signed[:session])
        @current_user ||= User.find_by(id: uid)
        session[:user_id] = @current_user
      end
    end

    def logged_in?(as: nil)
      as.nil? || as == :any ?
        !current_user.nil? : current_user == as
    end

    def has_access?(*perms, any: false, as: nil)
      return true if !as.nil? && logged_in?(as: as)
      current_user&.permission?(*perms, any: any)
    end

    def verify_user_page(*args, **kwargs)
      unless has_access?(*args, **kwargs)
        add_flash(:danger,
          t('rails.flash.danger.access_denied.body'),
          t('rails.flash.danger.access_denied.title'))
        redirect_to index_path
      end
    end

    def verify_user_api(*args, **kwargs)
      unless has_access?(*args, **kwargs)
        render json: {
          success: false,
          messages: [ t('rails.flash.danger.access_denied.body') ],
        }
      end
    end
  end
end