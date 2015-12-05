module Trello
  class Importer
    def initialize(import_id)
      @import = Import.find(import_id)
    end

    attr_reader :import

    def call
      Trello::Importers::Task.new(import).call
    end
  end
end