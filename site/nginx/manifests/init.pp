class nginx {
package {'nginx':
ensure => present,

#document root /var/www
file {'/var/www':
ensure => directory,
group => root,
owner => root,
mode => '0755',
}


#index.html
file{'/var/www/index.html':
ensure => file,
group => root,
owner => root,
mode => '0664',
source => 'puppet:///modules/nginx/index.html',

#config file nginx.conf
file {'/etc/nginx/nginx.conf':
ensure => file,
group => root,
owner => root,
mode => '0664',
source => 'puppet:///modules/nginx/nginx.conf',
require => Package['nginx'],
subscribe => Service['nginx'],
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
group => root,
owner => root,
mode => '0664',
source => 'puppet:///modules/nginx/default.conf',
require => Package['nginx'],
notify => Service['nginx'],

}
service { 'nginx':
ensure => running,
enable => true,

}
}
