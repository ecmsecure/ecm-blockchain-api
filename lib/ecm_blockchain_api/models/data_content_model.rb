module ECMBlockchain
  class DataContent
    include ActiveModel::Validations
    attr_accessor :data

    validate :empty_data

    def initialize(data={})
      data ||= {}
      @data = data.deep_symbolize_keys
      create_data_attr_accessors
    end

    def added?
      @data.any?
    end

    private

    def create_data_attr_accessors
      @data.each do |name, value|
        self.class.class_eval { attr_accessor name }
        self.instance_variable_set("@#{name}", value)
      end
    end

    def empty_data
      errors.add(:base, "Please supply at least one key value pair") unless data.any?
    end
  end
end
