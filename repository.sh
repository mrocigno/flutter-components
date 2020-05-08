
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
class $1Repository {
    final $1Local local;
    final $1Remote remote;
    $1Repository({
        this.local,
        this.remote
    });
}
class $1Local {
    $1Dao dao = Config.daoProvider();
}
class $1Remote {
}
" \
> $FILE

fi
