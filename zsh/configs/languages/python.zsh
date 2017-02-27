# Specify new column format to avoid deprecation warning
export PIP_FORMAT=columns

# Configure virtualenvs
export WORKON_HOME=${HOME}/.envs
export PROJECT_HOME=${HOME}/Projects
export VIRTUALENVWRAPPER_SCRIPT=/usr/local/bin/virtualenvwrapper.sh

# Configure pew
if command -v pew &> /dev/null; then
  source $(pew shell_config)
fi

# Configure virtualenvwrapper
if [[ -f ${VIRTUALENVWRAPPER_SCRIPT} ]]; then
  source ${VIRTUALENVWRAPPER_SCRIPT}
  alias mkvirtualenv2="mkvirtualenv -p $(which python2)"
  alias mkvirtualenv3="mkvirtualenv -p $(which python3)"
fi

# IPython virtualenv support
alias ipy="python -c 'import IPython; IPython.terminal.ipapp.launch_new_instance()'"
# Allow default python3 installation when not on a virtual environment
alias ipy3="python3 -c 'import IPython; IPython.terminal.ipapp.launch_new_instance()'"
