
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
import \"package:data/db/Config.dart\";
import 'package:infrastructure/flutter/di/Injection.dart';

class $1Repository {

    final $1Local _local = inject();
    final $1Remote _remote = inject();

}

class $1Local {
    $1Dao _dao = Config.daoProvider();

}

class $1Remote {

}
" \
> $FILE

fi
