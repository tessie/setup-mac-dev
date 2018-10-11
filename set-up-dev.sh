function pretty_print(){
  tput setaf 1; echo $1
}

function setup_brew(){
  if ! command -v brew >/dev/null; then
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

setup_brew
brew update
install_vim
setup_git
pretty_print "Want to configure git y/n?"
read option
if [[ "$option" = "y" ]]; then
  configure_git
fi