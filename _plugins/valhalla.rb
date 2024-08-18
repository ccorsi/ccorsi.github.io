require 'liquid' # this is required if I want to use these set of classes on the command line using bundle exec ruby
require 'digest' # this is required to be able to generate the different digest hash values
require 'open-uri' # this is required to be able to pull down the file to be able to generate the requested digest hash
require 'net/http'
require 'uri'

module Jekyll
    module Tags
        module Valhalla

            # This class is used to parse the parameters that are passed to a tag.
            # It just determines all of the key value pairs that have been generated.
            # It will distinguish between entries that use a ' or " to delineate the
            # key value pairs.  It will allow users to embed those characters such
            # that it can be included with the passed entries.
            # class Parse
            #     attr_reader :hash

            #     def initialize(str)
            #        @hash = {}

            #        if str
            #         if str.size > 0
            #             first = 0
            #             last = 0
            #             # printf("Prcessing input string: '%s'\n", str)
            #             while true
            #                 break if first >= str.size

            #                 # find the first non-space character
            #                 while true
            #                     if str[first] != ' '
            #                         break
            #                     end

            #                     first = first + 1
            #                 end
            #                 last = first
            #                 # find the first = character
            #                 while true
            #                     break if str[last] == '='
            #                     last = last + 1
            #                 end
            #                 # extract the key
            #                 key = str[first, last-first]
            #                 first = last + 1
            #                 # break
            #                 # determine the value associated with the defined string
            #                 case str[first]
            #                 when '"'
            #                     # do something
            #                     first = first + 1
            #                     last = first
            #                     while last < str.size
            #                         if str[last] == '\\'
            #                             last = last + 2
            #                             next
            #                         end
            #                         break if str[last] == '"'

            #                         last = last + 1
            #                     end
            #                     value = str[first, last-first]
            #                     first = last + 2
            #                 when '\''
            #                     # do something else
            #                     first = first + 1
            #                     last = first
            #                     while true
            #                         if str[last] == '\\'
            #                             last = last + 2
            #                             next
            #                         end
            #                         break if str[last] == '\''

            #                         last = last + 1
            #                     end
            #                     value = str[first, last-first]
            #                     first = last + 2
            #                 else
            #                     # find next space character
            #                     while true
            #                         break if ! ( last < str.length ) || str[last] == ' '
            #                         last = last + 1
            #                     end
            #                     value = str[first, last - first]
            #                     first = last + 1
            #                 end # case str[first]
            #                 if @hash[key]
            #                     # puts "key: #{key} already exists => #{@hash[key]}"
            #                     if @hash[key].kind_of?(Array)
            #                         # puts "key: #{key} is an array"
            #                         @hash[key].push(value)
            #                     else
            #                         # puts "key: #{key} is not an array"
            #                         @hash[key] = [@hash[key], value]
            #                     end
            #                 else
            #                     @hash[key] = value
            #                 end
            #             end # while first < str.size
            #         end # str.size > 0
            #        end # str
            #     end # initialize(str)
            # end # Parse

            class KeyValues
                attr_reader :hash

                def initialize(str)
                    puts "Parsing string: #{str}"
                    # initialize the hash table
                    @hash = {}
                    # parse the passed string for key/value strings separated by '='
                    idx = 0
                    while idx < str.size
                        # skip whitespaces
                        while idx < str.size && str[idx] == ' '
                            idx += 1
                        end # while
                        
                        break if idx == str.size

                        start = idx
                        # find variable name
                        while idx < str.size && str[idx] != '=' && str[idx] != ' '
                            idx += 1
                        end # while

                        break if idx == str.size

                        name = str[start, idx - start].strip

                        # find begining of value
                        while idx < str.size && ( str[idx] == '=' || str[idx] == ' ' )
                            idx +=1
                        end # while

                        break if idx == str.size

                        start = idx

                        # find the next variable or end of string
                        if str[idx] == '"' || str[idx] == "'"
                            target = str[idx]
                            idx += 1
                            while idx < str.size
                                break if str[idx] == target
                                if str[idx] == '\\'
                                    idx += 2
                                else
                                    idx += 1
                                end
                            end # while
                            value = str[start + 1, idx - start - 1].strip
                            idx += 1
                        else
                            puts str[start,str.size-start]
                            puts "1 - start: #{start} idx: #{idx}"
                            # find the next '=' character
                            while idx < str.size && str[idx] != '='
                                idx += 1
                            end # while
                            if idx < str.size
                                puts "2 - start: #{start} idx: #{idx}"
                                while idx > start && str[idx-1] == ' '
                                    idx -= 1
                                end # while
                                puts "3 - start: #{start} idx: #{idx}"
                                while idx > start && str[idx-1] != ' '
                                    idx -= 1
                                end # while
                                puts "4 - start: #{start} idx: #{idx}"
                            end # if
                            value = str[start, idx - start].strip
                        end

                        if @hash[name]
                            @hash[name].kind_of?(Array) ? @hash[name].push(value) : @hash[name] = [@hash[name], value]
                            #if @hash[name].kind_of?(Array)
                                #@hash[name].push(value)
                            #else
                                #@hash[name] = [@hash[name], value]
                            #end
                        else
                            @hash[name] = value
                        end
                    end # while
                end # initialize(str)
            end # parser

            class Digest < Liquid::Tag
                Syntax = /(#{Liquid::VariableSignature}+)\s*=\s*(.*)\s*/om

                def initialize(tag_name, markup, parse_context)
                    super
                     # Parse the passed parameter
                     parse = KeyValues.new(markup)

                     # determine that only a single parameter was passed
                     if parse.hash.keys != 1
                        raise Liquid::SyntaxError, 'Only a single parameter is allowed'
                    end

                    @digest = parse.hash[0]
                    @uri    = parse.hash[1]
                end # initialize(tag_name, markup, tokens)

                def render(content)
                end # render(content)

                def render_to_output_buffer(context, output)
                    output
                end # render_to_output_buffer(context, output)
           end # Digest

        end # Valhalla
     end # Tags
end # Jekyll

Liquid::Template.register_tag("digest", Jekyll::Tags::Valhalla::Digest)
# To be able to execute this ruby script outside of using Jekyll use the following command:

# $ bundle exec ruby _plugins/valhalla.rb ...

if __FILE__ == $0
    hashes = {}
    count = 0
    while count + 1 < ARGV.length do
        if ! ARGV[count].start_with?('--')
            puts "Invalid command argument line: #{ARGV[count]}"
            exit 1
        end
        key = ARGV[count][2, ARGV[count].length - 2]
        puts "Command line option: #{ARGV[count]}, key: #{key}"
        if hashes[key]
            puts "Key: #{key} already exists"
            hashes[key].push(ARGV[count+1])
        else
            puts "Key: #{key} doesn't exists"
            hashes[key] = [ARGV[count+1]]
        end
        puts "hashes[#{key}]: #{hashes[key]}"
        count += 2
    end
    puts "hashes: #{hashes}"

    if count < ARGV.length
        puts "Invalid command line arguments was passed: #{ARGV[count]}"
        exit 2
    end

    hashes.keys.each do | digest |
        case digest
        when 'sha256'
            hashes[key].each do | url |
                data = Net::HTTP.get( URI.parse( url ) )
                hash = Digest::SHA256.hexdigest data
                puts "sha256-#{hash}"
            end
        when 'sha384'
            hashes[key].each do | url |
                data = Net::HTTP.get( URI.parse( url ) )
                hash = Digest::SHA384.hexdigest data
                puts "sha384-#{hash}"
            end
        when 'sha512'
            hashes[key].each do | url |
                data = Net::HTTP.get( URI.parse( url ) )
                hash = Digest::SHA512.hexdigest data
                puts "sha512-#{hash}"
            end
        when 'md5'
            hashes[key].each do | url |
                data = Net::HTTP.get( URI.parse( url ) )
                hash = Digest::MD5.hexdigest data
                puts "md5-#{hash}"
            end
        else
            puts "Unable to generate hash key for unknown digest: #{digest}"
        end
    end

    # These are all of the general default regular expression that is part of the Liquid library
    FilterSeparator             = /\|/
    ArgumentSeparator           = ','
    FilterArgumentSeparator     = ':'
    VariableAttributeSeparator  = '.'
    WhitespaceControl           = '-'
    TagStart                    = /\{\%/
    TagEnd                      = /\%\}/
    TagName                     = /#|\w+/
    VariableSignature           = /\(?[\w\-\.\[\]]\)?/
    VariableSegment             = /[\w\-]/
    VariableStart               = /\{\{/
    VariableEnd                 = /\}\}/
    VariableIncompleteEnd       = /\}\}?/
    QuotedString                = /"[^"]*"|'[^']*'/
    QuotedFragment              = /#{QuotedString}|(?:[^\s,\|'"]|#{QuotedString})+/o
    TagAttributes               = /(\w[\w-]*)\s*\:\s*(#{QuotedFragment})/o
    AnyStartingTag              = /#{TagStart}|#{VariableStart}/o
    PartialTemplateParser       = /#{TagStart}.*?#{TagEnd}|#{VariableStart}.*?#{VariableIncompleteEnd}/om
    TemplateParser              = /(#{PartialTemplateParser}|#{AnyStartingTag})/om
    VariableParser              = /\[(?>[^\[\]]+|\g<0>)*\]|#{VariableSegment}+\??/o
  
    # Syntax = /(#{Liquid::VariableSignature}+)\s*=\s*(.*)\s*/om

    Syntax = /(#{Liquid::QuotedFragment}+)(\s+(#{Liquid::QuotedFragment}+))?/o

    # Syntax = /(\w[\w-]*)\s*=\s*(#{Liquid::QuotedFragment})/om

    markup = '    sh256="https://www.google.com"  sh256="https://www.infoq.com" sha256=  page.url | absolute_url'

    if markup =~ Syntax
        puts "markup: #{markup}"
        for idx in 1 ... Regexp.last_match.size
            puts "idx: #{idx} value: #{Regexp.last_match(idx)}"
        end
        puts "Regexp: #{Regexp.last_match.size}"
        puts "Regexp captures: #{Regexp.last_match.captures}"
        Regexp.last_match.captures do | match |
            puts "match: #{match}"
        end
        puts "Entry 1: #{Regexp.last_match(1).strip}"
        puts "Entry 2: #{Regexp.last_match(2).strip}"
        puts "Entry 3: #{Regexp.last_match(3).strip}"
        markup.scan(/(\w[\w-]*)\s*=\s*(#{Liquid::QuotedFragment})/om) do | key, value |
            puts "key: #{key}, value: #{value.strip()}"
        end
    end

    puts "parse"
    parse = Jekyll::Tags::Valhalla::KeyValues.new('sha256 = "https://www.google.com"  sha256="https://www.infoq.com"   sha256=   page.url | absolute_url | default: "n/a" sha512=https://www.infoq.com  sha384    =   https://www.infoq.com')
    puts "Results: #{parse.hash}"
    parse.hash.each_pair do | digest, urls |
        if urls.kind_of?(Array)
            urls.each do | url |
                puts "digest: [#{digest}] => [#{url}]"
            end
        else
            puts "digest: [#{digest}] => [#{urls}]"
        end
    end
end
