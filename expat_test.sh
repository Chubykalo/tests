#!/bin/sh

mkdir expat_test && cd $_

cat << EOF > example.xml
<?xml version="1.0" encoding="UTF-8"?>
<note>
  <to>Tove</to>
  <from>Jani</from>
  <heading>Reminder</heading>
  <body>Don't forget me this weekend!</body>
</note>
EOF

cat << EOF > example-error.xml
<?xml version="1.0" encoding="UTF-8"?>
<note>
  <to>Tove</to>
  <from>Jani</Ffrom>
  <heading>Reminder</heading>
  <body>Don't forget me this weekend!</body>
</note>
EOF

xmlwf -- example.xml
xmlwf -- example-error.xml

cd ..
rm -r expat_test
