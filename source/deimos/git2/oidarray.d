module deimos.git2.oidarray;

import deimos.git2.common;
import deimos.git2.oid;


extern(C):

struct git_oidarray {
    git_oid* ids;
    size_t count;
}

void git_oidarray_free(git_oidarray* array);
