
#!/bin/bash
FILE=./data/lib/repository/$1Repository.dart

if [[ -f $FILE ]]; then
    echo "file alredy exists"
else
    touch $FILE
    printf \
"
import \"dart:developer\" as dev;
import \"package:data/dao/$1Dao.dart\";
import \"package:data/local/db/Config.dart\";
import 'package:infrastructure/flutter/di/Injection.dart';

class $1Repository {
  _Local _local = _Local();
  _Remote _remote = _Remote();

}

class _Local {
  $1Dao _dao = Config.daoProvider();

}

class _Remote {

}
" \
> $FILE

fi
