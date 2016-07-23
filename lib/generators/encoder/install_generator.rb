require 'rails/generators'

module Encoder
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)

      def create_encoder_file
        template 'encoder.rb.erb', File.join('app/encoders', "application_encoder.rb")
      end


      private

      def parent_class_name
        'Rebirth::MethodBase'
      end

      def class_name
        'ApplicationEncoder'
      end
    end
  end
end
