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
	GIT_CHECKOUT_FORCE = (1u << 1),
	GIT_CHECKOUT_RECREATE_MISSING = (1u << 2),
	GIT_CHECKOUT_ALLOW_CONFLICTS = (1u << 4),
	GIT_CHECKOUT_REMOVE_UNTRACKED = (1u << 5),
	GIT_CHECKOUT_REMOVE_IGNORED = (1u << 6),
	GIT_CHECKOUT_UPDATE_ONLY = (1u << 7),
	GIT_CHECKOUT_DONT_UPDATE_INDEX = (1u << 8),
	GIT_CHECKOUT_NO_REFRESH = (1u << 9),
	GIT_CHECKOUT_SKIP_UNMERGED = (1u << 10),
	GIT_CHECKOUT_USE_OURS = (1u << 11),
	GIT_CHECKOUT_USE_THEIRS = (1u << 12),
	GIT_CHECKOUT_DISABLE_PATHSPEC_MATCH = (1u << 13),
	GIT_CHECKOUT_SKIP_LOCKED_DIRECTORIES = (1u << 18),
	GIT_CHECKOUT_DONT_OVERWRITE_IGNORED = (1u << 19),
	GIT_CHECKOUT_CONFLICT_STYLE_MERGE = (1u << 20),
	GIT_CHECKOUT_CONFLICT_STYLE_DIFF3 = (1u << 21),
	GIT_CHECKOUT_DONT_REMOVE_EXISTING = (1u << 22),
    GIT_CHECKOUT_DONT_WRITE_INDEX = (1u << 23),
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

struct git_checkout_perfdata {
    size_t mkdir_calls;
    size_t stat_calls;
    size_t chmod_calls;
}

alias git_checkout_notify_cb = int function(
	git_checkout_notify_t why,
	const(char)* path,
	const(git_diff_file)* baseline,
	const(git_diff_file)* target,
	const(git_diff_file)* workdir,
	void *payload);

alias git_checkout_perfdata_cb = void function(
	const(git_checkout_perfdata)* perfdata,
	void *payload
);

alias git_checkout_progress_cb = void function(
	const(char)* path,
	size_t completed_steps,
	size_t total_steps,
	void *payload);

struct git_checkout_options {
	uint version_ = GIT_CHECKOUT_OPTIONS_VERSION;

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
	git_index *baseline_index;

	const(char)* target_directory;

	const(char)* ancestor_label;
	const(char)* our_label;
	const(char)* their_label;

	git_checkout_perfdata_cb perfdata_cb;
	void *perfdata_payload;
}

enum GIT_CHECKOUT_OPTIONS_VERSION = 1;
enum git_checkout_options GIT_CHECKOUT_OPTIONS_INIT = { GIT_CHECKOUT_OPTIONS_VERSION };

int git_checkout_init_options(
	git_checkout_options *opts,
	uint version_);
int git_checkout_head(
	git_repository *repo,
	const(git_checkout_options)* opts);
int git_checkout_index(
	git_repository *repo,
	git_index *index,
	const(git_checkout_options)* opts);
int git_checkout_tree(
	git_repository *repo,
	const(git_object)* treeish,
	const(git_checkout_options)* opts);
