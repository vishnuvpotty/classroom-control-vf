class nginx (
$package = $nginx::params::package,
$fileowner = $nginx::params::fileowner,
$group = $nginx::params::group,
$docroot =$nginx::params::docroot,
$configdir = $nginx::params::configdir,
$serverlogs = $nginx::params::serverlogs,
# $root = undef
) inherits nginx::params {

# $docroot = $root ? {
# undef => $default_docroot,
# default => $root,
# }

File{
group => $group,
owner => $fileowner,
mode => '0664',
}

package {$package:
ensure => present,
}

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
file {"${configdir}/nginx.conf":
ensure => file,
content => template('nginx/nginx.conf.erb'),
# source => 'puppet:///modules/nginx/nginx.conf',
# require => Package['nginx'],
notify => Service['nginx'],
}

 file { "${configdir}/conf.d":
 ensure => directory,
 }

#config default.conf
file { "${configdir}/conf.d/default.conf":
ensure => file,
content => template('nginx/default.conf.erb'),
# source => 'puppet:///modules/nginx/default.conf',
# require => Package['nginx'],
notify => Service['nginx'],
}

service { 'nginx':
ensure => running,
enable => true,
}
}
