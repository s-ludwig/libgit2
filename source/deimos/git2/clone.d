module deimos.git2.clone;

import deimos.git2.checkout;
import deimos.git2.common;
import deimos.git2.indexer;
import deimos.git2.remote;
import deimos.git2.transport;
import deimos.git2.types;

extern (C):

struct git_clone_options {
	uint version_ = GIT_CLONE_OPTIONS_VERSION;

	git_checkout_opts checkout_opts;
	int bare;
	git_transfer_progress_callback fetch_progress_cb;
	void *fetch_progress_payload;

	const(char)* remote_name;
	const(char)* pushurl;
	const(char)* fetch_spec;
	const(char)* push_spec;
	git_cred_acquire_cb cred_acquire_cb;
	void *cred_acquire_payload;
    git_transport_flags_t transport_flags;
	git_transport *transport;
	deimos.git2.remote.git_remote_callbacks *remote_callbacks;
	git_remote_autotag_option_t remote_autotag;
	const(char)* checkout_branch;
}

enum GIT_CLONE_OPTIONS_VERSION = 1;
enum git_clone_options GIT_CLONE_OPTIONS_INIT = { GIT_CLONE_OPTIONS_VERSION };

int git_clone(
		git_repository **out_,
		const(char)* url,
		const(char)* local_path,
		const(git_clone_options)* options);
