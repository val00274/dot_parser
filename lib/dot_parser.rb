require 'dot_parser/version.rb'
require 'dot_parser.tab.rb'

module DotParser
  def self.read(file)
    open(file, "r") do |f|
      Parser.new.read(f)
    end
  end
end

