 #!/bin/sh
source /scripts/conf_set.sh
find $ARQUIVOS -type f -mtime +$DAYS_KEEP -delete
find $ARQUIVOS -type d -empty -delete