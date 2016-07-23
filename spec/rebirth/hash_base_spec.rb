require 'spec_helper'

describe Rebirth::HashBase do
  describe '#to_hash' do
    let(:object){{
      foo: 'abc',
      bar: 'defg',
      baz: 'hijk',
      hoge: {
        neko: 'nyan',
        inu: 'wan',
      },
      poyos: [
        {payo: 1, piyo: 3, peyo: 42},
        {payo: 2, piyo: 5, peyo: 38},
        {payo: 3, piyo: 7, peyo: 10},
      ]
    }}
    subject{klass.new(object).to_hash}


    include_context 'should_serialize'

    context 'when object has cicular dependency' do
      let(:object) do
        parent = {
          foo: 'abc',
        }
        child = {
          hoge: 'fuga',
          parent: parent,
        }
        parent[:children] = [child]

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
        subject
      end
    end
  end
end
