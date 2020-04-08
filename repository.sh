#!/bin/bash  
FILE=./domain/lib/repository/$1Repository.dart
FILE_IMPL=./data/lib/repository/$1RepositoryImpl.dart

if [[ -f $FILE ]] || [[ -f $FILE_IMPL ]]; then
    echo "file alredy exists"
else
    touch $FILE
    printf \
"
import \"dart:developer\" as dev;

abstract class $1Repository {

}
" \
> $FILE

    touch $FILE_IMPL
    printf \
"
import \"dart:developer\" as dev;
import \"package:domain/repository/$1Repository.dart\";

class $1RepositoryImpl extends $1Repository {
    final $1Local local;
    final $1Remote remote;

    $1RepositoryImpl({
        this.local,
        this.remote
    });


}

class $1Local {

}

class $1Remote {

}
" \
> $FILE_IMPL

fi



