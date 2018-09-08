#!/bin/sh

help() {
    cat << EOF

# Usage
./this-script help

# Commands
site_build      - Build site generator
site_generate   - Generate site
site_serve      - Serve site w/ NPM::http-server
ping            - Returns "pong"

EOF
}

site_build() {
    stack build
}

site_generate() {
    stack exec site build
}

serve_site() {
    http-server -p 8082 _site
}

ping() {
    echo ">> Pong"
}

# No argument detection
if [ $# -eq 0 ]
then
    help
    exit 0
fi

# Argument parsing
for var in "$@"
do
    for com in "site_build" "site_generate" "serve_site" "ping"
    do
        # Command parsing
        if [ "$var" = "$com" ]
        then
            export SHORTCUT="$var"
            echo ">> Running command $SHORTCUT"
            eval $SHORTCUT
        fi
    done
done

# Running command
if [ -z "$SHORTCUT" ]
then
    echo ">> Sorrjan, no valid command provided."
    help
    exit 0
fi

