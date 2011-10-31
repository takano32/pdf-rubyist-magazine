#!/usr/bin/env ruby
#
#

require 'rubygems'
require 'mechanize'


class RubyistMagazine
	def initialize
		@agent = Mechanize.new
	end

	def volume(n)
		suffix = sprintf('?%04d', n)
		url = 'http://jp.rubyist.net/magazine/' + suffix
		uri = URI.parse(url)
		response = @agent.get(uri)
		links = []
		links << url
		response.links.each do |link|
			next unless link.uri
			next if link.uri.absolute?
			url = (uri + link.uri).to_s
			next if url =~ /\/\?[0-9]+-bbs$/
			next if url =~ /\/\?[0-9]+$/
			if link.uri.to_s.include?(suffix) then
				links << url
			end
		end
		puts links
	end
end


if $0 == __FILE__ then
	rm = RubyistMagazine.new
	rm.volume 1
end


