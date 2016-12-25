# Specify new column format to avoid deprecation warning
export PIP_FORMAT=columns

# Configure virtualenvwrapper
export WORKON_HOME=${HOME}/.envs
export PROJECT_HOME=${HOME}/Projects
export VIRTUALENVWRAPPER_SCRIPT=/usr/local/bin/virtualenvwrapper.sh
[[ -f ${VIRTUALENVWRAPPER_SCRIPT} ]] && source ${VIRTUALENVWRAPPER_SCRIPT}

# IPython virtualenv support
alias ipy="python -c 'import IPython; IPython.terminal.ipapp.launch_new_instance()'"
# Allow default python3 installation when not on a virtual environment
alias ipy3="python3 -c 'import IPython; IPython.terminal.ipapp.launch_new_instance()'"
