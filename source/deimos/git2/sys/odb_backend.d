module deimos.git2.sys.odb_backend;

import deimos.git2.common;
import deimos.git2.odb;
import deimos.git2.odb_backend;
import deimos.git2.oid;
import deimos.git2.types;

extern (C):

struct git_odb_backend {
	uint version_ = GIT_ODB_BACKEND_VERSION;
	git_odb *odb;
	int function(
		void **, size_t *, git_otype *, git_odb_backend *, const(git_oid)* ) read;
	int function(
		git_oid *, void **, size_t *, git_otype *,
		git_odb_backend *, const(git_oid)* , size_t) read_prefix;
	int function(
		size_t *, git_otype *, git_odb_backend *, const(git_oid)* ) read_header;
	int function(
		git_odb_backend *, const git_oid *, const void *, size_t, git_otype) write;
	int function(
		git_odb_stream **, git_odb_backend *, size_t, git_otype) writestream;
	int function(
		git_odb_stream **, git_odb_backend *, const(git_oid)* ) readstream;
	int function(
		git_odb_backend *, const(git_oid)* ) exists;
	int function(git_odb_backend *) refresh;
	int function(
		git_odb_backend *, git_odb_foreach_cb cb, void *payload) foreach_;
	int function(
		git_odb_writepack **, git_odb_backend *, git_odb *odb,
		git_transfer_progress_cb progress_cb, void *progress_payload) writepack;
	void function(git_odb_backend *) free;
}

enum GIT_ODB_BACKEND_VERSION = 1;
enum git_odb_backend GIT_ODB_BACKEND_INIT = { GIT_ODB_BACKEND_VERSION };

void * git_odb_backend_malloc(git_odb_backend *backend, size_t len);
