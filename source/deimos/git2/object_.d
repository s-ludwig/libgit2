module deimos.git2.object_;

import deimos.git2.common;
import deimos.git2.oid;
import deimos.git2.types;

extern (C):

int git_object_lookup(
		git_object **object,
		git_repository *repo,
		const(git_oid)* id,
		git_otype type);
int git_object_lookup_prefix(
		git_object **object_out,
		git_repository *repo,
		const(git_oid)* id,
		size_t len,
		git_otype type);
int git_object_lookup_bypath(
		git_object **out_,
		const git_object *treeish,
		const(char)* path,
		git_otype type);
const(git_oid)* git_object_id(const(git_object)* obj);
git_otype git_object_type(const(git_object)* obj);
git_repository * git_object_owner(const(git_object)* obj);
void git_object_free(git_object *object);
const(char)* git_object_type2string(git_otype type);
git_otype git_object_string2type(const(char)* str);
int git_object_typeisloose(git_otype type);
size_t git_object__size(git_otype type);
int git_object_peel(
	git_object **peeled,
	const(git_object)* object,
	git_otype target_type);
int git_object_dup(git_object **dest, git_object *source);
