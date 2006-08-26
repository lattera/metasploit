require 'msf/core'
require 'msf/core/payload/generic'
require 'msf/core/handler/bind_tcp'

module Msf
module Payloads
module Singles
module Generic

module ShellBindTcp

	include Msf::Payload::Single
	include Msf::Payload::Generic

	def initialize(info = {})
		super(merge_info(info,
			'Name'          => 'Generic Command Shell, Bind TCP Inline',
			'Version'       => '$Revision: 3425 $',
			'Description'   => 'Listen for a connection and spawn a command shell',
			'Author'        => 'skape',
			'License'       => MSF_LICENSE,
			'Handler'       => Msf::Handler::BindTcp,
			'Session'       => Msf::Sessions::CommandShell
			))
	end

end

end end end end
