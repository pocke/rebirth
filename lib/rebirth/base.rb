module Rebirth
  class Base
    attr_reader :object

    class_attribute :table_attributes, :table_has_manies, :table_belongs_to, :table_attribute_methods

    class << self
      def inherited(klass)
        klass.table_attributes = []
        klass.table_has_manies = {}
        klass.table_belongs_to = {}
        klass.table_attribute_methods = {}
      end

      def attributes(*args)
        self.table_attributes.concat(args)
      end

      def attribute(arg)
        self.table_attributes.push(arg)
      end
    end


    def initialize(object)
      @object = object
    end

    # @return [Hash]
    def to_hash
      hash = {}
      self.class.table_attributes.each do |key|
        hash[key] = __get_value(key)
      end

      hash
    end
  end
end
