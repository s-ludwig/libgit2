module deimos.git2.sys.reflog;

import deimos.git2.common;
import deimos.git2.types;
import deimos.git2.oid;

git_reflog_entry* git_reflog_entry__alloc();
void git_reflog_entry__free(git_reflog_entry *entry);
