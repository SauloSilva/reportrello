class ImportWorker
  include Sidekiq::Worker

  def perform(import_id)
    Trello::Importer.new(import_id).call
  end
end