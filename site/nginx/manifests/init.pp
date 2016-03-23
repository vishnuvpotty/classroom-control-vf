class nginx {

case$::osfamily {
'redhat','debian' : {

$package = 'nginx'
$fileowner= 'root'
$group= 'root'
$docroot='/var/www'
$configdir = '/etc/nginx'
$serverlogs ='/var/logs/nginx'
}

'windows' : {
$package = 'nginx-service'
$fileowner = 'Administrator'
$group = 'Administrators'
$docroot = 'C:/ProgramData/nginx/html'
$configdir = 'C:/ProgramData/nginx'
$serverlogs ='C:/ProgramData/nginx/logs'
}
'default' : {
fail("Module is not supported on ${::osfamily}")
}
}

$user= $::osfamily? {
'redhat' =>'nginx',
'debian' => 'www-data',
'windows' =>'nobody',
}



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
file {"${configdir}/nginx.conf':
ensure => file,
content => template('nginx/nginx.conf.erb'),
# source => 'puppet:///modules/nginx/nginx.conf',
# require => Package['nginx'],
notify => Service['nginx'],
}

# file { '/etc/nginx/conf.d':
# ensure => directory,
# owner => 'root',
# group => 'root',
# mode => '0775',
# }

#config default.conf
file {"${configdir}/conf.d/default.conf":
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
