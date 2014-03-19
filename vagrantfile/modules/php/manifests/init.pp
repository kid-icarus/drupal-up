class php () {
  $packages = ['libapache2-mod-php5', 'php5-common', 'php5-cli', 'php5-curl', 'php5-mysql', 'php5-gd', 'php-pear']
  package { $packages : ensure => 'installed'}
}
