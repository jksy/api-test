namespace :grape_generator do
  desc 'generate entity and controller for grape'
  task generate: :environment do
    reject_tables = ["schema_migrations", "ar_internal_metadata", 'users']
    tables = ActiveRecord::Base.connection.tables.reject { |table_name| reject_tables.include? table_name }

    tables.each do |table_name|
      model_name = guess_model_from table_name
      model = model_name.constantize
      unless model.new.kind_of? ActiveRecord::Base
        Kernel.warn "#{model} is not found. Ignore this table #{table_name}"
        next
      end
      generate_entity model
    end
  end

  class EntityGenerator
    def initialize model
      @model = model
      @template = "#{File.join(File.dirname(__FILE__), 'templates', 'entity.rb.erb')}"
    end

    def generate
      puts "generating.... #{@model}"
      erb = ERB.new(File.read(@template), trim_mode: '%-')
      result = erb.result(binding)
      File.write(output_path, result)
      puts "done"
    end

    def entity_name
      @model.to_s.camelize
    end

    def columns
      @model.columns.map do |column|
        {name: column.name, type: column.type.to_s.camelize, comment: column.comment, example: guess_example_for(column)}
      end
    end

    def guess_type_for column
      case column.type.intern
      when :integer
        'Integer'
      when :string, :datetime, :timestamp
        'String'
      else
        raise "guess_type_for is not supported type: #{column.type}"
      end
    end

    def guess_example_for column
      case column.type.intern
      when :integer
        1234
      when :string
        'abc'
      when :datetime
        '2020-01-01T12:34:56'
      end
    end

    def output_path
      path = "#{Rails.root}/app/api/v1/entities/#{@model.to_s.downcase}.rb"
      FileUtils.mkdir_p File.dirname(path)
      path
    end
  end

  def guess_model_from table_name
    table_name.singularize.camelcase
  end

  def generate_entity model
    generator = EntityGenerator.new model
    generator.generate
  end
end
