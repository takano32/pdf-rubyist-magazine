#!/usr/bin/env ruby
#
#

require 'rubygems'
require 'mechanize'


number = 1
'http://jp.rubyist.net/magazine/?0001'

class RubyistMagazine
	def initialize
		@agent = Mechanize.new
	end
end


if $0 == __FILE__ then
	rm = RubyistMagazine.new
end


