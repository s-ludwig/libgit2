module deimos.git2.blame;

import deimos.git2.common;
import deimos.git2.oid;
import deimos.git2.types;

extern(C):

enum git_blame_flag_t {
	GIT_BLAME_NORMAL = 0,
	GIT_BLAME_TRACK_COPIES_SAME_FILE = (1<<0),
	GIT_BLAME_TRACK_COPIES_SAME_COMMIT_MOVES = (1<<1),
	GIT_BLAME_TRACK_COPIES_SAME_COMMIT_COPIES = (1<<2),
	GIT_BLAME_TRACK_COPIES_ANY_COMMIT_COPIES = (1<<3),
	GIT_BLAME_FIRST_PARENT = (1<<4),
}

struct git_blame_options {
	uint version_ = GIT_BLAME_OPTIONS_VERSION;

	uint32_t flags;
	uint16_t min_match_characters;
	git_oid newest_commit;
	git_oid oldest_commit;
	size_t min_line;
	size_t max_line;
}

enum GIT_BLAME_OPTIONS_VERSION = 1;
enum git_blame_options GIT_BLAME_OPTIONS_INIT = {GIT_BLAME_OPTIONS_VERSION};

int git_blame_init_options(
       git_blame_options *opts,
       uint version_);


struct git_blame_hunk {
	size_t lines_in_hunk;

	git_oid final_commit_id;
	size_t final_start_line_number;
	git_signature *final_signature;

	git_oid orig_commit_id;
	const(char) *orig_path;
	size_t orig_start_line_number;
	git_signature *orig_signature;

	byte boundary;
}

struct git_blame {
	@disable this();
	@disable this(this);
}

uint32_t git_blame_get_hunk_count(git_blame *blame);
const(git_blame_hunk)* git_blame_get_hunk_byindex(git_blame *blame, uint32_t index);
const(git_blame_hunk)* git_blame_get_hunk_byline(git_blame *blame, size_t lineno);
int git_blame_file(git_blame **out_, git_repository *repo, const(char)* path, git_blame_options *options);
int git_blame_buffer(git_blame **out_, git_blame *reference, const(char)* buffer, size_t buffer_len);
void git_blame_free(git_blame *blame);
