class mera {
	case $::osfamily{
		"redhat": {
$pacotes = ["epel-release","git","vim","sysstat","htop","fortune-mod","figlet","fish"]
		}
		"debian": {
			exec{"Atualizar_Repositorio": 
				command => "/usr/bin/apt update"
			}
$pacotes = ["git","vim","sysstat","htop","fortunes-br","figlet","fish"]
		}
	}

	package{$pacotes:
		ensure => present,
	}

	file{'/root/.bashrc':
		source => "puppet:///modules/mera/bashrc_mera",
		ensure => present,
	}

	file{'/root/.bash_logout':
		source => "puppet:///modules/mera/bash_logout",
		ensure => present,
	}

	user{"aqualad":
		ensure => present,
		managehome => true,
		shell => "/usr/bin/fish",
	}
}
