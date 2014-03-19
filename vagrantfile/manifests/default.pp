# Update the list of packages ONCE before installing any packages.
exec { "apt-update":
  command => "/usr/bin/apt-get update"
}
Exec["apt-update"] -> Package <| |>

# Global path for any execs we wanna run.
Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] }

# Apache
class {'apache':
  mpm_module => 'prefork',
}
apache::mod { 'rewrite':  }
apache::mod { 'php5':  }

apache::vhost {'your-project':
  # MODIFY FOR YOUR PROJECT!
  servername => 'your.project.com',
  docroot  => '/var/www/your.project.com',
  override => 'all',
  docroot_owner => 'vagrant',
  docroot_group => 'vagrant',
  port          => 80
}

# Change apache user
exec { "ApacheUserChange" :
    command => "sed -i 's/APACHE_RUN_USER=www-data/APACHE_RUN_USER=vagrant/' /etc/apache2/envvars",
    onlyif  => "grep -c 'APACHE_RUN_USER=www-data' /etc/apache2/envvars",
    require => Package["apache2"],
    notify  => Service["apache2"],
}
exec { "ApacheGroupChange" :
    command => "sed -i 's/APACHE_RUN_GROUP=www-data/APACHE_RUN_GROUP=vagrant/' /etc/apache2/envvars",
    onlyif  => "grep -c 'APACHE_RUN_GROUP=www-data' /etc/apache2/envvars",
    require => Package["apache2"],
    notify  => Service["apache2"],
}
exec { "apache_lockfile_permissions" :
    command => "chown -R vagrant:www-data /var/lock/apache2",
    require => Package["apache2"],
    notify  => Service["apache2"],
}

# MySQL
class { 'mysql::client': }
class { 'mysql::bindings': }
class { 'mysql::server':
  root_password => 'drupalsql',
}

mysql::db { 'drupaldb':
  user => 'drupal',
  password => 'drupalsql',
  # If you want to import a db, comment out the following:
  # sql => '/sql/example.sql'
}

# PHP
class {'php':}
# If you need memcache, comment out the following line:
# ->  class {'memcache':}

# Drush
class {'drush':}
