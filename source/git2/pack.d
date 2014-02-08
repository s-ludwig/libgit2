module git2.pack;

import git2.common;
import git2.oid;
import git2.types;

extern (C):

int git_packbuilder_new(git_packbuilder **out_, git_repository *repo);
uint git_packbuilder_set_threads(git_packbuilder *pb, uint n);
int git_packbuilder_insert(git_packbuilder *pb, const(git_oid)* id, const(char)* name);
int git_packbuilder_insert_tree(git_packbuilder *pb, const(git_oid)* id);
int git_packbuilder_insert_commit(git_packbuilder *pb, const(git_oid)* id);
int git_packbuilder_write(
	git_packbuilder *pb,
	const(char)* path,
	git_transfer_progress_callback progress_cb,
	void *progress_cb_payload);

alias git_packbuilder_foreach_cb = int function(void *buf, size_t size, void *payload);

int git_packbuilder_foreach(git_packbuilder *pb, git_packbuilder_foreach_cb cb, void *payload);
uint32_t git_packbuilder_object_count(git_packbuilder *pb);
uint32_t git_packbuilder_written(git_packbuilder *pb);
void git_packbuilder_free(git_packbuilder *pb);
