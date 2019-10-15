#!/bin/sh
FULL_PATH=$(cd $(dirname $0) && pwd -P)

#heap_dump_dir="/opt/yesmail/heapdumps/$HOSTNAME/"
heap_dump_dir="."

if [ ! -d "$heap_dump_dir" ]; then
   echo "WARN  Heap Dump directory $heap_dump_dir doesn't exist. If server crashes with OutOfMemory error, heap dump will not be collected"
fi

JAVA_OPTS="-XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=$heap_dump_dir"

PRG="$0"
PRGDIR=`dirname "$PRG"`

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
#PRGDIR=`dirname "$PRG"`

#source "$PRGDIR"/set_env.sh

java $JAVA_OPTS \
#  -Dspring.boot.admin.notify.mail.to="$NOTIFICATION_EMAIL_TO" \
#  -Dspring.boot.admin.notify.mail.from="$NOTIFICATION_EMAIL_FROM" \
#  -Dlog.file.location="$SPRINGBOOT_ADMIN_LOG_LOCATION" \
#  -Dlogging.config="$PRGDIR"/conf/logback-spring.xml \
  $JAVA_REMOTE_DEBUG_ARGS -jar $PRGDIR/target/SpringbootAdmin.jar