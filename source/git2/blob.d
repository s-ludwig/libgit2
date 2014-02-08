module git2.blob;

import git2.common;
import git2.object_;
import git2.oid;
import git2.types;

extern (C):

int git_blob_lookup(git_blob **blob, git_repository *repo, const(git_oid)* id);
int git_blob_lookup_prefix(git_blob **blob, git_repository *repo, const(git_oid)* id, size_t len);
void git_blob_free(git_blob *blob);
const(git_oid)* git_blob_id(const(git_blob)* blob);
git_repository * git_blob_owner(const(git_blob)* blob);
const(void)*  git_blob_rawcontent(const(git_blob)* blob);
git_off_t git_blob_rawsize(const(git_blob)* blob);
int git_blob_create_fromworkdir(git_oid *id, git_repository *repo, const(char)* relative_path);
int git_blob_create_fromdisk(git_oid *id, git_repository *repo, const(char)* path);

alias git_blob_chunk_cb = int function(char *content, size_t max_length, void *payload);

int git_blob_create_fromchunks(
	git_oid *id,
	git_repository *repo,
	const(char)* hintpath,
	git_blob_chunk_cb callback,
	void *payload);
int git_blob_create_frombuffer(git_oid *oid, git_repository *repo, const(void)* buffer, size_t len);
int git_blob_is_binary(git_blob *blob);
