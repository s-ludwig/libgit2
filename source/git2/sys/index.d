module git2.sys.index;

import git2.oid;
import git2.types;

extern (C):

struct git_index_name_entry {
	char *ancestor;
	char *ours;
	char *theirs;
}

struct git_index_reuc_entry {
	uint[3] mode;
	git_oid[3] oid;
	char *path;
}

uint git_index_name_entrycount(git_index *index);

const(git_index_name_entry)*  git_index_name_get_byindex(
	git_index *index, size_t n);

int git_index_name_add(git_index *index,
	const(char)* ancestor, const(char)* ours, const(char)* theirs);

void git_index_name_clear(git_index *index);
uint git_index_reuc_entrycount(git_index *index);
int git_index_reuc_find(size_t *at_pos, git_index *index, const(char)* path);
const(git_index_reuc_entry)*  git_index_reuc_get_bypath(git_index *index, const(char)* path);
const(git_index_reuc_entry)*  git_index_reuc_get_byindex(git_index *index, size_t n);
int git_index_reuc_add(git_index *index, const(char)* path,
	int ancestor_mode, const(git_oid)* ancestor_id,
	int our_mode, const(git_oid)* our_id,
	int their_mode, const(git_oid)* their_id);
int git_index_reuc_remove(git_index *index, size_t n);
void git_index_reuc_clear(git_index *index);
