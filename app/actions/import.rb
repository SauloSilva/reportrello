before '/user/:user_id/*' do
  @user = User.find(params[:user_id])
end

get '/user/:user_id/imports/new' do
  haml :'imports/new'
end

get '/user/:user_id/imports' do
  haml :'imports/index'
end

post '/user/:user_id/imports' do
  import = Import.new params[:import]
  report = import.reports.new params[:report]

  if import.save && report.save
    ImportWorker.perform_async(import.id)
    redirect "user/#{ params[:user_id] }/imports"
  else
    errors_handler(import)
    errors_handler(report)

    haml :'imports/new'
  end
end

get '/all_importers_run' do
  ImportersWorker.perform_async
  halt 200
end