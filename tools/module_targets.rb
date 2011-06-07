#!/usr/bin/env ruby
#
# $Id$
#
# This script lists all modules with their targets
#
# $Revision$
#

msfbase = File.symlink?(__FILE__) ? File.readlink(__FILE__) : __FILE__
$:.unshift(File.join(File.dirname(msfbase), '..', 'lib'))

require 'rex'
require 'msf/ui'
require 'msf/base'

sort=0
fil = 0
filter = ""

opts = Rex::Parser::Arguments.new(
	"-h" => [ false, "Help menu." ],
	"-s" => [ false, "Sort by Target instead of Module Type."],
	"-r" => [ false, "Reverse Sort"],
	"-x" => [ true, "String or RegEx to try and match against the Targets field"]
)

opts.parse(ARGV) { |opt, idx, val|
	case opt
	when "-h"
		puts "\nMetasploit Script for Displaying Module Target information."
		puts "=========================================================="
		puts opts.usage
		exit
	when "-s"
		puts "Sorting by Target"
		sort = 1
	when "-r"
		puts "Reverse Sorting"
		sort = 2
	when "-x"
		puts "Filter: #{val}"
		filter = val
		fil=1		
	end
}

Indent = '    '

# Initialize the simplified framework instance.
$framework = Msf::Simple::Framework.create('DisableDatabase' => true)

tbl = Rex::Ui::Text::Table.new(
	'Header'  => 'Module Targets',
	'Indent'  => Indent.length,
	'Columns' => [ 'Module name','Target' ]
)

all_modules = $framework.exploits

all_modules.each_module { |name, mod|
	x = mod.new
	x.targets.each do |targ|
		if fil==0 or targ.name=~/#{filter}/
			tbl << [ x.fullname, targ.name ]
		end
	end
}

if sort == 1
	tbl.sort_rows(1)
end


if sort == 2
	tbl.sort_rows(1)
	tbl.rows.reverse
end

puts tbl.to_s
