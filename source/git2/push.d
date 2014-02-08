module git2.push;

import git2.common;
import git2.types;

extern (C):

struct git_push_options {
	uint version_ = GIT_PUSH_OPTIONS_VERSION;
	uint pb_parallelism;
}

enum GIT_PUSH_OPTIONS_VERSION = 1;
enum git_push_options GIT_PUSH_OPTIONS_INIT = { GIT_PUSH_OPTIONS_VERSION };

int git_push_new(git_push **out_, git_remote *remote);
int git_push_set_options(
	git_push *push,
	const(git_push_options)* opts);
int git_push_add_refspec(git_push *push, const(char)* refspec);
int git_push_update_tips(git_push *push);
int git_push_finish(git_push *push);
int git_push_unpack_ok(git_push *push);
int git_push_status_foreach(
    git_push *push,
    int function(const(char)* ref_, const(char)* msg, void *data) cb,
	void *data);
void git_push_free(git_push *push);
