require 'spec_helper'
require 'generators/encoder/encoder_generator'
require 'ripper'

describe Encoder::Generators::EncoderGenerator, :with_generator do
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
