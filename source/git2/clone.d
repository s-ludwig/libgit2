module git2.clone;

import git2.checkout;
import git2.common;
import git2.indexer;
import git2.remote;
import git2.transport;
import git2.types;

extern (C):

struct git_clone_options {
	uint version_ = GIT_CLONE_OPTIONS_VERSION;

	git_checkout_opts checkout_opts;
	git_remote_callbacks remote_callbacks;

	int bare;
	int ignore_cert_errors;
	const(char)* remote_name;
	const(char)* checkout_branch;
}

enum GIT_CLONE_OPTIONS_VERSION = 1;
enum git_clone_options GIT_CLONE_OPTIONS_INIT = { GIT_CLONE_OPTIONS_VERSION };

int git_clone(
		git_repository **out_,
		const(char)* url,
		const(char)* local_path,
		const(git_clone_options)* options);
int git_clone_into(git_repository *repo, git_remote *remote, const(git_checkout_opts)* co_opts, const(char)* branch);
