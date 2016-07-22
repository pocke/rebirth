require 'spec_helper'

describe Rebirth::MethoBase do
  describe '#to_hash' do
    let(:object){
      Struct.new(:foo, :bar, :baz).new('abc', 'defg', 'hijk')
    }
    subject{klass.new(object).to_hash}


    context 'when specy an attributes' do
      let(:klass) do
        Class.new(described_class) do
          attributes :foo
        end
      end

      it  do
        is_asserted_by{ subject == {foo: 'abc'} }
      end
    end
  end
end
