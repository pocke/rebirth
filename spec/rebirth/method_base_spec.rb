require 'spec_helper'

describe Rebirth::MethoBase do
  describe '#to_hash' do
    let(:object){
      poyo_struct = Struct.new(:payo, :piyo, :peyo)
      fuga = Struct.new(:cat, :dog).new('meow', 'bow')
      hoge = Struct.new(:neko, :inu, :fuga).new('nyan', 'wan', fuga)
      poyos = [
        poyo_struct.new(1, 3, 42),
        poyo_struct.new(2, 5, 38),
        poyo_struct.new(3, 7, 10),
      ]
      Struct.new(:foo, :bar, :baz, :hoge, :poyos).new('abc', 'defg', 'hijk', hoge, poyos)
    }
    subject{klass.new(object).to_hash}

    include_context 'should_serialize'

    context 'when object has cicular dependency' do
      let(:object) do
        parent = Struct.new(:foo, :children).new('abc')
        child = Struct.new(:hoge, :parent).new('fuga', parent)
        parent.children = [child]

        parent
      end

      let(:klass){
        parent_encoder = Class.new(described_class) do
          attributes :foo
        end
        child_encoder = Class.new(described_class) do
          attributes :hoge
          belongs_to :parent, parent_encoder
        end
        parent_encoder.class_eval do
          has_many :children, child_encoder
        end

        parent_encoder
      }

      it  do
        is_asserted_by{ subject == {foo: 'abc', children: [{hoge: 'fuga'}]} }
      end
    end
  end
end
