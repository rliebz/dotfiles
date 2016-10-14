# TODO: Can use just $(yarn global bin) for any version after 0.15.1
command -v yarn &> /dev/null && { export PATH="$PATH:$(yarn global bin | grep -o '/.*')" }
