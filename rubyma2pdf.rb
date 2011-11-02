#!/usr/bin/env ruby
#
#

require './rubyma'


rm = RubyistMagazine.new
%x(mkdir -p out/rubyma)
pages = rm.pages(1)
pages.each do |page|
	%x(wkhtmltopdf '#{page[:url]}' ./out/rubyma/#{page[:basename]}.pdf)
end

