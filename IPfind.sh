#!/bin/bash
alert="\033[1;36m"
success="\033[1;32m"
nocolour="\033[00m"
public=$( curl -s icanhazip.com )
private=$( ip addr show | grep 'inet ' | awk '{print $2}' | grep -v '127.0.0.1' )
echo -e $success Public IP :- $public $nocolour
echo -e $success Private IP  :- $private $nocolour