class profile::wordpress {

 # mysql
 
 class { '::mysql::server':
root_password => 'test123',
}

 class { 'apache':
 }
 
  class { 'wordpress':
 }

}
