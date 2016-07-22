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

      def attribute(key)
        self.table_attributes.push(key)
      end

      def belongs_to(key, klass)
        self.table_belongs_to[key] = klass
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
      self.class.table_belongs_to.each do |key, klass|
        hash[key] = klass.new(__get_value(key)).to_hash
      end

      hash
    end
  end
end
