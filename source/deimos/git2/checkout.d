module deimos.git2.checkout;

import deimos.git2.common;
import deimos.git2.diff;
import deimos.git2.strarray;
import deimos.git2.types;
import deimos.git2.util;

extern (C):

enum git_checkout_strategy_t {
	GIT_CHECKOUT_NONE = 0,
	GIT_CHECKOUT_SAFE = (1u << 0),
	GIT_CHECKOUT_SAFE_CREATE = (1u << 1),
	GIT_CHECKOUT_FORCE = (1u << 2),
	GIT_CHECKOUT_ALLOW_CONFLICTS = (1u << 4),
	GIT_CHECKOUT_REMOVE_UNTRACKED = (1u << 5),
	GIT_CHECKOUT_REMOVE_IGNORED = (1u << 6),
	GIT_CHECKOUT_UPDATE_ONLY = (1u << 7),
	GIT_CHECKOUT_DONT_UPDATE_INDEX = (1u << 8),
	GIT_CHECKOUT_NO_REFRESH = (1u << 9),
	GIT_CHECKOUT_DISABLE_PATHSPEC_MATCH = (1u << 13),
	GIT_CHECKOUT_SKIP_LOCKED_DIRECTORIES = (1u << 18),
	GIT_CHECKOUT_SKIP_UNMERGED = (1u << 10),
	GIT_CHECKOUT_USE_OURS = (1u << 11),
	GIT_CHECKOUT_USE_THEIRS = (1u << 12),
	GIT_CHECKOUT_UPDATE_SUBMODULES = (1u << 16),
	GIT_CHECKOUT_UPDATE_SUBMODULES_IF_CHANGED = (1u << 17),
}
mixin _ExportEnumMembers!git_checkout_strategy_t;

enum git_checkout_notify_t {
	GIT_CHECKOUT_NOTIFY_NONE      = 0,
	GIT_CHECKOUT_NOTIFY_CONFLICT  = (1u << 0),
	GIT_CHECKOUT_NOTIFY_DIRTY     = (1u << 1),
	GIT_CHECKOUT_NOTIFY_UPDATED   = (1u << 2),
	GIT_CHECKOUT_NOTIFY_UNTRACKED = (1u << 3),
	GIT_CHECKOUT_NOTIFY_IGNORED   = (1u << 4),

	GIT_CHECKOUT_NOTIFY_ALL       = 0x0FFFFu
}
mixin _ExportEnumMembers!git_checkout_notify_t;

alias git_checkout_notify_cb = int function(
	git_checkout_notify_t why,
	const(char)* path,
	const(git_diff_file)* baseline,
	const(git_diff_file)* target,
	const(git_diff_file)* workdir,
	void *payload);

alias git_checkout_progress_cb = void function(
	const(char)* path,
	size_t completed_steps,
	size_t total_steps,
	void *payload);

struct git_checkout_opts {
	uint version_ = GIT_CHECKOUT_OPTS_VERSION;

	uint checkout_strategy;

	int disable_filters;
	uint dir_mode;
	uint file_mode;
	int file_open_flags;
	uint notify_flags;
	git_checkout_notify_cb notify_cb;
	void *notify_payload;
	git_checkout_progress_cb progress_cb;
	void *progress_payload;
	git_strarray paths;
	git_tree *baseline;
	const(char)* target_directory;
}

enum GIT_CHECKOUT_OPTS_VERSION = 1;
enum git_checkout_opts GIT_CHECKOUT_OPTS_INIT = { GIT_CHECKOUT_OPTS_VERSION };

int git_checkout_head(
	git_repository *repo,
	git_checkout_opts *opts);
int git_checkout_index(
	git_repository *repo,
	git_index *index,
	git_checkout_opts *opts);
int git_checkout_tree(
	git_repository *repo,
	const(git_object)* treeish,
	git_checkout_opts *opts);
