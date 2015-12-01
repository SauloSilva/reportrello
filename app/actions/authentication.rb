get '/authentication/' do
  user = User.find_or_initialize_by(token: params[:user][:token])

  if user.update_attributes params[:user]
    flash.now[:success] = 'Logged in with successfully'
    redirect "user/#{ user.id }/imports/new"
  else
    errors_handler(user)
    haml :'home/index'
  end
end