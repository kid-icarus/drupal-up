# Update the list of packages ONCE before installing any packages.
exec { "apt-update":
  command => "/usr/bin/apt-get update"
}
Exec["apt-update"] -> Package <| |>
Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] }

# Apache
class {'apache':
  mpm_module => 'prefork',
}
apache::mod { 'rewrite':  }
apache::mod { 'php5':  }

file {'/var/www/drupal':
  ensure => 'directory',
} ->
apache::vhost {'drupal':
  servername => 'drupal.dev',
  docroot  => '/var/www/drupal',
  override => 'all',
  port          => 80
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
} ->
class {'php':} ->
class {'drush':} ->
exec{'drush dl drupal --drupal-project-rename --destination=/var/www':
  creates => '/var/www/drupal/index.php'
} ->
exec {'drush site-install  --db-url=mysqli://drupal:drupalsql@localhost/drupaldb':
  creates => '/var/www/drupal/index.php'
}
