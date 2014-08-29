class elemoine::package {
  File {
    owner => "${::user}",
    group => "${::user}",
  }
  package {'acpitool':
    ensure => present,
  }
  package {'suckless-tools':
    ensure => present,
  }
  package {'vim-gtk':
    ensure => present,
  }
  package {'xchat-gnome':
    ensure => present,
  }
  package {'gnome-control-center':
    ensure => present,
  }
  package {'gksu':
    ensure => present,
  }
  package {'wordnet-gui':
    ensure => present,
  }
  file {'vimrc':
    ensure => link,
    path   => "${::homedir}/.vimrc",
    target => "${::cwd}/.vimrc",
  }
  file {'vim':
    ensure => link,
    path   => "${::homedir}/.vim",
    target => "${::cwd}/.vim",
  }
}

include ::elemoine::package
