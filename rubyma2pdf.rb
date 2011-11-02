#!/usr/bin/env ruby
#
#

require './rubyma'


rm = RubyistMagazine.new
%x(mkdir -p out/rubyma)
for i in 1..35 do
	pages = rm.pages(i)
	pages.each do |page|
		%x(wkhtmltopdf '#{page[:url]}' ./out/rubyma/#{page[:basename]}.pdf)
	end
end

