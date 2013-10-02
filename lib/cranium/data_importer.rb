require 'sequel'

class Cranium::DataImporter

  def import(import_definition)
    external_table = Cranium::ExternalTable.new Cranium.application.sources[import_definition.name], database_connection
    external_table.create
    begin
      database_connection.run insert_query(external_table, import_definition)
    ensure
      external_table.destroy
    end
  end



  private

  def database_connection
    @connection ||= Sequel.connect Cranium.configuration.greenplum_connection_string, loggers: Cranium.configuration.loggers
  end



  def insert_query(external_table, import_definition)
    <<-sql
      INSERT INTO #{import_definition.to} (#{import_definition.field_associations.values.join ", "})
          SELECT #{import_definition.field_associations.keys.join ", "}
          FROM #{external_table.name}
    sql
  end

end
