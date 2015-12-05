get '/reports/new', auth: true do
  haml :'reports/new'
end

get '/reports', auth: true do
  @reports = @current_user.reports
  haml :'reports/index'
end

get '/reports/:id/import', auth: true do
  report = @current_user.reports.find(params[:id])

  case
    when report.present? && report.reported_at.blank? then
      flash[:success] = 'Resqueted with successfully \o/'
      ReportWorker.perform_async(report.id)
    when report.present? && report.reported_at.present? then
      flash[:warning] = 'Report already imported (='
    else
      flash[:error] = "This report #{ report.id } is not your )="
  end

  redirect '/reports'
end

post '/reports', auth: true do
  report = Report.new params[:report]

  if report.save
    ReportWorker.perform_async(report.id)
    redirect '/reports'
  else
    errors_handler(report)
    haml :'reports/new'
  end
end

get '/reports/import_all', auth: true do
  flash[:success] = 'Resqueted with successfully \o/'
  ReportsWorker.perform_async(@current_user.id)
  redirect '/reports'
end

get '/reports/:id', auth: true do
  @report = @current_user.reports.find(params[:id])
  haml :'reports/show'
end