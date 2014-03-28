class php () {
  $packages = ['libapache2-mod-php5', 'php5-common', 'php5-cli', 'php5-curl', 'php5-mysql', 'php5-gd', 'php-pear', 'build-essential']
  package { $packages :
    ensure => 'installed'
  }
  -> exec {'pecl install uploadprogress':
    creates => '/usr/lib/php5/20090626/uploadprogress.so'
  }
  -> exec {'echo extension=uploadprogress.so >> /etc/php5/apache2/php.ini':
    unless  => "grep -c 'extension=uploadprogress.so' /etc/php5/apache2/php.ini",
    notify => Service['apache2']
  }
}
