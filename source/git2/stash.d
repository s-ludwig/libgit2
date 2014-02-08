module git2.stash;

import git2.common;
import git2.oid;
import git2.util;
import git2.types;

extern (C):

enum git_stash_flags {
	GIT_STASH_DEFAULT = 0,
	GIT_STASH_KEEP_INDEX = (1 << 0),
	GIT_STASH_INCLUDE_UNTRACKED = (1 << 1),
	GIT_STASH_INCLUDE_IGNORED = (1 << 2),
}
mixin _ExportEnumMembers!git_stash_flags;

int git_stash_save(
	git_oid *out_,
	git_repository *repo,
	git_signature *stasher,
	const(char)* message,
	uint flags);

alias git_stash_cb = int function(
	size_t index,
	const(char)* message,
	const(git_oid)* stash_id,
	void *payload);

int git_stash_foreach(
	git_repository *repo,
	git_stash_cb callback,
	void *payload);
int git_stash_drop(
	git_repository *repo,
	size_t index);
