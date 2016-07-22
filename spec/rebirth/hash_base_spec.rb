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
    }}
    subject{klass.new(object).to_hash}


    include_context 'should_serialize'
  end
end
