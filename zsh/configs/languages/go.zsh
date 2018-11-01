# Explicitly set GOPATH
export GOPATH=${HOME}/Projects/go

# Allow `go install` outside of GOPATH
export GOBIN=${GOPATH}/bin

# Add GOBIN to end of path
export PATH=${PATH}:${GOBIN}
