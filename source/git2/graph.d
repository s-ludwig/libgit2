module git2.graph;

import git2.common;
import git2.oid;
import git2.types;

extern (C):

int git_graph_ahead_behind(size_t *ahead, size_t *behind, git_repository *repo, const(git_oid)* local, const(git_oid)* upstream);
