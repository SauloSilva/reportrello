register do
  def auth(has_authentication)
    condition do
      return unless has_authentication

      unless user_logged?
        flash['alert alert-danger'] = 'You is not logged'
        redirect '/'
      end
    end
  end
end

helpers do
  def errors_handler(record)
    record.errors.map do |key, value|
      flash.now["error_#{ key } alert alert-danger"] = "#{ key } #{ value }"
    end
  end

  def user_logged?
    @current_user.present?
  end
end

before do
  @current_user ||= User.find_by(token: session[:user_token])
end