require 'addressable/uri'

module SocialButtons
  module Pinit
    include SocialButtons::Assistant

    PINIT_CREATE_BUTTON = "//www.pinterest.com/pin/create/button/"
    PINIT_BUTTON_IMAGE  = "//assets.pinterest.com/images/pidgets/pin_it_button.png"
    CLASS = "pin-it-button"
    TITLE = "Pin It"

    def pinit_button(options = {})
      clazz = SocialButtons::Pinit
      default_options = {url: request.url, media: request.url}
      params = clazz.default_options.merge(default_options).merge(options)
      params.merge!(:class => CLASS)
      params_for_pin = params.slice(:url, :media, :description)

      option_params = params.except(:url, :media, :description)
      pinit_link    = Addressable::URI.parse(PINIT_CREATE_BUTTON).tap do |u|
        u.query_values = params_for_pin
      end.to_s
      p pinit_link

      html = link_to(pinit_link, option_params) do
        image_tag PINIT_BUTTON_IMAGE, border: ("0" || options[:border]), title: (TITLE || options[:title])
      end
      p html
      html << clazz::Scripter.new(self).script
      html
    end

    class << self
      def default_options
        @default_options ||= {
          description: "Pin Me!"
        }
      end
    end

    class Scripter < SocialButtons::Scripter
      def script
        return empty_content if widgetized? :pinit
        widgetized! :pinit
        "<script src=#{pinit_js} type='text/javascript' async></script>".html_safe
      end

      def pinit_js
        "https://assets.pinterest.com/js/pinit.js"
      end
    end
  end
end
