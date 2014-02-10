module deimos.git2.sys.refdb_backend;

import deimos.git2.common;
import deimos.git2.oid;
import deimos.git2.types;

extern (C):

struct git_reference_iterator {
	git_refdb *db;
	int function(
		git_reference **ref_,
		git_reference_iterator *iter) next;
	int function(
		const(char)** ref_name,
		git_reference_iterator *iter) next_name;
	void function(
		git_reference_iterator *iter) free;
}

struct git_refdb_backend {
	uint version_ = GIT_REFDB_BACKEND_VERSION;
	int function(
		int *exists,
		git_refdb_backend *backend,
		const(char)* ref_name) exists;
	int function(
		git_reference **out_,
		git_refdb_backend *backend,
		const(char)* ref_name) lookup;
	int function(
		git_reference_iterator **iter,
		git_refdb_backend *backend,
		const(char)* glob) iterator;
	int function(git_refdb_backend *backend,
		const(git_reference)* ref_, int force) write;
	int function(
		git_reference **out_, git_refdb_backend *backend,
		const(char)* old_name, const(char)* new_name, int force) rename;
	int function(git_refdb_backend *backend, const(char)* ref_name) del;
	int function(git_refdb_backend *backend) compress;
	void function(git_refdb_backend *backend) free;
	int function(git_reflog **out_, git_refdb_backend *backend, const(char)* name) reflog_read;
	int function(git_refdb_backend *backend, git_reflog *reflog) reflog_write;
	int function(git_refdb_backend *_backend, const(char)* old_name, const(char)* new_name) reflog_rename;
	int function(git_refdb_backend *backend, const(char)* name) reflog_delete;
}

enum GIT_REFDB_BACKEND_VERSION = 1;
enum git_refdb_backend GIT_REFDB_BACKEND_INIT = { GIT_REFDB_BACKEND_VERSION };

int git_refdb_backend_fs(
	git_refdb_backend **backend_out,
	git_repository *repo);
int git_refdb_set_backend(
	git_refdb *refdb,
	git_refdb_backend *backend);
