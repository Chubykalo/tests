#!/bin/sh

## Display the package version number

keyctl --version

## list available capabilities 

keyctl supports

## show process keyrings

keyctl show

##keyctl request <type> <desc> [<dest_keyring>]
##keyctl request2 <type> <desc> <info> [<dest_keyring>]
##keyctl prequest2 <type> <desc> [<dest_keyring>]
##
##These three commands request the lookup of a key of the given type and description. The process's keyrings will be searched, and if a match is found the matching key's ID will be printed to stdout; and if a destination keyring is given, the key will be added to that keyring also.
##
##If there is no key, the first command will simply return the error ENOKEY and fail. The second and third commands will create a partial key with the type and description, and call out to /sbin/request-key with that key and the extra information supplied. This will then attempt to instantiate the key in some manner, such that a valid key is obtained.
##
##The third command is like the second, except that the callout information is read from stdin rather than being passed on the command line.
##
##If a valid key is obtained, the ID will be printed and the key attached as if the original search had succeeded.
##
##If there wasn't a valid key obtained, a temporary negative key will be attached to the destination keyring if given and the error "Requested key not available" will be given.
###

keyctl request2 user debug:hello wibble
echo -n wibble | keyctl prequest2 user debug:hello
keyctl request user debug:hello

## create a keyring

keyctl newring squelch @us

## list a keyring

keyctl list @us

## describe a key

keyctl describe @us


