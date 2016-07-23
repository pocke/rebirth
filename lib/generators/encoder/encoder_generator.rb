require 'rails/generators'

module Encoder
  module Generators
    class EncoderGenerator < Rails::Generators::NamedBase
      source_root File.expand_path('../templates', __FILE__)
      check_class_collision suffix: 'Encoder'

      def create_encoder_file
        template 'encoder.rb.erb', File.join('app/encoders', class_path, "#{file_name}_encoder.rb")
      end


      private

      def parent_class_name
        if defined?(::ApplicationEncoder)
          'ApplicationEncoder'
        else
          'Rebirth::MethodBase'
        end
      end
    end
  end
end
