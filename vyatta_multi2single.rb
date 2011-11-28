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

pdfs = pages.map do |page|
	page[:basename]
end.join(' ')
%x(cd ./out/vyatta && pdftk #{pdfs} cat output vyatta.pdf)

