node default {
  class { 'apache':
    mpm_module => 'prefork',
  }
}

class apache {
  package { 'httpd':
    ensure => installed,
  }

  service { 'httpd':
    ensure => running,
    enable => true,
  }

  file { '/var/www/html/index.html':
    ensure  => file,
    content => 'Hello, Puppet!',
  }
}
