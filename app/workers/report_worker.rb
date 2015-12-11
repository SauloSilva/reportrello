class ReportWorker
  include Sidekiq::Worker
  sidekiq_options queue: :import, retry: 1

  def perform(import_id)
    Trello::Report.new(import_id).call
  end
end