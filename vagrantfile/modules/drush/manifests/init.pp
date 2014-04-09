class drush() {
  file {'/usr/share/drush':
    ensure => 'directory',
    owner => 'vagrant',
    group => 'vagrant',
    source => 'puppet:///modules/drush/drush',
    recurse => true,
  }
  -> file {'/bin/drush':
    ensure =>  link,
    target => '/usr/share/drush/drush'
  }
  file {'/usr/share/drush/lib':
    mode =>  664
  }
}
