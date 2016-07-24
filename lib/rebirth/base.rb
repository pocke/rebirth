module Rebirth
  class Base
    attr_reader :object

    class_attribute :table_attributes, :table_has_manies, :table_belongs_to, :table_attribute_methods, :allow_nest_rule

    class << self
      def inherited(klass)
        klass.table_attributes = []
        klass.table_has_manies = {}
        klass.table_belongs_to = {}
        klass.table_attribute_methods = {}
        klass.allow_nest_rule = {}
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

      def has_many(key, klass)
        self.table_has_manies[key] = klass
      end

      # TODO: naming
      def attribute_method(key, method = nil, &block)
        # TODO: validate argument
        self.table_attribute_methods[key] = method || block
      end

      # TODO: naming
      # @param rule [Hash]
      def allow_nest(rule)
        self.allow_nest_rule = rule
      end
    end


    # @param object [Object] target object
    # @param nest_rule [Hash] TODO: naming
    # @param root [Boolean]
    def initialize(object, nest_rule: self.class.allow_nest_rule, root: true)
      @object = object
      @nest_rule = nest_rule
      @root = root
    end

    # @return [Hash]
    def to_hash
      hash = {}
      self.class.table_attributes.each do |key|
        hash[key] = __get_value(key)
      end

      self.class.table_belongs_to.each do |key, klass|
        if nest_allowed?(key)
          value = __get_value(key)
          hash[key] = klass.new(value, nest_rule: @nest_rule[key], root: false).to_hash
        end
      end

      self.class.table_has_manies.each do |key, klass|
        if nest_allowed?(key)
          hash[key] = __get_value(key).map do |v|
            klass.new(v, nest_rule: @nest_rule[key], root: false).to_hash
          end
        end
      end

      self.class.table_attribute_methods.each do |key, method|
        hash[key] =
          if method.respond_to?(:call)
            instance_eval(&method)
          else
            __send__ method
          end
      end

      hash
    end


    private

    def nest_allowed?(key)
      return @root || (@nest_rule.is_a?(Hash) && @nest_rule[key])
    end
  end
end
