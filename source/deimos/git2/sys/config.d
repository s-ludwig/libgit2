module deimos.git2.sys.config;

import deimos.git2.common;
import deimos.git2.config;
import deimos.git2.types;

extern (C):

struct git_config_iterator {
	git_config_backend *backend;
	uint flags;
	int function(git_config_entry **entry, git_config_iterator *iter) next;
	void function(git_config_iterator *iter) free;
}

struct git_config_backend {
	uint version_ = GIT_CONFIG_BACKEND_VERSION;
	git_config *cfg;

	int function(git_config_backend *, git_config_level_t level) open;
	int function(const(git_config_backend)*, const(char)* key, const(git_config_entry)** entry) get;
	int function(git_config_backend *, const(char)* key, const(char)* value) set;
	int function(git_config_backend *cfg, const(char)* name, const(char)* regexp, const(char)* value) set_multivar;
	int function(git_config_backend *, const(char)* key) del;
	int function(git_config_backend *, const(char)* key, const(char)* regexp) del_multivar;
	int function(git_config_iterator **, git_config_backend *) iterator;
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
