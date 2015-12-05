get '/authentication/' do
  user = User.find_or_initialize_by(token: params[:user][:token])

  if user.update_attributes params[:user]
    session[:user_token] = user.token

    flash[:success] = 'Logged in with successfully'
    redirect '/reports/new'
  else
    errors_handler(user)
    haml :'home/index'
  end
end

get '/loggout', auth: true do
  session[:user_token] = nil

  flash[:success] = 'Loggout with successfully'
  redirect '/'
end