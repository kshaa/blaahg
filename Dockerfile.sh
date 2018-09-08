#!/bin/bash

help() {
    cat << EOF

# Usage
./this-script help

# Commands
site_generator_build    - (docker build) Generate blaahg-build image (Gets GHC, stack and site dependencies)
site_server_build       - (docker build) Generate image blaahg-run (Installs NPM::http-server)
site_generate           - (docker run) With blaahg-build build site generator and generate site
site_serve              - (docker run) With blaahg-run image run site server
site                    - Run all the commands above in proper sequence
ping                    - Return "pong"

EOF
}

site_generator_build() {
    docker build -f Dockerfile.build -t blaahg-build .
}

site_generate() {
    docker run --mount type=bind,src=$PWD,dst=/usr/src/app blaahg-build site_build
    docker run --mount type=bind,src=$PWD,dst=/usr/src/app blaahg-build site_generate
}

site_server_build() {
    docker build -f Dockerfile.runtime -t blaahg-runtime .
}

site_serve() {
    docker run -p 8082:8082 --mount type=bind,src=$PWD,dst=/usr/src/app blaahg-runtime serve_site
}

site() {
    site_generator_build
    site_generate
    site_server_build
    site_serve
}

ping() {
    echo ">> Pong"
}

# No argument detection
if [[ $# -eq 0 ]]
then
    help
    exit 0
fi

# Argument parsing
for var in "$@"
do
    for com in "site_generator_build" "site_generate" "site_server_build" "site_serve" "site" "ping"
    do
        # Command parsing
        if [[ $var == "$com" ]]
        then
            export SHORTCUT="$var"
            echo ">> Running command $SHORTCUT"
            eval $SHORTCUT
        fi
    done
done

# Running command
if [[ -z "$SHORTCUT" ]]
then
    echo ">> Sorrjan, no valid command provided."
    help
    exit 0
fi
