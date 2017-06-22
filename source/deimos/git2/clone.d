module deimos.git2.clone;

import deimos.git2.checkout;
import deimos.git2.common;
import deimos.git2.indexer;
import deimos.git2.remote;
import deimos.git2.transport;
import deimos.git2.types;
import deimos.git2.util;

extern (C):


enum git_clone_local_t {
    GIT_CLONE_LOCAL_AUTO,
    GIT_CLONE_LOCAL,
    GIT_CLONE_NO_LOCAL,
    GIT_CLONE_LOCAL_NO_LINKS,
}
mixin _ExportEnumMembers!git_clone_local_t;

alias git_remote_create_cb = int function(
    git_remote **out_,
    git_repository *repo,
    const(char)* name,
    const(char)* url,
    void *payload,
);
alias git_repository_create_cb = int function(
    git_repository **out_,
    const(char)* path,
    int bare,
    void *payload,
);

struct git_clone_options {
	uint version_ = GIT_CLONE_OPTIONS_VERSION;

	git_checkout_options checkout_opts;
	git_fetch_options fetch_opts;

	int bare;
	git_clone_local_t local;
	const(char)* checkout_branch;

	git_repository_create_cb repository_cb;
	void *repository_cb_payload;
	git_remote_create_cb remote_cb;
	void *remote_cb_payload;
}

enum GIT_CLONE_OPTIONS_VERSION = 1;
enum git_clone_options GIT_CLONE_OPTIONS_INIT = {
	GIT_CLONE_OPTIONS_VERSION,
	{ GIT_CHECKOUT_OPTIONS_VERSION, GIT_CHECKOUT_SAFE },
	GIT_FETCH_OPTIONS_INIT
};

int git_clone_init_options(
    git_clone_options *opts,
    uint version_,
);
int git_clone(
    git_repository **out_,
    const(char)* url,
    const(char)* local_path,
    const(git_clone_options)* options,
);
