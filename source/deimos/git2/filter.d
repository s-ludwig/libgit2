module deimos.git2.filter;

import deimos.git2.common;
import deimos.git2.types;
import deimos.git2.oid;
import deimos.git2.buffer;

enum git_filter_mode_t {
	GIT_FILTER_TO_WORKTREE = 0,
	GIT_FILTER_SMUDGE = GIT_FILTER_TO_WORKTREE,
	GIT_FILTER_TO_ODB = 1,
	GIT_FILTER_CLEAN = GIT_FILTER_TO_ODB,
}

enum git_filter_flag_t {
    GIT_FILTER_DEFAULT = 0u,
    GIT_FILTER_ALLOW_UNSAFE = (1u << 0),
}

struct git_filter {
	@disable this();
	@disable this(this);
}

struct git_filter_list {
	@disable this();
	@disable this(this);
}

int git_filter_list_load(
	git_filter_list **filters,
	git_repository *repo,
	git_blob *blob,
	const(char)* path,
	git_filter_mode_t mode,
	uint flags);
int git_filter_list_apply_to_data(
	git_buf *out_,
	git_filter_list *filters,
	git_buf *in_);
int git_filter_list_apply_to_file(
	git_buf *out_,
	git_filter_list *filters,
	git_repository *repo,
	const(char)* path);
int git_filter_list_apply_to_blob(
	git_buf *out_,
	git_filter_list *filters,
	git_blob *blob);
int git_filter_list_stream_data(
    git_filter_list *filters,
    git_buf *data,
    git_writestream *target);
int git_filter_list_stream_file(
    git_filter_list *filters,
    git_repository *repo,
    const(char)* path,
    git_writestream *target);
int git_filter_list_stream_blob(
    git_filter_list *filters,
    git_blob *blob,
    git_writestream *target);

void git_filter_list_free(git_filter_list *filters);
