require 'spec_helper'

describe Rebirth::MethoBase do
  describe '#to_hash' do
    let(:object){
      poyo_struct = Struct.new(:payo, :piyo, :peyo)
      hoge = Struct.new(:neko, :inu).new('nyan', 'wan')
      poyos = [
        poyo_struct.new(1, 3, 42),
        poyo_struct.new(2, 5, 38),
        poyo_struct.new(3, 7, 10),
      ]
      Struct.new(:foo, :bar, :baz, :hoge, :poyos).new('abc', 'defg', 'hijk', hoge, poyos)
    }
    subject{klass.new(object).to_hash}

    include_context 'should_serialize'
  end
end
