module git2.refdb;

import git2.common;
import git2.oid;
import git2.refs;
import git2.types;

extern (C):

int git_refdb_new(git_refdb **out_, git_repository *repo);
int git_refdb_open(git_refdb **out_, git_repository *repo);
int git_refdb_compress(git_refdb *refdb);
void git_refdb_free(git_refdb *refdb);
