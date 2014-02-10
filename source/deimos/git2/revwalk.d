module deimos.git2.revwalk;

import deimos.git2.common;
import deimos.git2.oid;
import deimos.git2.types;

extern (C):

enum GIT_SORT_NONE = (0);
enum GIT_SORT_TOPOLOGICAL = (1 << 0);
enum GIT_SORT_TIME	= (1 << 1);
enum GIT_SORT_REVERSE = (1 << 2);

int git_revwalk_new(git_revwalk **out_, git_repository *repo);
void git_revwalk_reset(git_revwalk *walker);
int git_revwalk_push(git_revwalk *walk, const(git_oid)* id);
int git_revwalk_push_glob(git_revwalk *walk, const(char)* glob);
int git_revwalk_push_head(git_revwalk *walk);
int git_revwalk_hide(git_revwalk *walk, const(git_oid)* commit_id);
int git_revwalk_hide_glob(git_revwalk *walk, const(char)* glob);
int git_revwalk_hide_head(git_revwalk *walk);
int git_revwalk_push_ref(git_revwalk *walk, const(char)* refname);
int git_revwalk_hide_ref(git_revwalk *walk, const(char)* refname);
int git_revwalk_next(git_oid *out_, git_revwalk *walk);
void git_revwalk_sorting(git_revwalk *walk, uint sort_mode);
int git_revwalk_push_range(git_revwalk *walk, const(char)* range);
void git_revwalk_simplify_first_parent(git_revwalk *walk);
void git_revwalk_free(git_revwalk *walk);
git_repository * git_revwalk_repository(git_revwalk *walk);
