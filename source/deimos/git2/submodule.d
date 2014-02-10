module deimos.git2.submodule;

import deimos.git2.common;
import deimos.git2.oid;
import deimos.git2.util;
import deimos.git2.types;

extern (C):

enum git_submodule_status_t {
	GIT_SUBMODULE_STATUS_IN_HEAD           = (1u << 0),
	GIT_SUBMODULE_STATUS_IN_INDEX          = (1u << 1),
	GIT_SUBMODULE_STATUS_IN_CONFIG         = (1u << 2),
	GIT_SUBMODULE_STATUS_IN_WD             = (1u << 3),
	GIT_SUBMODULE_STATUS_INDEX_ADDED       = (1u << 4),
	GIT_SUBMODULE_STATUS_INDEX_DELETED     = (1u << 5),
	GIT_SUBMODULE_STATUS_INDEX_MODIFIED    = (1u << 6),
	GIT_SUBMODULE_STATUS_WD_UNINITIALIZED  = (1u << 7),
	GIT_SUBMODULE_STATUS_WD_ADDED          = (1u << 8),
	GIT_SUBMODULE_STATUS_WD_DELETED        = (1u << 9),
	GIT_SUBMODULE_STATUS_WD_MODIFIED       = (1u << 10),
	GIT_SUBMODULE_STATUS_WD_INDEX_MODIFIED = (1u << 11),
	GIT_SUBMODULE_STATUS_WD_WD_MODIFIED    = (1u << 12),
	GIT_SUBMODULE_STATUS_WD_UNTRACKED      = (1u << 13),
}
mixin _ExportEnumMembers!git_submodule_status_t;

enum GIT_SUBMODULE_STATUS__IN_FLAGS = 0x000Fu;
enum GIT_SUBMODULE_STATUS__INDEX_FLAGS = 0x0070u;
enum GIT_SUBMODULE_STATUS__WD_FLAGS = 0x3F80u;

auto GIT_SUBMODULE_STATUS_IS_UNMODIFIED(T)(T S)
{
	return (((S) & ~git_submodule_status_t.GIT_SUBMODULE_STATUS__IN_FLAGS) == 0);
}

auto GIT_SUBMODULE_STATUS_IS_INDEX_UNMODIFIED(T)(T S)
{
	return (((S) & git_submodule_status_t.GIT_SUBMODULE_STATUS__INDEX_FLAGS) == 0);
}

auto GIT_SUBMODULE_STATUS_IS_WD_UNMODIFIED(T)(T S)
{
	return (((S) & git_submodule_status_t.GIT_SUBMODULE_STATUS__WD_FLAGS) == 0);
}

auto GIT_SUBMODULE_STATUS_IS_WD_DIRTY(T)(T S)
{
	return (((S) & (git_submodule_status_t.GIT_SUBMODULE_STATUS_WD_INDEX_MODIFIED |
	git_submodule_status_t.GIT_SUBMODULE_STATUS_WD_WD_MODIFIED |
	git_submodule_status_t.GIT_SUBMODULE_STATUS_WD_UNTRACKED)) != 0);
}

int git_submodule_lookup(
	git_submodule **submodule,
	git_repository *repo,
	const(char)* name);
int git_submodule_foreach(
	git_repository *repo,
	int function(git_submodule *sm, const(char)* name, void *payload) callback,
	void *payload);
int git_submodule_add_setup(
	git_submodule **submodule,
	git_repository *repo,
	const(char)* url,
	const(char)* path,
	int use_gitlink);
int git_submodule_add_finalize(git_submodule *submodule);
int git_submodule_add_to_index(
	git_submodule *submodule,
	int write_index);
int git_submodule_save(git_submodule *submodule);
git_repository * git_submodule_owner(git_submodule *submodule);
const(char)*  git_submodule_name(git_submodule *submodule);
const(char)*  git_submodule_path(git_submodule *submodule);
const(char)*  git_submodule_url(git_submodule *submodule);
int git_submodule_set_url(git_submodule *submodule, const(char)* url);
const(git_oid)*  git_submodule_index_id(git_submodule *submodule);
const(git_oid)*  git_submodule_head_id(git_submodule *submodule);
const(git_oid)*  git_submodule_wd_id(git_submodule *submodule);
git_submodule_ignore_t git_submodule_ignore(
	git_submodule *submodule);
git_submodule_ignore_t git_submodule_set_ignore(
	git_submodule *submodule,
	git_submodule_ignore_t ignore);
git_submodule_update_t git_submodule_update(
	git_submodule *submodule);
git_submodule_update_t git_submodule_set_update(
	git_submodule *submodule,
	git_submodule_update_t update);
int git_submodule_fetch_recurse_submodules(
	git_submodule *submodule);
int git_submodule_set_fetch_recurse_submodules(
	git_submodule *submodule,
	int fetch_recurse_submodules);
int git_submodule_init(git_submodule *submodule, int overwrite);
int git_submodule_sync(git_submodule *submodule);
int git_submodule_open(
	git_repository **repo,
	git_submodule *submodule);
int git_submodule_reload(git_submodule *submodule);
int git_submodule_reload_all(git_repository *repo);
int git_submodule_status(
	uint *status,
	git_submodule *submodule);
int git_submodule_location(
	uint *location_status,
	git_submodule *submodule);
