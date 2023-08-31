#!/bin/bash

# Echo usage.
function usage() {
	echo """noobpg - gnupg wrapper
  -d      Decrypt text. Will ask for input.
  -p      Print public key.
  """
}

# Ask for gpg message as an input.
# Save message in file, decrypt and shred file.
function decrypt() {
	echo "Provide message to decrypt with your key. Ctrl + D to submit."
	gpg_msg=$(cat)
	echo "$gpg_msg" >>.temp.txt
	gpg -d .temp.txt
	echo ""
	shred .temp.txt
}

# Print public key.
function print_public() {
	gpg --armor --export
}

# Print help if no arguments provided.
[ $# -eq 0 ] && usage

# Options.
while getopts "dp" opt; do
	case $opt in
	d)
		decrypt
		;;

	p)
		print_public
		;;

	*)
		usage
		;;
	esac
done
