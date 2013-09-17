#!/bin/bash

KNORG_VERSION=0.0.1
KNIVES=()

for dir in $(ls -A "$HOME/.knives"); do
  [[ -e "$HOME/.knives/$dir/knife.rb" ]] && KNIVES+=("$HOME/.knives/$dir")
done

knorg() {
  case $1 in
    -h|--help)
      echo "usage: knorg [ORG|system]"
      ;;
    -v|--version)
      echo "knorg version $KNORG_VERSION"
      ;;
    "")
      local dir star
      for dir in "${KNIVES[@]}"; do
        star=" "
        dir=${dir%%/}
        [[ $dir == $KNIFE_HOME ]] && star="*"
        echo " $star ${dir##*/}"
      done
      ;;
    system)
      unset KNIFE_HOME
      ;;
    *)
      local dir match

      for dir in "${KNIVES[@]}"; do
        dir=${dir%%/}
        [[ ${dir##*/} == $1 ]] && match=$dir
      done

      if [[ -z $match ]]; then
        echo "knorg: unknown organization \"$1\"" >&2
        return 1
      fi

      if [[ ! -e $match/knife.rb ]]; then
        echo "knorg: invalid organization \"$1\"" >&2
        return 1
      fi

      export KNIFE_HOME=$match
      ;;
  esac
}
