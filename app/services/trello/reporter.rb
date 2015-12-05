module Trello
  class Report
    def initialize(report_id)
      @report = ::Report.find(report_id)
    end

    attr_reader :report

    def call
      Trello::Reports::Task.new(report).call
    end
  end
end