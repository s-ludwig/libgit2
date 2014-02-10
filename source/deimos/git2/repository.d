module deimos.git2.repository;

import std.conv;

import deimos.git2.common;
import deimos.git2.oid;
import deimos.git2.util;
import deimos.git2.types;

extern (C):

int git_repository_open(git_repository **out_, const(char)* path);
int git_repository_wrap_odb(git_repository **out_, git_odb *odb);
int git_repository_discover(
		char *path_out,
		size_t path_size,
		const(char)* start_path,
		int across_fs,
		const(char)* ceiling_dirs);

enum git_repository_open_flag_t {
	GIT_REPOSITORY_OPEN_NO_SEARCH = (1 << 0),
	GIT_REPOSITORY_OPEN_CROSS_FS  = (1 << 1),
	GIT_REPOSITORY_OPEN_BARE      = (1 << 2),
}
mixin _ExportEnumMembers!git_repository_open_flag_t;

int git_repository_open_ext(
	git_repository **out_,
	const(char)* path,
	uint flags,
	const(char)* ceiling_dirs);
int git_repository_open_bare(git_repository **out_, const(char)* bare_path);
void git_repository_free(git_repository *repo);
int git_repository_init(
	git_repository **out_,
	const(char)* path,
	uint is_bare);

enum git_repository_init_flag_t {
	GIT_REPOSITORY_INIT_BARE              = (1u << 0),
	GIT_REPOSITORY_INIT_NO_REINIT         = (1u << 1),
	GIT_REPOSITORY_INIT_NO_DOTGIT_DIR     = (1u << 2),
	GIT_REPOSITORY_INIT_MKDIR             = (1u << 3),
	GIT_REPOSITORY_INIT_MKPATH            = (1u << 4),
	GIT_REPOSITORY_INIT_EXTERNAL_TEMPLATE = (1u << 5),
}
mixin _ExportEnumMembers!git_repository_init_flag_t;

enum git_repository_init_mode_t {
	GIT_REPOSITORY_INIT_SHARED_UMASK = octal!0,
	GIT_REPOSITORY_INIT_SHARED_GROUP = octal!2775,
	GIT_REPOSITORY_INIT_SHARED_ALL   = octal!2777,
}
mixin _ExportEnumMembers!git_repository_init_mode_t;

struct git_repository_init_options {
	uint version_ = GIT_REPOSITORY_INIT_OPTIONS_VERSION;
	uint32_t    flags;
	uint32_t    mode;
	const(char)* workdir_path;
	const(char)* description;
	const(char)* template_path;
	const(char)* initial_head;
	const(char)* origin_url;
}

enum GIT_REPOSITORY_INIT_OPTIONS_VERSION = 1;
enum git_repository_init_options GIT_REPOSITORY_INIT_OPTIONS_INIT = { GIT_REPOSITORY_INIT_OPTIONS_VERSION };

int git_repository_init_ext(
	git_repository **out_,
	const(char)* repo_path,
	git_repository_init_options *opts);
int git_repository_head(git_reference **out_, git_repository *repo);
int git_repository_head_detached(git_repository *repo);
int git_repository_head_unborn(git_repository *repo);
int git_repository_is_empty(git_repository *repo);
const(char)*  git_repository_path(git_repository *repo);
const(char)*  git_repository_workdir(git_repository *repo);
int git_repository_set_workdir(
	git_repository *repo, const(char)* workdir, int update_gitlink);
int git_repository_is_bare(git_repository *repo);
int git_repository_config(git_config **out_, git_repository *repo);
int git_repository_odb(git_odb **out_, git_repository *repo);
int git_repository_refdb(git_refdb **out_, git_repository *repo);
int git_repository_index(git_index **out_, git_repository *repo);
int git_repository_message(char *out_, size_t len, git_repository *repo);
int git_repository_message_remove(git_repository *repo);
int git_repository_merge_cleanup(git_repository *repo);

alias git_repository_fetchhead_foreach_cb = int function(const(char)* ref_name,
	const(char)* remote_url,
	const(git_oid)* oid,
	uint is_merge,
	void *payload);

int git_repository_fetchhead_foreach(git_repository *repo,
	git_repository_fetchhead_foreach_cb callback,
	void *payload);

alias git_repository_mergehead_foreach_cb = int function(const(git_oid)* oid,
	void *payload);

int git_repository_mergehead_foreach(git_repository *repo,
	git_repository_mergehead_foreach_cb callback,
	void *payload);
int git_repository_hashfile(
	git_oid *out_,
	git_repository *repo,
	const(char)* path,
	git_otype type,
	const(char)* as_path);
int git_repository_set_head(
	git_repository* repo,
	const(char)* refname);
int git_repository_set_head_detached(
	git_repository* repo,
	const(git_oid)* commitish);
int git_repository_detach_head(
	git_repository* repo);

enum git_repository_state_t {
	GIT_REPOSITORY_STATE_NONE,
	GIT_REPOSITORY_STATE_MERGE,
	GIT_REPOSITORY_STATE_REVERT,
	GIT_REPOSITORY_STATE_CHERRY_PICK,
	GIT_REPOSITORY_STATE_BISECT,
	GIT_REPOSITORY_STATE_REBASE,
	GIT_REPOSITORY_STATE_REBASE_INTERACTIVE,
	GIT_REPOSITORY_STATE_REBASE_MERGE,
	GIT_REPOSITORY_STATE_APPLY_MAILBOX,
	GIT_REPOSITORY_STATE_APPLY_MAILBOX_OR_REBASE,
}
mixin _ExportEnumMembers!git_repository_state_t;

int git_repository_state(git_repository *repo);
int git_repository_set_namespace(git_repository *repo, const(char)* nmspace);
const(char)*  git_repository_get_namespace(git_repository *repo);
int git_repository_is_shallow(git_repository *repo);
