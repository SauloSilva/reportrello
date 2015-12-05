class ImportersWorker
  include Sidekiq::Worker

  def perform
    ::Import.not_imported.each do |import|
      ::ImportWorker.perform_async(import.id)
    end
  end
end