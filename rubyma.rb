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
		pages = []
		pages << {:url => url}
		response.links.each do |link|
			next unless link.uri
			next if link.uri.absolute?
			url = (uri + link.uri).to_s
			next if url =~ %r!#{Regexp.escape suffix}-bbs$!
			next if url =~ %r!#{Regexp.escape suffix}$!
			if link.uri.to_s.include?(suffix) then
				pages << {:url => url}
			end
		end
		return pages
	end
end


if $0 == __FILE__ then
	rm = RubyistMagazine.new
	rm.volume(1).each do |page|
		puts page[:url]
	end
end


