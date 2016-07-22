require 'spec_helper'

describe Rebirth::MethoBase do
  describe '#to_hash' do
    let(:object){
      Struct.new(:foo, :bar, :baz).new('abc', 'defg', 'hijk')
    }
    subject{klass.new(object).to_hash}

    include_context 'should_serialize'
  end
end
