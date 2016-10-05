#!/bin/bash

set -e

BOLD="\033[1m";          DIM="\033[2m";                  UNDERLINE="\033[4m";        BLINK="\033[5m";
INVERTED="\033[7m";      HIDDEN="\033[8m";
RESET_COLOR="\033[0m";   RESET_BOLD="\033[21m";          RESET_DIM="\033[22m";       RESET_UNDERLINE="\033[24m";
RESET_BLINK="\033[25m";  RESET_INVERTED="\033[27m";      RESET_HIDDEN="\033[28m";
BLACK="\033[30m";        BRIGHT_BLACK="\033[90m";        BG_BLACK="\033[40m";        BG_BRIGHT_BLACK="\033[100m";
RED="\033[31m";          BRIGHT_RED="\033[91m";          BG_RED="\033[41m";          BG_BRIGHT_RED="\033[101m";
GREEN="\033[32m";        BRIGHT_GREEN="\033[92m";        BG_GREEN="\033[42m";        BG_BRIGHT_GREEN="\033[102m";
YELLOW="\033[33m";       BRIGHT_YELLOW="\033[93m";       BG_YELLOW="\033[43m";       BG_BRIGHT_YELLOW="\033[103m";
BLUE="\033[34m";         BRIGHT_BLUE="\033[94m";         BG_BLUE="\033[44m";         BG_BRIGHT_BLUE="\033[104m";
PURPLE="\033[35m";       BRIGHT_PURPLE="\033[95m";       BG_PURPLE="\033[45m";       BG_BRIGHT_PURPLE="\033[105m";
CYAN="\033[36m";         BRIGHT_CYAN="\033[96m";         BG_CYAN="\033[46m";         BG_BRIGHT_CYAN="\033[106m";
WHITE="\033[37m";        BRIGHT_WHITE="\033[97m";        BG_WHITE="\033[47m";        BG_BRIGHT_WHITE="\033[107m";
ORANGE="\033[38;5;208m"; BRIGHT_ORANGE="\033[38;5;216m"; BG_ORANGE="\033[48;5;208m"; BG_BRIGHT_ORANGE="\033[48;5;216m";

HEADING="${BG_BRIGHT_BLACK}${BRIGHT_WHITE}"

fail() { echo -e "${RED}==> ${1:-Something did not go well} ${exit_code}"; }
log() { echo -e "${BLUE}==> ${RESET_COLOR}$1"; }
verbose() {
  if [ "${verbose}" == "true" ]; then
    echo -e "${BRIGHT_BLACK}==> ${RESET_COLOR}$1"
  fi
}

usage() {
  echo -e "
${HEADING}                     Doing the awesome thing                             ${RESET_COLOR}

This program does awesome things that you will want to change.

${BRIGHT_CYAN}┃  $0 ${CYAN}command ${PURPLE}[options]${RESET_COLOR}

${YELLOW}Commands:${RESET_COLOR}
  • ${CYAN}help${RESET_COLOR} - Show this help
  • ${CYAN}be_awesome${RESET_COLOR} - Do something awesome

${YELLOW}Options:${RESET_COLOR}
  • ${PURPLE}-h, --help${RESET_COLOR}            - Show help about a command
  • ${PURPLE}-V, --verbose${RESET_COLOR}         - Show verbose logging

"
}

be_awesome_help() {
  echo -e "
${HEADING}                                   Be Awesome                                         ${RESET_COLOR}

This is the command you run to be awesome

${BRIGHT_CYAN}┃  $0 ${CYAN}be_awesome ${PURPLE}[options]${RESET_COLOR}

${YELLOW}Options:${RESET_COLOR}
  • ${PURPLE}-h, --help${RESET_COLOR}    - Show help about a command
  • ${PURPLE}-V, --verbose${RESET_COLOR} - Show verbose logging
  • ${PURPLE}-f, --first${RESET_COLOR}   - Pass the first parameter
"
}

be_awesome() {
  first=${first:-"false"}
  verbose "Debugging something"
  log "First=${first}"
}

command="$1"
if [ -z "$command" ]; then
  fail 'No command given'
  usage
  exit 1
fi

case "$command" in
  help)          usage
                 exit 0
                 ;;
  be_awesome| \
  other_command) command="$1"; shift;;
  *)             fail "Unknown command '$command' ";
                 usage
                 exit 1
                 ;;
esac

while [ -n "$1" ]; do
  case "$1" in
    -V|--verbose)    shift; verbose="true";;
    -h|--help)       shift; ${command}_help; exit 0;;
    *) case "$command" in
         be_awesome) case "$1" in
                       -f|-first) first="true";shift;;
                       *)         fail "Unknown parameter ${1}" && usage && exit 1;;
                     esac;;
       esac;;
  esac
done

verbose=${verbose:-false}

${command}
