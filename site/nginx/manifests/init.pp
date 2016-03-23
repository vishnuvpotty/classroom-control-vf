class nginx {

File{
group => root,
owner => root,
mode => '0755',
}

package {'nginx':
ensure => present,
}

$docroot='/var/www';

#document root /var/www
file {$docroot:
ensure => directory,
}


#index.html
file{"${docroot}/index.html":
ensure => file,
source => 'puppet:///modules/nginx/index.html',
}

#config file nginx.conf
file {'/etc/nginx/nginx.conf':
ensure => file,

source => 'puppet:///modules/nginx/nginx.conf',
require => Package['nginx'],
notify => Service['nginx'],
}

file { '/etc/nginx/conf.d':
ensure => directory,
owner => 'root',
group => 'root',
mode => '0775',
}

#config default.conf
file {'/etc/nginx/conf.d/default.conf':
ensure => file,
source => 'puppet:///modules/nginx/default.conf',
require => Package['nginx'],
notify => Service['nginx'],
}

service { 'nginx':
ensure => running,
enable => true,
}
}
