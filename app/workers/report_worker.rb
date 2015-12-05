class ReportWorker
  include Sidekiq::Worker

  def perform(import_id)
    Trello::Report.new(import_id).call
  end
end