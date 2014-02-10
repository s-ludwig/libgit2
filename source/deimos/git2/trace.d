module deimos.git2.trace;

import deimos.git2.common;
import deimos.git2.util;
import deimos.git2.types;

extern (C):

enum git_trace_level_t {
	GIT_TRACE_NONE = 0,
	GIT_TRACE_FATAL = 1,
	GIT_TRACE_ERROR = 2,
	GIT_TRACE_WARN = 3,
	GIT_TRACE_INFO = 4,
	GIT_TRACE_DEBUG = 5,
	GIT_TRACE_TRACE = 6
}
mixin _ExportEnumMembers!git_trace_level_t;

alias git_trace_callback = void function(git_trace_level_t level, const(char)* msg);

int git_trace_set(git_trace_level_t level, git_trace_callback cb);
