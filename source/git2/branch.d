module git2.branch;

import git2.common;
import git2.oid;
import git2.types;

extern (C):

int git_branch_create(
	git_reference **out_,
	git_repository *repo,
	const(char)* branch_name,
	const(git_commit)* target,
	int force);
int git_branch_delete(git_reference *branch);

alias git_branch_foreach_cb = int function(
	const(char)* branch_name,
	git_branch_t branch_type,
	void *payload);

int git_branch_foreach(
	git_repository *repo,
	uint list_flags,
	git_branch_foreach_cb branch_cb,
	void *payload);
int git_branch_move(
	git_reference **out_,
	git_reference *branch,
	const(char)* new_branch_name,
	int force);
int git_branch_lookup(
	git_reference **out_,
	git_repository *repo,
	const(char)* branch_name,
	git_branch_t branch_type);
int git_branch_name(const(char)** out_,
		git_reference *ref_);
int git_branch_upstream(
	git_reference **out_,
	git_reference *branch);
int git_branch_set_upstream(git_reference *branch, const(char)* upstream_name);
int git_branch_upstream_name(
	char *tracking_branch_name_out,
	size_t buffer_size,
	git_repository *repo,
	const(char)* canonical_branch_name);
int git_branch_is_head(
	git_reference *branch);
int git_branch_remote_name(
	char *remote_name_out,
	size_t buffer_size,
	git_repository *repo,
	const(char)* canonical_branch_name);
