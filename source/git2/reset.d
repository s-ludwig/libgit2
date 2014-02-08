module git2.reset;

import git2.strarray;
import git2.util;
import git2.types;

extern (C):

enum git_reset_t {
	GIT_RESET_SOFT  = 1,
	GIT_RESET_MIXED = 2,
	GIT_RESET_HARD  = 3,
}
mixin _ExportEnumMembers!git_reset_t;

int git_reset(
	git_repository *repo, git_object *target, git_reset_t reset_type);
int git_reset_default(
	git_repository *repo,
	git_object *target,
	git_strarray* pathspecs);
