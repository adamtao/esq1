# run like this:
#
# ruby -I lib examples/read_sysex.rb /path/to/sysex/file.syx
#
require "esq1"

file = ARGV[0] #File.expand_path('spec/fixtures') + '/BASIC.syx'
sysex_data = File.open(file, 'rb').read

@sysex = ESQ1::Sysex.new( sysex_data )

puts @sysex.patches.first.to_s

#puts "-------------------"

#puts @sysex.patches.first.to_h.inspect

