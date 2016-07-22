# vim: set ft=ruby.rspec: 

RSpec.shared_context 'should_serialize' do
  context 'when specify an attribute by attributes' do
    let(:klass) do
      Class.new(described_class) do
        attributes :foo
      end
    end

    it  do
      is_asserted_by{ subject == {foo: 'abc'} }
    end
  end

  context 'when specify an attribute by attribute' do
    let(:klass) do
      Class.new(described_class) do
        attribute :bar
      end
    end

    it  do
      is_asserted_by{ subject == {bar: 'defg'} }
    end
  end
end
