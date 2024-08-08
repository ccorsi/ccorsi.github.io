module Jekyll
    module Tags
        module Valhalla
            class IncludeBlock < Liquid::Block
                def initialize(tag_name, markup, tokens)
                    super
                    @name = tag_name
                    @data = markup
                    @tokens = tokens
                end # initialize(tag_name. markup, tokens)

                def render_to_output_buffer(content, output)
                    text = super
                    """
                    <p/>render_to_output_buffer(content, output)<p/>
                    The following text was passed to the block of this tag: <p/>
                    #{@data} <p/>
                    """
                end # render_to_output_buffer(content, output)

                def render(content)
                    text = super
                    puts 'name: '.concat @name
                    puts 'Before data: '.concat @data
                    @data.concat(" content=\"", text, '"')
                    puts 'After data: '.concat @data
                    puts @tokens
                    # include = Liquid::Include.new( ''.concat( @name ), ''.concat( @data ), @tokens )
                    # include.render(content)
                    # print 'tokens: '.concat @tokens
                    """

render(content)

The following text was passed to the block of this tag: <p/>

#{@data}

content=\"#{text}\"

                    """
                    Liquid::Template.parse("{% include ".concat(@data).concat(" %}")).render content
                end # render(content)
            end # IncludeBlock

            # This class is used to parse the parameters that are passed to a tag. 
            # It just determines all of the key value pairs that have been generated.
            # It will distinguish between entries that use a ' or " to delineate the
            # key value pairs.  It will allow users to embed those characters such
            # that it can be included with the passed entries.
            class Parse
                def initialize(str)
                   @hash = {}

                   if str
                    if str.size > 0
                        first = 0
                        last = 0
                        # printf("Prcessing input string: '%s'\n", str)
                        while true 
                            break if first >= str.size

                            # find the first non-space character
                            while true
                                if str[first] != ' '
                                    break
                                end

                                first = first + 1
                            end
                            last = first
                            # find the first = character
                            while true
                                break if str[last] == '='

                                last = last + 1
                            end
                            # extract the key
                            key = str[first, last-first]
                            first = last + 1
                            # break
                            # determine the value associated with the defined string
                            case str[first]
                            when '"'
                                # do something
                                first = first + 1
                                last = first
                                while last < str.size
                                    if str[last] == '\\'
                                        last = last + 2
                                        next
                                    end
                                    break if str[last] == '"'

                                    last = last + 1
                                end
                                value = str[first, last-first]
                                first = last + 2
                            when '\''
                                # do something else
                                first = first + 1
                                last = first
                                while true
                                    if str[last] == '\\'
                                        last = last + 2
                                        next
                                    end
                                    break if str[last] == '\''

                                    last = last + 1
                                end
                                value = str[first, last-first]
                                first = last + 2
                            else
                                # find next space character
                                while true
                                    break if str[last] == ' '

                                    last = last + 1
                                end
                                value = str[first, last - first]
                                first = last + 1
                            end # case str[first]
                            @hash[key] = value
                        end # while first < str.size
                    end # str.size > 0
                   end # str
                end # initialize(str)

                def value(key)
                   @hash[key]
                end # value(key)

                def keys()
                   @hash.keys
                end # keys()
            end

            class Capitalize < Liquid::Tag
                # Syntax = /(#{VariableSignature}+)\s*="?\s*(.*)\s*"?/om

                def initialize(tag_name, markup, tokens)
                    @name = tag_name
                    @data = markup
                    @tokens = tokens
                    # m = /\s*=\s*(.*)\s*/.match(markup)
                    # puts '################################ markup:'
                    # puts markup
                    # puts '################################ m:'
                    # puts m
                    # puts '################################ m.captures:'
                    # puts m.captures
                    # puts '################################ m.captures[0]:'
                    # puts m.captures[0]
                    # puts '################################'

                    # start = 0
                    # while equal = markup.index('=', start)
                    #     printf('start: %d, equal: %s', start, equal)
                    #     puts('')
                    #     # find the name of the variable and print it
                    #     if last = markup.rindex(' ', equal)
                    #         printf('1 - lasts: %d, equal: %d, variable name: "%s"', last, equal, markup[last+1,equal-last-1])
                    #         puts('')
                    #     else
                    #         printf('2 - equal: %d, variable name: "%s"', equal, markup[0,equal])
                    #         puts('')
                    #     end
                    #     start = equal + 1
                    # end

                    parse = Parse.new(markup)

                    for key in parse.keys()
                        printf("%s = %s\n", key, parse.value(key))
                    end

                    # if markup =~ Syntax
                    #     @words = Regexp.captures()
                    # end
                end # initialize(tag_name, markup, tokens)

                def render(content)
                   text = super
                   m = @data.match(/\w/)
                #    puts 'Start:'
                #    puts '@data: ', @data
                #    puts 'm: ', m.captures
                #    puts 'content: ', content
                #    puts 'content variable content" ', content.find_variable('content')
                #    puts 'text: ', text
                #    puts 'Returned match from regular expression: ', m
                #    puts 'Done'
                #    m.captures.each { |w| puts w.capitalize[0] }
                   text
                end # render(content)
                # def render_to_output_buffer(content, output)
                #     text = super
                #     m = text.match(/\w/)
                #     m.captures
                # end # render_to_output_buffer(content, output)
            end # Capitalize

            class Count < Liquid::Tag
                def initialize(tag_name, markup, tokens)
                    @parse = Parse.new(markup)
                    @content = @parse.value('content')
                    @single = @parse.value('single')
                    @plural = @parse.value('plural')
                    @key = @parse.value('key')
                    if ! @content
                        # throw an error
                        self.class.raise 'missing content field'
                    elsif ! @single
                        # throw an error
                        self.class.raise 'missing single entry field'
                    elsif ! @plural
                        # throw an error
                        self.class.raise 'missing plural entry field'
                    elsif ! @key
                        # throw an error
                        self.class.raise 'missing key entry field'
                    end
                end # initialize

                def render(content)
                    count = @content.count(@key)
                    text = ""
                    if count == 1
                        text = @single
                    else
                        text = @plural
                    end
                    text
                end # render(content)

                def self.raise(msg)
                   raise Liquid::SyntaxError, msg
                end # self.raise(msg)
            end # Count
        end # Valhalla
    end # Tags
end # Jekyll

Liquid::Template.register_tag("includeex", Jekyll::Tags::Valhalla::IncludeBlock)
Liquid::Template.register_tag("capitalize", Jekyll::Tags::Valhalla::Capitalize)
Liquid::Template.register_tag("count", Jekyll::Tags::Valhalla::Count)
