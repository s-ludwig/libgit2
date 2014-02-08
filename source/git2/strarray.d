module git2.strarray;

import git2.common;

extern (C):

struct git_strarray {
	char **strings;
	size_t count;
};

void git_strarray_free(git_strarray *array);
int git_strarray_copy(git_strarray *tgt, const(git_strarray)* src);
