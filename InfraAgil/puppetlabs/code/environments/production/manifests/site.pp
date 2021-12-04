node "default" {

	include base

}

node /(devops|automation).salas4linux.com.br/ {

	include mera

}


node docker.salas4linux.com.br {

	include arraia_negra
	include docker
}
