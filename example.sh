#!/usr/bin/env sh

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'
BOLD='\033[1m'

bold() {
    echo "${BOLD}$1${NC}"
}

check() {
    bold "| $1: \c"
    if [ "$2" = "$3" ]; then
        echo "${GREEN}OK${NC}"
    else
        echo "${RED}NOK${NC}: expected ${3}, got ${2}"
        dfx -q stop > /dev/null 2>&1
        exit 1
    fi
}

bold "| Starting replica."
dfx start --background --clean > /dev/null 2>&1
dfx deploy index

bold "| Creating new canister through Motoko."
canister=$(dfx canister call index createCanister | cut -d \" -f2)

check "Checking new canister balance" "$(dfx canister call $canister getCycleBalance)" "(1_000_000_000_000 : nat)"

dfx -q stop > /dev/null 2>&1
