module deimos.git2.refs;

import deimos.git2.common;
import deimos.git2.oid;
import deimos.git2.strarray;
import deimos.git2.sys.refdb_backend;
import deimos.git2.types;
import deimos.git2.util;

extern (C):

int git_reference_lookup(git_reference **out_, git_repository *repo, const(char)* name);
int git_reference_name_to_id(
	git_oid *out_, git_repository *repo, const(char)* name);
int git_reference_dwim(git_reference **out_, git_repository *repo, const(char)* shorthand);
int git_reference_symbolic_create(git_reference **out_, git_repository *repo, const(char)* name, const(char)* target, int force);
int git_reference_create(git_reference **out_, git_repository *repo, const(char)* name, const(git_oid)* id, int force);
const(git_oid)*  git_reference_target(const(git_reference)* ref_);
const(git_oid)*  git_reference_target_peel(const(git_reference)* ref_);
const(char)*  git_reference_symbolic_target(const(git_reference)* ref_);
git_ref_t git_reference_type(const(git_reference)* ref_);
const(char)*  git_reference_name(const(git_reference)* ref_);
int git_reference_resolve(git_reference **out_, const(git_reference)* ref_);
git_repository * git_reference_owner(const(git_reference)* ref_);
int git_reference_symbolic_set_target(
	git_reference **out_,
	git_reference *ref_,
	const(char)* target);
int git_reference_set_target(
	git_reference **out_,
	git_reference *ref_,
	const(git_oid)* id);
int git_reference_rename(
	git_reference **new_ref,
	git_reference *ref_,
	const(char)* new_name,
	int force);
int git_reference_delete(git_reference *ref_);
int git_reference_list(git_strarray *array, git_repository *repo);

alias git_reference_foreach_cb = int function(git_reference *reference, void *payload);
alias git_reference_foreach_name_cb = int function(const(char)* name, void *payload);

int git_reference_foreach(
	git_repository *repo,
	git_reference_foreach_cb callback,
	void *payload);
int git_reference_foreach_name(
	git_repository *repo,
	git_reference_foreach_name_cb callback,
	void *payload);
void git_reference_free(git_reference *ref_);
int git_reference_cmp(git_reference *ref1, git_reference *ref2);
int git_reference_iterator_new(
	git_reference_iterator **out_,
	git_repository *repo);
int git_reference_iterator_glob_new(
	git_reference_iterator **out_,
	git_repository *repo,
	const(char)* glob);
int git_reference_next(git_reference **out_, git_reference_iterator *iter);
int git_reference_next_name(const(char)** out_, git_reference_iterator *iter);
void git_reference_iterator_free(git_reference_iterator *iter);
int git_reference_foreach_glob(
	git_repository *repo,
	const(char)* glob,
	git_reference_foreach_name_cb callback,
	void *payload);
int git_reference_has_log(git_reference *ref_);
int git_reference_is_branch(git_reference *ref_);
int git_reference_is_remote(git_reference *ref_);
int git_reference_is_tag(git_reference *ref_);

enum git_reference_normalize_t {
	GIT_REF_FORMAT_NORMAL = 0u,
	GIT_REF_FORMAT_ALLOW_ONELEVEL = (1u << 0),
	GIT_REF_FORMAT_REFSPEC_PATTERN = (1u << 1),
	GIT_REF_FORMAT_REFSPEC_SHORTHAND = (1u << 2),
}
mixin _ExportEnumMembers!git_reference_normalize_t;

int git_reference_normalize_name(
	char *buffer_out,
	size_t buffer_size,
	const(char)* name,
	uint flags);
int git_reference_peel(
	git_object **out_,
	git_reference *ref_,
	git_otype type);
int git_reference_is_valid_name(const(char)* refname);
const(char)*  git_reference_shorthand(git_reference *ref_);
