class ssh {
	file { "/etc/ssh/sshd_config":
	  ensure => file,
	  mode   => 600,
	  source => "/root/examples/sshd_config",
	}

	service { 'sshd':
	  ensure    => running,
	  enable    => true,
	  subscribe => File['/etc/ssh/sshd_config'],
	}

	package { 'openssh-server':
	  ensure => present,
	  before => File['/etc/ssh/sshd_config'],
	}
}

include ssh
if $::uptime_hours < 2 {
  $myuptime = "Uptime is $::uptime_hours\n"
}
elsif $::uptime_hours < 5 {
  $myuptime = "Uptime is $::uptime_hours\n"
}
else{
  $myuptime = "Uptime is $::uptime_hours\n"
}
file { '/root/condition/conditionals.txt':
  ensure  => present,
  content => $myuptime,
}

$hostos = $::osfamily ? {
  'Solaris' => 'Solaris',
  'Redhat'  => 'Redhat',
  'Ubuntu'  => 'Ubuntu',
  'CentOS'  => 'CentOS',
  default   => 'Unknown',
}

notify { "info":
  message => $hostos,
}
