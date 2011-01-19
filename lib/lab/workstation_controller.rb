module Lab
module Controllers
module WorkstationController

	def workstation_running_list
		vm_list = `vmrun list`.split("\n")
		vm_list.shift

		return vm_list
	end

	def workstation_dir_list(basepath=nil)
		vm_list = Find.find(basepath).select { |f| f =~ /\.vmx$/ }

		return vm_list
	end
end
end
end
