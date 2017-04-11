module deimos.git2.net;

import deimos.git2.common;
import deimos.git2.oid;
import deimos.git2.util;
import deimos.git2.types;

extern (C):

enum GIT_DEFAULT_PORT = "9418";

enum git_direction {
	GIT_DIRECTION_FETCH = 0,
	GIT_DIRECTION_PUSH  = 1
}
mixin _ExportEnumMembers!git_direction;

struct git_remote_head {
	int local;
	git_oid oid;
	git_oid loid;
	char* name;
	char* symref_target;
}

alias git_headlist_cb = int function(git_remote_head *rhead, void *payload);
