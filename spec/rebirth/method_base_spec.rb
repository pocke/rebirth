require 'spec_helper'

describe Rebirth::MethoBase do
  describe '#to_hash' do
    let(:object){
      hoge = Struct.new(:neko, :inu).new('nyan', 'wan')
      Struct.new(:foo, :bar, :baz, :hoge).new('abc', 'defg', 'hijk', hoge)
    }
    subject{klass.new(object).to_hash}

    include_context 'should_serialize'
  end
end
