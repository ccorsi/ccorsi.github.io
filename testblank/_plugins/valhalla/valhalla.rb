#########################################################################################
# The following classes are extensions to the current set of tags that are offered with
# Shopify Liquid library.  They are intended to make it easier to produce markdown files
# that use features that aren't part of the markdown language.
#
# Copyright 2024 Claudio Corsi
#########################################################################################
module Jekyll
    module Tags
        module Valhalla
            #
            # The following class is used to generate a link that will open within its
            # own window by applying the target="_blank" attribute to the 'a' element.
            # It uses the passed attributes as part of the element 'a' attributes and
            # the block as the text that will be displayed on the page.
            class ExternalUrlBlock < Liquid::Block
                def initialize(tag_name, markup, tokens)
                    super
                    # Should we consider parsing the markup instead of just
                    # forwarding it to the render page?
                    @attributes = markup
                end
    
                def render(content)
                    # The call to the super class render method will provide the 
                    # text associated with the block text that was passed to this
                    # tag.  This text will then be displayed on the page.
                    text = super
                    "<a #{@attributes} target=\"_blank\">#{text}</a>"
                end
            end
        end
    end
end

# Associate the ExternalUrlBlock class with the exturl tag.
Liquid::Template.register_tag('exturl', Jekyll::Tags::Valhalla::ExternalUrlBlock)