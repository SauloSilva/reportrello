class ReportsWorker
  include Sidekiq::Worker

  def perform(user_id)
    ::Report.not_reported.by_user(user_id).each do |report|
      ::ReportWorker.perform_async(report.id)
    end
  end
end