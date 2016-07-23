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
  end
end
