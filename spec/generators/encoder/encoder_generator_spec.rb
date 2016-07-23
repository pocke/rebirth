require 'spec_helper'
require 'generators/encoder/encoder_generator'
require 'ripper'

describe Encoder::Generators::EncoderGenerator do
  let(:test_case){Class.new(Rails::Generators::TestCase)}
  subject{test_case.new(:create_encoder_file).run_generator(arguments)}
  before do
    test_case.tests described_class
    test_case.destination_root = SPEC_TMP_DPR
  end

  after do
    FileUtils.remove_entry_secure(Pathname.new(SPEC_TMP_DPR)/'app/encoders/', true)
  end

  shared_examples 'should_valid_as_a_ruby_script' do |filename|
    it 'should valid as a ruby script' do
      subject
      rb = File.read(Pathname.new(SPEC_TMP_DPR)/filename)
      rip = Class.new(Ripper) do
        def on_parse_error(msg)
          raise msg
        end
      end
      rip.parse(rb)
    end
  end

  context 'simple' do
    let(:arguments){%w[user]}

    include_examples 'should_valid_as_a_ruby_script', 'app/encoders/user_encoder.rb'
  end

  context 'when has ApplicationEncoder' do
    let(:arguments){%w[user]}
    before do
      class ApplicationEncoder; end
    end

    include_examples 'should_valid_as_a_ruby_script', 'app/encoders/user_encoder.rb'

    it 'has ApplicationEncoder' do
      subject
      f = File.read(Pathname.new(SPEC_TMP_DPR)/'app/encoders/user_encoder.rb')
      is_asserted_by{ f.include? 'class UserEncoder < ApplicationEncoder' }
    end

    after do
      Object.__send__ :remove_const, :ApplicationEncoder
    end
  end
end
