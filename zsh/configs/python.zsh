# Configure virtualenvwrapper
export WORKON_HOME=${HOME}/.envs
export PROJECT_HOME=${HOME}/Projects
wrapper_script=/usr/local/bin/virtualenvwrapper.sh
[[ -f ${wrapper_script} ]] && source ${wrapper_script}
unset wrapper_script
