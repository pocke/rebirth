require 'spec_helper'
require 'generators/encoder/install_generator'
require 'ripper'

describe Encoder::Generators::InstallGenerator, :with_generator do
  context 'simple' do
    let(:arguments){%w[user]}

    include_examples 'should_valid_as_a_ruby_script', 'app/encoders/application_encoder.rb'
  end
end
