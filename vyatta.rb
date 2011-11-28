#!/usr/bin/env ruby
#
#

require 'rubygems'
require 'mechanize'

require './webzine'

class VyattaManual < Webzine
	def initialize
		@agent = Mechanize.new
	end

	def pages
		url = 'http://www.vyatta.com/download/docdl'
		uri = URI.parse(url)
		response = @agent.get(uri)
		urls = []
		response.links.each do |link|
			next unless link.uri
			next if link.uri.absolute?
			next unless link.uri.to_s =~ %r!\.pdf$!
			url = (uri + link.uri).to_s
			urls << url
		end

		pages = []
		urls.each_with_index do |url, index|
			title = url.split(%r!/!).last
			title = "" if title == url
			page = {}
			page[:url] = url
			index = sprintf('%02d', index)
			page[:basename] = title.gsub(%r!\.pdf$!, '')
			pages << page
		end
		return pages
	end
end

if $0 == __FILE__ then
	vm = VyattaManual.new
	vm.pages.each do |page|
		puts page[:url]
		puts page[:basename]
	end
end


