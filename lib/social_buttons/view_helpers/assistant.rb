module SocialButtons
  module Assistant
    extend ActiveSupport::Concern

    module ClassMethods
      attr_writer :default_options

      def myname
        self.name.demodulize
      end

      def help
        "Please HELP by filling in the help of the #{myname} button :) (see google+ button code)"
      end

      def options_to_data_params(opts)
        params = {}
        opts.each {|k, v| params["data-#{k}"] = v}
        params
      end

      protected

      def help_note
        "Note: SocialButons will ensure that the button script is only rendered once!"
      end
    end
  end
end
