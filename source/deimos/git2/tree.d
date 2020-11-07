module deimos.git2.tree;

import deimos.git2.common;
import deimos.git2.object_;
import deimos.git2.oid;
import deimos.git2.util;
import deimos.git2.types;

extern (C):

int git_tree_lookup(
	git_tree **out_, git_repository *repo, const(git_oid)* id);
int git_tree_lookup_prefix(
	git_tree **out_,
	git_repository *repo,
	const(git_oid)* id,
	size_t len);
void git_tree_free(git_tree *tree);
const(git_oid)*  git_tree_id(const(git_tree)* tree);
git_repository * git_tree_owner(const(git_tree)* tree);
size_t git_tree_entrycount(const(git_tree)* tree);
const(git_tree_entry)*  git_tree_entry_byname(
	const(git_tree)* tree, const(char)* filename);
const(git_tree_entry)*  git_tree_entry_byindex(
	const(git_tree)* tree, size_t idx);
const(git_tree_entry)*  git_tree_entry_byid(
	const(git_tree)* tree, const(git_oid)* oid);
int git_tree_entry_bypath(
	git_tree_entry **out_,
	const(git_tree)* root,
	const(char)* path);
git_tree_entry * git_tree_entry_dup(const(git_tree_entry)* entry);
void git_tree_entry_free(git_tree_entry *entry);
const(char)*  git_tree_entry_name(const(git_tree_entry)* entry);
const(git_oid)*  git_tree_entry_id(const(git_tree_entry)* entry);
git_otype git_tree_entry_type(const(git_tree_entry)* entry);
git_filemode_t git_tree_entry_filemode(const(git_tree_entry)* entry);
git_filemode_t git_tree_entry_filemode_raw(const(git_tree_entry)* entry);
int git_tree_entry_cmp(const(git_tree_entry)* e1, const(git_tree_entry)* e2);
int git_tree_entry_to_object(
	git_object **object_out,
	git_repository *repo,
	const(git_tree_entry)* entry);
int git_treebuilder_new(
    git_treebuilder **out_, git_repository *repo, const(git_tree) *source);
void git_treebuilder_clear(git_treebuilder *bld);
uint git_treebuilder_entrycount(git_treebuilder *bld);
void git_treebuilder_free(git_treebuilder *bld);
const(git_tree_entry)*  git_treebuilder_get(
	git_treebuilder *bld, const(char)* filename);
int git_treebuilder_insert(
	const(git_tree_entry)* *out_,
	git_treebuilder *bld,
	const(char)* filename,
	const(git_oid)* id,
	git_filemode_t filemode);
int git_treebuilder_remove(
	git_treebuilder *bld, const(char)* filename);

alias git_treebuilder_filter_cb = int function(
	const(git_tree_entry)* entry, void *payload);

void git_treebuilder_filter(
	git_treebuilder *bld,
	git_treebuilder_filter_cb filter,
	void *payload);
int git_treebuilder_write(
	git_oid *id, git_repository *repo, git_treebuilder *bld);

alias git_treewalk_cb = int function(
	const(char)* root, const(git_tree_entry)* entry, void *payload);

enum git_treewalk_mode {
	GIT_TREEWALK_PRE = 0,
	GIT_TREEWALK_POST = 1,
}
mixin _ExportEnumMembers!git_treewalk_mode;

int git_tree_walk(
	const(git_tree)* tree,
	git_treewalk_mode mode,
	git_treewalk_cb callback,
	void *payload);
