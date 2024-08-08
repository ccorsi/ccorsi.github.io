# The following file contains several user defined tags that can be used to enhance
# the generation of the different web content.
module Jekyll
    module Tags
        module Valhalla
            # This tag will create a given tag with the passed attributes and
            # wrap the inner block content.  It was defined as a block to allow
            # for the possibility of including inner block elements or not.
            class Element < Liquid::Block
                def initialize(tag_name, markup, tokens)
                    super
                    tmp=markup.split
                    # extract the element name
                    @name = tmp[0]
                    # extract the element attributes
                    @attributes = tmp[1..-1].join(' ')
                end
    
                def render(content)
                    # Assign the block data to a local variable
                    text = super
                    # check is the text variable is non-empty or not
                    "<#{@name} #{@attributes}>#{text}</#{@name}>"
                end
            end

            # This tag will create the id attribute within a html element.
            class Id < Liquid::Tag
                def initialize(tag_name, markup, tokens)
                    super
                    @id_value=markup
                end

                def render(content)
                    text = super
                    "id=\"#{@id_value}\""
                end
            end

            # This tag will create the class attribute within a html element
            class Class < Liquid::Tag
                def initialize(tag_name, markup, tokens)
                    super
                    @class_value=markup
                end

                def render(content)
                    text = super
                    "class=\"#{@class_value}\""
                end
            end
        end
    end
end

# List of defined tags
Liquid::Template.register_tag("id", Jekyll::Tags::Valhalla::Id)
Liquid::Template.register_tag("class", Jekyll::Tags::Valhalla::Class)
Liquid::Template.register_tag("element", Jekyll::Tags::Valhalla::Element)
