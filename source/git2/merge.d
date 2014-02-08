module git2.merge;

import git2.common;
import git2.checkout;
import git2.diff;
import git2.index;
import git2.oid;
import git2.util;
import git2.types;

extern (C):

enum git_merge_tree_flag_t {
	GIT_MERGE_TREE_FIND_RENAMES = (1 << 0),
}
mixin _ExportEnumMembers!git_merge_tree_flag_t;

enum git_merge_automerge_flags {
	GIT_MERGE_AUTOMERGE_NORMAL = 0,
	GIT_MERGE_AUTOMERGE_NONE = 1,
	GIT_MERGE_AUTOMERGE_FAVOR_OURS = 2,
	GIT_MERGE_AUTOMERGE_FAVOR_THEIRS = 3,
}
mixin _ExportEnumMembers!git_merge_automerge_flags;

struct git_merge_tree_opts {
	uint version_ = GIT_MERGE_TREE_OPTS_VERSION;
	git_merge_tree_flag_t flags;
	uint rename_threshold;
	uint target_limit;
	git_diff_similarity_metric *metric;
	git_merge_automerge_flags automerge_flags;
}

enum GIT_MERGE_TREE_OPTS_VERSION = 1;
enum git_merge_tree_opts GIT_MERGE_TREE_OPTS_INIT = { GIT_MERGE_TREE_OPTS_VERSION };

int git_merge_base(
	git_oid *out_,
	git_repository *repo,
	const(git_oid)* one,
	const(git_oid)* two);
int git_merge_base_many(
	git_oid *out_,
	git_repository *repo,
	const(git_oid)* input_array,
	size_t length);
int git_merge_head_from_ref(
	git_merge_head **out_,
	git_repository *repo,
	git_reference *ref_);
int git_merge_head_from_fetchhead(
	git_merge_head **out_,
	git_repository *repo,
	const(char)* branch_name,
	const(char)* remote_url,
	const(git_oid)* oid);
int git_merge_head_from_oid(
	git_merge_head **out_,
	git_repository *repo,
	const(git_oid)* oid);
void git_merge_head_free(
	git_merge_head *head);
int git_merge_trees(
	git_index **out_,
	git_repository *repo,
	const(git_tree)* ancestor_tree,
	const(git_tree)* our_tree,
	const(git_tree)* their_tree,
	const(git_merge_tree_opts)* opts);
