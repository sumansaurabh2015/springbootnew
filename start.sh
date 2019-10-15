#!/bin/sh
##Managed by Puppet###

FULL_PATH=$(cd $(dirname $0) && pwd -P)

heap_dump_dir="."

if [ ! -d "$heap_dump_dir" ]; then
   echo "WARN  Heap Dump directory $heap_dump_dir doesn't exist. If server crashes with OutOfMemory error, heap dump will not be collected"
fi

JAVA_OPTS="-XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=$heap_dump_dir"

PRG="$0"

while [ -h "$PRG" ]; do
  ls=`ls -ld "$PRG"`
  link=`expr "$ls" : '.*-> \(.*\)$'`
  if expr "$link" : '/.*' > /dev/null; then
    PRG="$link"
  else
    PRG=`dirname "$PRG"`/"$link"
  fi
done

# Get standard environment variables
PRGDIR=`dirname "$PRG"`

source "$PRGDIR"/set_env.sh

/usr/bin/java/bin/java $JAVA_OPTS \
#  -Dspring.boot.admin.notify.mail.to="$NOTIFICATION_EMAIL_TO" \
#  -Dspring.boot.admin.notify.mail.from="$NOTIFICATION_EMAIL_FROM" \
#  -Dlog.file.location="$SPRINGBOOT_ADMIN_LOG_LOCATION" \
/usr/bin/java/bin/java -jar $PRGDIR/target/SpringbootAdmin.jar
