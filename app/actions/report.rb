# action New

get '/reports/new', auth: true do
  @report = @current_user.reports.new
  @report.environments.new

  haml :'reports/new'
end

# action Index

get '/reports', auth: true do
  @reports = @current_user.reports
  haml :'reports/index'
end

# action Import

get '/reports/:id/import', auth: true do
  report = @current_user.reports.find(params[:id])

  case
    when report.present? && report.reported_at.blank? then
      flash['alert alert-success'] = 'Resqueted with successfully \o/'
      ReportWorker.perform_async(report.id)
    when report.present? && report.reported_at.present? then
      flash['alert alert-info'] = 'Report already imported (='
    else
      flash['alert alert-danger'] = "This report #{ report.id } is not your )="
  end

  redirect '/reports'
end

# action Create

post '/reports', auth: true do
  @report = @current_user.reports.new params[:report]

  if @report.save
    ReportWorker.perform_async(@report.id)
    redirect '/reports'
  else
    errors_handler(@report)
    haml :'reports/new'
  end
end

# action Import All

get '/reports/import_all', auth: true do
  flash['alert alert-success'] = 'Resqueted with successfully \o/'
  ReportsWorker.perform_async(@current_user.id)
  redirect '/reports'
end

# action Show

get '/reports/:id', auth: true do
  @report = @current_user.reports.find(params[:id])
  haml :'reports/show'
end


# action Edit

get '/reports/:id/edit', auth: true do
  @report = @current_user.reports.find(params[:id])
  haml :'reports/edit'
end

# action Update

post '/reports/:id/edit', auth: true do
  @report = @current_user.reports.find(params[:id])

  case
    when @report.warning? && @report.update_attributes(params[:report]) then
      flash['alert alert-success'] = 'Report has been updated!'
      ReportWorker.perform_async(@report.id)
      redirect '/reports'
    when report.warning? && !@report.update_attributes(params[:report]) then
      errors_handler(@report)
      haml :'reports/edit'
    else
      flash['alert alert-danger'] = "This report #{ report.id } is not your )="
      redirect '/reports'
  end
end

# action Destroy

get '/reports/:id/delete', auth: true do
  @current_user.reports.find(params[:id]).destroy
  redirect '/reports'
end

# action Show PDF

get '/reports/:id/:report_name', auth: true do
  @report = @current_user.reports.find(params[:id])
  haml :'reports/show', layout: :print
end