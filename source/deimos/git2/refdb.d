module deimos.git2.refdb;

import deimos.git2.common;
import deimos.git2.oid;
import deimos.git2.refs;
import deimos.git2.types;

extern (C):

int git_refdb_new(git_refdb **out_, git_repository *repo);
int git_refdb_open(git_refdb **out_, git_repository *repo);
int git_refdb_compress(git_refdb *refdb);
void git_refdb_free(git_refdb *refdb);
