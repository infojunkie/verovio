#!/usr/bin/env bash
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

for b in *.blessed.mid; do
  m="${b%.blessed.mid}.musicxml"
  echo "$m"
  a="${b%.blessed.mid}.ascl"
  if [ -f "$a" ]; then
    ../build/verovio --tuning-file "$a" -r ../data -t midi "$m" > /dev/null
  else
    ../build/verovio -r ../data -t midi "$m" > /dev/null
  fi
  o="${b%.blessed.mid}.mid"
  diff "$b" "$o"
  ret=$?
  if [[ $ret -eq 0 ]]; then
    printf "${GREEN}passed.${NC}\n"
  else
    printf "${RED}failed.${NC}\n"
  fi
done

