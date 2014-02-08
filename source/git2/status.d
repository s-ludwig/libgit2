module git2.status;

import git2.common;
import git2.diff;
import git2.strarray;
import git2.util;
import git2.types;

extern (C):

enum git_status_t {
	GIT_STATUS_CURRENT = 0,

	GIT_STATUS_INDEX_NEW        = (1u << 0),
	GIT_STATUS_INDEX_MODIFIED   = (1u << 1),
	GIT_STATUS_INDEX_DELETED    = (1u << 2),
	GIT_STATUS_INDEX_RENAMED    = (1u << 3),
	GIT_STATUS_INDEX_TYPECHANGE = (1u << 4),

	GIT_STATUS_WT_NEW           = (1u << 7),
	GIT_STATUS_WT_MODIFIED      = (1u << 8),
	GIT_STATUS_WT_DELETED       = (1u << 9),
	GIT_STATUS_WT_TYPECHANGE    = (1u << 10),
	GIT_STATUS_WT_RENAMED       = (1u << 11),

	GIT_STATUS_IGNORED          = (1u << 14),
}
mixin _ExportEnumMembers!git_status_t;

alias git_status_cb = int function(
	const(char)* path, uint status_flags, void *payload);

enum git_status_show_t {
	GIT_STATUS_SHOW_INDEX_AND_WORKDIR = 0,
	GIT_STATUS_SHOW_INDEX_ONLY = 1,
	GIT_STATUS_SHOW_WORKDIR_ONLY = 2,
	GIT_STATUS_SHOW_INDEX_THEN_WORKDIR = 3,
}
mixin _ExportEnumMembers!git_status_show_t;

enum git_status_opt_t {
	GIT_STATUS_OPT_INCLUDE_UNTRACKED        = (1u << 0),
	GIT_STATUS_OPT_INCLUDE_IGNORED          = (1u << 1),
	GIT_STATUS_OPT_INCLUDE_UNMODIFIED       = (1u << 2),
	GIT_STATUS_OPT_EXCLUDE_SUBMODULES       = (1u << 3),
	GIT_STATUS_OPT_RECURSE_UNTRACKED_DIRS   = (1u << 4),
	GIT_STATUS_OPT_DISABLE_PATHSPEC_MATCH   = (1u << 5),
	GIT_STATUS_OPT_RECURSE_IGNORED_DIRS     = (1u << 6),
	GIT_STATUS_OPT_RENAMES_HEAD_TO_INDEX    = (1u << 7),
	GIT_STATUS_OPT_RENAMES_INDEX_TO_WORKDIR = (1u << 8),
	GIT_STATUS_OPT_SORT_CASE_SENSITIVELY    = (1u << 9),
	GIT_STATUS_OPT_SORT_CASE_INSENSITIVELY  = (1u << 10),
}
mixin _ExportEnumMembers!git_status_opt_t;

enum GIT_STATUS_OPT_DEFAULTS =
	(git_status_opt_t.GIT_STATUS_OPT_INCLUDE_IGNORED |
	git_status_opt_t.GIT_STATUS_OPT_INCLUDE_UNTRACKED |
	git_status_opt_t.GIT_STATUS_OPT_RECURSE_UNTRACKED_DIRS);

struct git_status_options {
	uint      version_;
	git_status_show_t show;
	uint      flags;
	git_strarray      pathspec;
}

enum GIT_STATUS_OPTIONS_VERSION = 1;
enum git_status_options GIT_STATUS_OPTIONS_INIT = { GIT_STATUS_OPTIONS_VERSION };

struct git_status_entry {
	git_status_t status;
	git_diff_delta *head_to_index;
	git_diff_delta *index_to_workdir;
}

int git_status_foreach(
	git_repository *repo,
	git_status_cb callback,
	void *payload);
int git_status_foreach_ext(
	git_repository *repo,
	const(git_status_options)* opts,
	git_status_cb callback,
	void *payload);
int git_status_file(
	uint *status_flags,
	git_repository *repo,
	const(char)* path);
int git_status_list_new(
	git_status_list **out_,
	git_repository *repo,
	const(git_status_options)* opts);
size_t git_status_list_entrycount(
	git_status_list *statuslist);
const(git_status_entry)*  git_status_byindex(
	git_status_list *statuslist,
	size_t idx);
void git_status_list_free(
	git_status_list *statuslist);
int git_status_should_ignore(
	int *ignored,
	git_repository *repo,
	const(char)* path);
