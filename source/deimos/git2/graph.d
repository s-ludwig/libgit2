module deimos.git2.graph;

import deimos.git2.common;
import deimos.git2.oid;
import deimos.git2.types;

extern (C):

int git_graph_ahead_behind(size_t *ahead, size_t *behind, git_repository *repo, const(git_oid)* local, const(git_oid)* upstream);
