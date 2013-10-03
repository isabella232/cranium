require 'cranium/dsl'

module Cranium

  autoload :Application, 'cranium/application'
  autoload :AttributeDSL, 'cranium/attribute_dsl'
  autoload :Configuration, 'cranium/configuration'
  autoload :TransformationRecord, 'cranium/transformation_record'
  autoload :DataImporter, 'cranium/data_importer'
  autoload :DataTransformer, 'cranium/data_transformer'
  autoload :ExternalTable, 'cranium/external_table'
  autoload :ImportDefinition, 'cranium/import_definition'
  autoload :Logging, 'cranium/logging'
  autoload :Source, 'cranium/source'
  autoload :SourceRegistry, 'cranium/source_registry'
  autoload :TestFramework, 'cranium/test_framework'
  autoload :TransformDefinition, 'cranium/transform_definition'

  class << self

    def application
      @application ||= Application.new
    end



    def configuration
      @configuration ||= Configuration.new.freeze
    end



    def configure
      mutable_configuration = configuration.dup
      yield mutable_configuration
      @configuration = mutable_configuration
      @configuration.freeze
    end

  end

end
