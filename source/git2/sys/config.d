module git2.sys.config;

import git2.common;
import git2.config;
import git2.types;

extern (C):

struct git_config_backend {
	uint version_ = GIT_CONFIG_BACKEND_VERSION;
	git_config *cfg;

	int function(git_config_backend *, git_config_level_t level) open;
	int function(const(git_config_backend)*, const(char)* key, const(git_config_entry)** entry) get;
	int function(git_config_backend *, const(char)* key, const(char)* regexp, git_config_foreach_cb callback, void *payload) get_multivar;
	int function(git_config_backend *, const(char)* key, const(char)* value) set;
	int function(git_config_backend *cfg, const(char)* name, const(char)* regexp, const(char)* value) set_multivar;
	int function(git_config_backend *, const(char)* key) del;
	int function(git_config_backend *, const(char)* , git_config_foreach_cb callback, void *payload) _foreach;
	int function(git_config_backend *) refresh;
	void function(git_config_backend *) free;
}

enum GIT_CONFIG_BACKEND_VERSION = 1;
enum git_config_backend GIT_CONFIG_BACKEND_INIT = { GIT_CONFIG_BACKEND_VERSION };

int git_config_add_backend(
	git_config *cfg,
	git_config_backend *file,
	git_config_level_t level,
	int force);
