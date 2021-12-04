class base {

	file {"/etc/puppetlabs/puppet/puppet.conf":
		source => "puppet:///modules/base/puppet.conf",
		ensure => present,
	}
	
	service {'puppet':
		ensure => running,
		enable => true,
		subscribe => File['/etc/puppetlabs/puppet/puppet.conf']
	}
}
