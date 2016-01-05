
# installs required dependent packages then
# gets nodejs and npm package from puppet forge
# after nodejs is installed will then install npm modules required for MEAN Stack

group{ "meandev":
	ensure => present,
	gid => 665
}

user{ "meandev":
	ensure => present,
	gid => "meandev",
	groups => ["adm"],
	membership => minimum,
	shell => "/bin/bash",
	require => Group["meandev"]
}

# first create a standard location for deploying our MEAN applications to
file { "/usr/local/src/mean":
	ensure => "directory",
	mode => '0664',
	owner => "meandev",
	group => "meandev",
	require => User["meandev"]
}

#install nodejs and npm
class { 'nodejs':
	version => 'stable'
}


##Install the required node modules using NPM

# install express
package { 'express-generator':
  ensure   => present,
  provider => 'npm',
}

# install jade
package { 'jade':
  ensure   => present,
  provider => 'npm',
}

# install mongoose
package { 'mongoose':
  ensure   => present,
  provider => 'npm',
}

# install gulp
package { 'gulp':
  ensure   => present,
  provider => 'npm',
}

# install bower
package { 'bower':
  ensure   => present,
  provider => 'npm',
}

# install jasmine for testing
package { 'jasmine-node':
  ensure   => present,
  provider => 'npm',
}

# install nodeunit for testing
package { 'nodeunit':
  ensure   => present,
  provider => 'npm',
}



