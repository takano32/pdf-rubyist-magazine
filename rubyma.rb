#!/usr/bin/env ruby
#
#

require 'rubygems'
require 'mechanize'

require './webzine'

class RubyistMagazine < Webzine
	def initialize
		@agent = Mechanize.new
	end

	def pages(n = 1)
		prefix = sprintf('?%04d', n)
		url = 'http://jp.rubyist.net/magazine/' + prefix
		uri = URI.parse(url)
		response = @agent.get(uri)
		urls = []
		urls << url
		response.links.each do |link|
			next unless link.uri
			next if link.uri.absolute?
			url = (uri + link.uri).to_s
			next if url =~ %r!#{Regexp.escape prefix}-bbs$!
			next if url =~ %r!#{Regexp.escape prefix}$!
			if link.uri.to_s.include?(prefix) then
				urls << url
			end
		end

		pages = []
		urls.each_with_index do |url, index|
			title = url.split(/#{Regexp.escape prefix}-/).last
			title = "" if title == url
			volume = prefix.split('?').last
			page = {}
			page[:url] = url
			index = sprintf('%02d', index)
			page[:basename] = "#{volume}-#{index}#{title.empty? ? "" : "-#{title}"}"
			pages << page
		end
		return pages
	end
end


if $0 == __FILE__ then
	rm = RubyistMagazine.new
	rm.pages(1).each do |page|
		puts page[:url]
	end
end


