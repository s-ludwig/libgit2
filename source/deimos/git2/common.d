module deimos.git2.common;

import deimos.git2.util;

extern (C):

version(Windows)
    enum GIT_PATH_LIST_SEPARATOR = ';';
else
    enum GIT_PATH_LIST_SEPARATOR = ':';

version(Windows)
    enum GIT_WIN32 = 1;
else
    enum GIT_WIN32 = 0;

enum GIT_PATH_MAX = 4096;

enum GIT_OID_HEX_ZERO = "0000000000000000000000000000000000000000";

void git_libgit2_version(int *major, int *minor, int *rev);

enum git_cap_t
{
	GIT_CAP_THREADS			= ( 1 << 0 ),
	GIT_CAP_HTTPS			= ( 1 << 1 )
}
mixin _ExportEnumMembers!git_cap_t;

int git_libgit2_capabilities();

enum git_libgit2_opt_t
{
	GIT_OPT_GET_MWINDOW_SIZE,
	GIT_OPT_SET_MWINDOW_SIZE,
	GIT_OPT_GET_MWINDOW_MAPPED_LIMIT,
	GIT_OPT_SET_MWINDOW_MAPPED_LIMIT,
	GIT_OPT_GET_SEARCH_PATH,
	GIT_OPT_SET_SEARCH_PATH,
	GIT_OPT_SET_CACHE_OBJECT_LIMIT,
	GIT_OPT_SET_CACHE_MAX_SIZE,
	GIT_OPT_ENABLE_CACHING,
	GIT_OPT_GET_CACHED_MEMORY
}
mixin _ExportEnumMembers!git_libgit2_opt_t;

int git_libgit2_opts(int option, ...);
