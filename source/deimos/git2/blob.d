module deimos.git2.blob;

import deimos.git2.common;
import deimos.git2.object_;
import deimos.git2.oid;
import deimos.git2.types;
import deimos.git2.buffer;

extern (C):

int git_blob_lookup(git_blob **blob, git_repository *repo, const(git_oid)* id);
int git_blob_lookup_prefix(git_blob **blob, git_repository *repo, const(git_oid)* id, size_t len);
void git_blob_free(git_blob *blob);
const(git_oid)* git_blob_id(const(git_blob)* blob);
git_repository * git_blob_owner(const(git_blob)* blob);
const(void)*  git_blob_rawcontent(const(git_blob)* blob);
git_off_t git_blob_rawsize(const(git_blob)* blob);
int git_blob_filtered_content(git_buf *out_, git_blob *blob, const(char)* as_path, int check_for_binary_data);
int git_blob_create_fromworkdir(git_oid *id, git_repository *repo, const(char)* relative_path);
int git_blob_create_fromdisk(git_oid *id, git_repository *repo, const(char)* path);

alias git_blob_chunk_cb = int function(char *content, size_t max_length, void *payload);

int git_blob_create_frombuffer(git_oid *id, git_repository *repo, const(void)* buffer, size_t len);
int git_blob_is_binary(const(git_blob)* blob);
int git_blob_create_fromstream(git_writestream **out_, git_repository *repo, const(char)* hintpath);
int git_blob_create_fromstream_commit(git_oid *out_, git_writestream *_stream);
int git_blob_dup(git_blob **out_, git_blob *source);
