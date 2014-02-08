module git2.sys.reflog;

import git2.common;
import git2.types;
import git2.oid;

git_reflog_entry* git_reflog_entry__alloc();
void git_reflog_entry__free(git_reflog_entry *entry);
