class drush() {
  file {'/usr/share/drush':
    ensure => 'directory',
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
