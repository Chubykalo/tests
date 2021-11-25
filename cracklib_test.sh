#!/bin/sh

## every command appends its output to a file, and that output is compared to an ideal result

mkdir cracklib_test && cd $_

## check password strength:

echo "password" | cracklib-check > test_output.txt 
echo "abc123456" | cracklib-check >> test_output.txt
echo 'i1oVe|DiZza' | cracklib-check >> test_output.txt


## make a file with a list of possible passwords, one per line:

cat << EOF >  dictionary_test.txt 
mypassword
123
lalala
We@kpwd1
EOF



## check password strength from a file:

cat dictionary_test.txt | cracklib-check >> test_output.txt



## format words, lowercase, remove control characters, sort list, and create a database in a file format that cracklib utilities can understand:
## (output shows number of read and written words)

cracklib-format dictionary_test.txt | cracklib-packer cracktest_packed >> test_output.txt



## read from the created database:

cracklib-unpacker cracktest_packed >> test_output.txt



## create a perfect output test result to compare:

cat << EOF > ideal_result.txt
password: it is based on a dictionary word
abc123456: it is too simplistic/systematic
i1oVe|DiZza: OK
mypassword: it is based on a dictionary word
123: it is WAY too short
lalala: it does not contain enough DIFFERENT characters
We@kpwd1: OK
4 4
123
lalala
mypassword
wekpwd1
EOF



## compare results to see if test passed

cmp --silent ideal_result.txt test_output.txt && echo '### SUCCESS: Files Are Identical! TEST PASSED ###' || echo '### WARNING: Files Are Different! TEST FAILED ###'


## cleanup (maybe this could be done better somehow???)

cp test_output.txt ../cracklib_test_log && cd ..
rm -r cracklib_test

