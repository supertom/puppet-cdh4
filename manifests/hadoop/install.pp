# This file contains classes to install
# CDH4 Hadoop packages.


class cdh4::hadoop::install::client {
	# install hadoop-client, all nodes should have this.
	package { "hadoop-client": ensure => installed }
}

class cdh4::hadoop::install::namenode {
	# install namenode daemon package
	package { "hadoop-hdfs-namenode": ensure => installed }
}

class cdh4::hadoop::install::secondarynamenode {
	# install secondarynamenode daemon package
	package { "hadoop-hdfs-secondarynamenode": ensure => installed }
}

class cdh4::hadoop::install::datanode {
	# install datanode daemon package
	package { "hadoop-hdfs-datanode": ensure => installed }
}

class cdh4::hadoop::install::journalnode {
	# install journalnode package (for namenode high availability)
	package { "hadoop-hdfs-journalnode ": ensure => installed }
}



#
# YARN specific packages
#

class cdh4::hadoop::install::resourcemanager {
	# ResourceManager is on the NameNode
	require cdh4::hadoop::install::namenode

	# install resourcemanager daemon package
	# (Analagous to JobTracker)
	package { "hadoop-yarn-resourcemanager": ensure => installed }
}


class cdh4::hadoop::install::nodemanager {
	# nodemanagers are also datanodes
	require cdh4::hadoop::install::datanode

	# install nodemanager and mapreduce (YARN) daemon package
	# (Analagous to TaskTracker)
	package { ["hadoop-yarn-nodemanager", "hadoop-mapreduce"]: ensure => installed }
}

class cdh4::hadoop::install::historyserver {
	# install historyserver daemon package
	package { "hadoop-mapreduce-historyserver": ensure => installed }
}

class cdh4::hadoop::install::proxyserver {
	# install proxyserver daemon package
	package { "hadoop-yarn-proxyserver": ensure => installed }
}


# Class: cdh4::hadoop::install::jobtracker
class cdh4::hadoop::install::jobtracker {

 	# install jobtracker daemon package
 	package { "hadoop-0.20-mapreduce-jobtracker": ensure => installed }
}

# Class: cdh4::hadoop::install::tasktracker
class cdh4::hadoop::install::tasktracker {

 	# install tasktracker daemon package
 	package { "hadoop-0.20-mapreduce-tasktracker": ensure => installed }

}

# Class: cdh4::hadoop::install::jobtrackerha
class cdh4::hadoop::install::jobtrackerha {

 	# install jobtracker HA daemon package
 	package { "hadoop-0.20-mapreduce-jobtrackerha": ensure => installed }
	# can't install this if normal jobtracker is installed already
	if (defined(Package['hadoop-0.20-mapreduce-jobtracker'])) {
 	   fail("Cannot install Jobtracker HA with standard jobtracker")
	}
}