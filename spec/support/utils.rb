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

  context 'when specify 2 attributes' do
    let(:klass) do
      Class.new(described_class) do
        attributes :foo, :baz
      end
    end

    it  do
      is_asserted_by{ subject == {foo: 'abc', baz: 'hijk'} }
    end
  end

  context 'when specify an attribute and a belongs_to' do
    let(:klass) do
      superclass = described_class
      Class.new(superclass) do
        attributes :foo

        belongs_to_class = Class.new(superclass) do
          attributes :neko
        end
        belongs_to :hoge, belongs_to_class
      end
    end

    it  do
      is_asserted_by{ subject == {foo: 'abc', hoge: {neko: 'nyan'}} }
    end
  end

  context 'when specify has_many' do
    let(:klass) do
      superclass = described_class
      Class.new(superclass) do
        attributes :baz

        has_many_class = Class.new(superclass) do
          attributes :piyo, :peyo
        end
        has_many :poyos, has_many_class
      end
    end

    it do
      expected = {
        baz: 'hijk',
        poyos: [
          {piyo: 3, peyo: 42},
          {piyo: 5, peyo: 38},
          {piyo: 7, peyo: 10},
        ],
      }
      is_asserted_by{ subject == expected}
    end
  end

  context 'when specify an attribute_method by symbol' do
    let(:klass) do
      Class.new(described_class) do
        attribute_method :bar, :upcased_bar

        def upcased_bar
          object[:bar].upcase
        end
      end
    end

    it  do
      is_asserted_by{ subject == {bar: 'DEFG'} }
    end
  end

  context 'when specify an attribute_method by lambda' do
    let(:klass) do
      Class.new(described_class) do
        attribute_method :bar, -> (_self) { object[:bar].upcase }
      end
    end

    it  do
      is_asserted_by{ subject == {bar: 'DEFG'} }
    end
  end

  context 'when specify an attribute_method by block' do
    let(:klass) do
      Class.new(described_class) do
        attribute_method :bar do
          object[:bar].upcase
        end
      end
    end

    it  do
      is_asserted_by{ subject == {bar: 'DEFG'} }
    end
  end
end
