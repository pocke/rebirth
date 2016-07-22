module Rebirth
  attr_reader :object

  extend ActiveSupport::Concern

  def initialize(object)
    @object = object
  end

  # @return [Hash]
  def to_hash
    hash = {}
  end
end
