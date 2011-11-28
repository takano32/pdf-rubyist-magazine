#!/usr/bin/env ruby
#
#

require './vyatta'


vm = VyattaManual.new
%x(mkdir -p out/vyatta)
pages = vm.pages
pages.each do |page|
	%x(wget '#{page[:url]}' -O ./out/vyatta/#{page[:basename]}.pdf)
end

