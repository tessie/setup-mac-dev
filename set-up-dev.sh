function pretty_print(){
  tput setaf 1; echo $1
}

function is_app_installed(){
  if ls /Applications/ | grep -i $1 > /dev/null; then
    return 0;
  else
    return 1;
  fi
}

function setup_brew(){
  if ! command -v brew > /dev/null; then
    pretty_print "Installing brew"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  else
    pretty_print "Brew is already installed"
  fi
}

function install_vim(){
  if ! command -v vim > /dev/null; then
    pretty_print "Installing vim" 
    brew install vim
  else
    pretty_print "Vim is already installed"
  fi
}

function setup_git(){
  if ! command -v git > /dev/null; then
    pretty_print "Install git"
    brew install git
  else
    pretty_print "git is already installed"
  fi
}

function configure_git(){
  pretty_print "Configuring git"
  pretty_print "Enter Username"
  read user_name
  git config --global user.name $username
  pretty_print "Configure git email"
  read user_email
  git config --global user.email $username
  pretty_print "Configuring vim as editor"
  git config --global core.editor vim
  pretty_print "Push behavior"
  git config --global push.default current
  git config --list
}

function setup_vimrc(){
  git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
  sh ~/.vim_runtime/install_awesome_vimrc.s
}

function install_iterm(){
  echo "Setup Iterm"
  is_app_installed iterm
  if [[ "$?" = 0 ]]; then
    echo "iterm already installed"
  else
    brew cask install iterm2
  fi
}

function setup_zsh(){
  which zsh
  if [[ "$?" = 0 ]]; then
    echo "zsh is already installed"
  else
    brew install zsh
  fi
  brew install zsh-completions
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  sudo chsh -s $(which zsh)
}

function setup_python3(){
  if ! command -v python3 >/dev/null; then
    brew install python3
  else
    pretty_print "Python3 is already installed"
  fi
}

setup_brew
brew update
install_vim
setup_git
pretty_print "Want to configure git y/n?"
read option
if [[ "$option" = "y" ]]; then
  configure_git
fi
install_iterm
setup_zsh
setup_python3
