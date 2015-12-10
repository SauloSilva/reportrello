module Trello
  class Report
    def initialize(report_id)
      @report = ::Report.find(report_id)
    end

    def call
      import_environments
    end

    private

    attr_reader :report

    def import_environments
      return unless report

      report.environments.each do |environment|
        Trello::Reports::Task.new(environment).call
      end

      report.update_attributes(reported_at: Time.now, status: 'success', log: 'Imported has been success!')
    rescue Trello::Errors::BoardNotFound, Trello::Errors::ListNotFound => error
      report.update_attributes(status: 'warning', log: error.message)
    end
  end
end