require 'spec_helper'
require 'generators/encoder/install_generator'
require 'ripper'

describe Encoder::Generators::InstallGenerator do
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

    include_examples 'should_valid_as_a_ruby_script', 'app/encoders/application_encoder.rb'
  end
end
