#!/bin/bash

cat $1 |
{
  sed -r "s/(.*)=(.*)/\1/g" > /tmp/variables-names;
  sed -r "s/(.*)=(.*)/echo $\1/g" > /tmp/variables;
  /tmp/variables | bash > /tmp/values;
}

i=1;
for var in `cat /tmp/variables-names`;
do
    sed -i -r "s/@$var@/`head -$i /tmp/values | tail -1`/g" $2;
    i=$(($i+1));
done
cat /tmp/sample-text.txt;
