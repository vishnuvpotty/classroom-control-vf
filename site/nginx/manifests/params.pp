class nginx::params { 

case $::osfamily {
'redhat','debian' : {

$package = 'nginx'
$fileowner = 'root'
$group = 'root'
$docroot = '/var/www'
$configdir = '/etc/nginx'
$serverlogs ='/var/log/nginx'

}

'windows' : {
$package = 'nginx-service'
$fileowner = 'Administrator'
$group = 'Administrators'
$docroot = 'C:/ProgramData/nginx/html'
$configdir = 'C:/ProgramData/nginx'
$serverlogs = 'C:/ProgramData/nginx/logs'
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

}
