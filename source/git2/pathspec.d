module git2.pathspec;

import git2.common;
import git2.types;
import git2.strarray;
import git2.diff;

struct git_pathspec {
	@disable this();
	@disable this(this);
}

struct git_pathspec_match_list {
	@disable this();
	@disable this(this);
}

enum git_pathspec_flag_t {
	GIT_PATHSPEC_DEFAULT        = 0,
	GIT_PATHSPEC_IGNORE_CASE    = (1u << 0),
	GIT_PATHSPEC_USE_CASE       = (1u << 1),
	GIT_PATHSPEC_NO_GLOB        = (1u << 2),
	GIT_PATHSPEC_NO_MATCH_ERROR = (1u << 3),
	GIT_PATHSPEC_FIND_FAILURES  = (1u << 4),
	GIT_PATHSPEC_FAILURES_ONLY  = (1u << 5),
}

int git_pathspec_new(
	git_pathspec **out_, const(git_strarray)* pathspec);
void git_pathspec_free(git_pathspec *ps);
int git_pathspec_matches_path(
	const(git_pathspec)* ps, uint32_t flags, const(char)* path);
int git_pathspec_match_workdir(
	git_pathspec_match_list **out_,
	git_repository *repo,
	uint32_t flags,
	git_pathspec *ps);
int git_pathspec_match_index(
	git_pathspec_match_list **out_,
	git_index *index,
	uint32_t flags,
	git_pathspec *ps);
int git_pathspec_match_tree(
	git_pathspec_match_list **out_,
	git_tree *tree,
	uint32_t flags,
	git_pathspec *ps);
int git_pathspec_match_diff(
	git_pathspec_match_list **out_,
	git_diff *diff,
	uint32_t flags,
	git_pathspec *ps);
void git_pathspec_match_list_free(git_pathspec_match_list *m);
size_t git_pathspec_match_list_entrycount(
	const(git_pathspec_match_list)* m);
const(char)* git_pathspec_match_list_entry(
	const(git_pathspec_match_list)* m, size_t pos);
const(git_diff_delta)* git_pathspec_match_list_diff_entry(
	const(git_pathspec_match_list)* m, size_t pos);
size_t git_pathspec_match_list_failed_entrycount(
	const(git_pathspec_match_list)* m);
const(char)* git_pathspec_match_list_failed_entry(
	const(git_pathspec_match_list)* m, size_t pos);
