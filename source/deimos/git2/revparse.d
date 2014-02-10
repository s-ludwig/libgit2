module deimos.git2.revparse;

import deimos.git2.common;
import deimos.git2.util;
import deimos.git2.types;

extern (C):

int git_revparse_single(
	git_object **out_, git_repository *repo, const(char) *spec);
int git_revparse_ext(
	git_object **object_out,
	git_reference **reference_out,
	git_repository *repo,
	const(char)* spec);

enum git_revparse_mode_t : uint {
	GIT_REVPARSE_SINGLE         = 1 << 0,
	GIT_REVPARSE_RANGE          = 1 << 1,
	GIT_REVPARSE_MERGE_BASE     = 1 << 2,
}
mixin _ExportEnumMembers!git_revparse_mode_t;

struct git_revspec {
	git_object *from;
	git_object *to;
	git_revparse_mode_t flags;
}

int git_revparse(
	git_revspec *revspec,
	git_repository *repo,
	const(char)* spec);
