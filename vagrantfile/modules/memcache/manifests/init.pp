class memcache() {
  package {'php5-memcache':
    ensure   => 'installed',
  } ->
  package {'memcached':
    ensure   => 'installed',
  }
  -> package {'build-essential':
    ensure => 'installed'
  }
  -> exec {'pecl install memcache':
    require => [ Package['php-pear'], Package['build-essential'] ],
    creates => '/usr/lib/php5/20090626/memcache.so'
  }
  -> exec {'echo extension=memcache.so >> /etc/php5/apache2/php.ini':
    unless  => "grep -c 'extension=memcache.so' /etc/php5/apache2/php.ini"
  }
  -> service {'memcached':
    ensure => running
  }
}
