# Fixes Nginx so it can handle many concurrent requests (raises the open file limit)
exec { 'fix--for-nginx':
  command => 'sed -i "s/ULIMIT=\"-n 15\"/ULIMIT=\"-n 4096\"/" /etc/default/nginx',
  path    => '/usr/local/bin/:/bin/',
}

# Restart Nginx so the new limit is applied
exec { 'nginx-restart':
  command => '/etc/init.d/nginx restart',
  path    => '/usr/local/bin/:/bin/:/usr/sbin/:/sbin/',
  require => Exec['fix--for-nginx'],
}
