module git2.diff;

import git2.common;
import git2.types;
import git2.oid;
import git2.strarray;
import git2.tree;
import git2.refs;

extern(C):

enum git_diff_option_t {
	GIT_DIFF_NORMAL = 0,
	GIT_DIFF_REVERSE = (1u << 0),
	GIT_DIFF_INCLUDE_IGNORED = (1u << 1),
	GIT_DIFF_RECURSE_IGNORED_DIRS = (1u << 2),
	GIT_DIFF_INCLUDE_UNTRACKED = (1u << 3),
	GIT_DIFF_RECURSE_UNTRACKED_DIRS = (1u << 4),
	GIT_DIFF_INCLUDE_UNMODIFIED = (1u << 5),
	GIT_DIFF_INCLUDE_TYPECHANGE = (1u << 6),
	GIT_DIFF_INCLUDE_TYPECHANGE_TREES = (1u << 7),
	GIT_DIFF_IGNORE_FILEMODE = (1u << 8),
	GIT_DIFF_IGNORE_SUBMODULES = (1u << 9),
	GIT_DIFF_IGNORE_CASE = (1u << 10),
	GIT_DIFF_DISABLE_PATHSPEC_MATCH = (1u << 12),
	GIT_DIFF_SKIP_BINARY_CHECK = (1u << 13),
	GIT_DIFF_ENABLE_FAST_UNTRACKED_DIRS = (1u << 14),
	GIT_DIFF_FORCE_TEXT = (1u << 20),
	GIT_DIFF_FORCE_BINARY = (1u << 21),
	GIT_DIFF_IGNORE_WHITESPACE = (1u << 22),
	GIT_DIFF_IGNORE_WHITESPACE_CHANGE = (1u << 23),
	GIT_DIFF_IGNORE_WHITESPACE_EOL = (1u << 24),
	GIT_DIFF_SHOW_UNTRACKED_CONTENT = (1u << 25),
	GIT_DIFF_SHOW_UNMODIFIED = (1u << 26),
	GIT_DIFF_PATIENCE = (1u << 28),
	GIT_DIFF_MINIMAL = (1 << 29),
}

struct git_diff {
    @disable this();
    @disable this(this);
}

enum git_diff_flag_t {
	GIT_DIFF_FLAG_BINARY     = (1u << 0),
	GIT_DIFF_FLAG_NOT_BINARY = (1u << 1),
	GIT_DIFF_FLAG_VALID_OID  = (1u << 2),
}

enum git_delta_t {
	GIT_DELTA_UNMODIFIED = 0,
	GIT_DELTA_ADDED = 1,
	GIT_DELTA_DELETED = 2,
	GIT_DELTA_MODIFIED = 3,
	GIT_DELTA_RENAMED = 4,
	GIT_DELTA_COPIED = 5,
	GIT_DELTA_IGNORED = 6,
	GIT_DELTA_UNTRACKED = 7,
	GIT_DELTA_TYPECHANGE = 8,
}

struct git_diff_file {
	git_oid     oid;
	const(char)*path;
	git_off_t   size;
	uint32_t    flags;
	uint16_t    mode;
}

struct git_diff_delta {
	git_delta_t   status;
	uint32_t      flags;
	uint16_t      similarity;
	uint16_t      nfiles;
	git_diff_file old_file;
	git_diff_file new_file;
}

alias git_diff_notify_cb = int function(
	const(git_diff)* diff_so_far,
	const(git_diff_delta)* delta_to_add,
	const(char)* matched_pathspec,
	void *payload);

struct git_diff_options {
	uint version_ = GIT_DIFF_OPTIONS_VERSION;
	uint32_t flags;
	git_submodule_ignore_t ignore_submodules;
	git_strarray       pathspec;
	git_diff_notify_cb notify_cb;
	void              *notify_payload;
	uint16_t    context_lines = 3;
	uint16_t    interhunk_lines;
	uint16_t    oid_abbrev;
	git_off_t   max_size;
	const(char)* old_prefix;
	const(char)* new_prefix;
}

enum GIT_DIFF_OPTIONS_VERSION = 1;

enum git_diff_options GIT_DIFF_OPTIONS_INIT =
	{GIT_DIFF_OPTIONS_VERSION, 0, git_submodule_ignore_t.GIT_SUBMODULE_IGNORE_DEFAULT, {null,0}, null, null, 3};

alias git_diff_file_cb = int function(
	const(git_diff_delta)* delta,
	float progress,
	void *payload);

struct git_diff_hunk {
	int    old_start;
	int    old_lines;
	int    new_start;
	int    new_lines;
	size_t header_len;
	char[128] header;
}

alias git_diff_hunk_cb = int function(
	const(git_diff_delta)* delta,
	const(git_diff_hunk)* hunk,
	void *payload);

enum git_diff_line_t {
	GIT_DIFF_LINE_CONTEXT   = ' ',
	GIT_DIFF_LINE_ADDITION  = '+',
	GIT_DIFF_LINE_DELETION  = '-',
	GIT_DIFF_LINE_CONTEXT_EOFNL = '=',
	GIT_DIFF_LINE_ADD_EOFNL = '>',
	GIT_DIFF_LINE_DEL_EOFNL = '<',
	GIT_DIFF_LINE_FILE_HDR  = 'F',
	GIT_DIFF_LINE_HUNK_HDR  = 'H',
	GIT_DIFF_LINE_BINARY    = 'B'
}

struct git_diff_line {
	char   origin;
	int    old_lineno;
	int    new_lineno;
	int    num_lines;
	size_t content_len;
	git_off_t content_offset;
	const(char)* content;
}

alias git_diff_line_cb = int function(
	const(git_diff_delta)* delta,
	const(git_diff_hunk)* hunk,
	const(git_diff_line)* line,
	void *payload);

enum git_diff_find_t {
	GIT_DIFF_FIND_RENAMES = (1u << 0),
	GIT_DIFF_FIND_RENAMES_FROM_REWRITES = (1u << 1),
	GIT_DIFF_FIND_COPIES = (1u << 2),
	GIT_DIFF_FIND_COPIES_FROM_UNMODIFIED = (1u << 3),
	GIT_DIFF_FIND_REWRITES = (1u << 4),
	GIT_DIFF_BREAK_REWRITES = (1u << 5),
	GIT_DIFF_FIND_AND_BREAK_REWRITES =
		(GIT_DIFF_FIND_REWRITES | GIT_DIFF_BREAK_REWRITES),
	GIT_DIFF_FIND_FOR_UNTRACKED = (1u << 6),
	GIT_DIFF_FIND_ALL = (0x0ff),
	GIT_DIFF_FIND_IGNORE_LEADING_WHITESPACE = 0,
	GIT_DIFF_FIND_IGNORE_WHITESPACE = (1u << 12),
	GIT_DIFF_FIND_DONT_IGNORE_WHITESPACE = (1u << 13),
	GIT_DIFF_FIND_EXACT_MATCH_ONLY = (1u << 14),
	GIT_DIFF_BREAK_REWRITES_FOR_RENAMES_ONLY  = (1u << 15),
}

struct git_diff_similarity_metric {
	int function(
		void **out_, const(git_diff_file)* file,
		const(char)* fullpath, void *payload) file_signature;
	int function(
		void **out_, const(git_diff_file)* file,
		const(char)* buf, size_t buflen, void *payload) buffer_signature;
	void function(void *sig, void *payload) free_signature;
	int function(int *score, void *siga, void *sigb, void *payload) similarity;
	void *payload;
}

struct git_diff_find_options {
	uint version_ = GIT_DIFF_FIND_OPTIONS_VERSION;
	uint32_t flags;
	uint16_t rename_threshold;
	uint16_t rename_from_rewrite_threshold;
	uint16_t copy_threshold;
	uint16_t break_rewrite_threshold;
	size_t rename_limit;
	git_diff_similarity_metric *metric;
}

enum GIT_DIFF_FIND_OPTIONS_VERSION = 1;
enum git_diff_find_options GIT_DIFF_FIND_OPTIONS_INIT = {GIT_DIFF_FIND_OPTIONS_VERSION};

void git_diff_free(git_diff *diff);
int git_diff_tree_to_tree(
	git_diff **diff,
	git_repository *repo,
	git_tree *old_tree,
	git_tree *new_tree,
	const(git_diff_options)* opts);
int git_diff_tree_to_index(
	git_diff **diff,
	git_repository *repo,
	git_tree *old_tree,
	git_index *index,
	const(git_diff_options)* opts);
int git_diff_index_to_workdir(
	git_diff **diff,
	git_repository *repo,
	git_index *index,
	const(git_diff_options)* opts);
int git_diff_tree_to_workdir(
	git_diff **diff,
	git_repository *repo,
	git_tree *old_tree,
	const(git_diff_options)* opts);
int git_diff_tree_to_workdir_with_index(
	git_diff **diff,
	git_repository *repo,
	git_tree *old_tree,
	const(git_diff_options)* opts);
int git_diff_merge(
	git_diff *onto,
	const(git_diff)* from);
int git_diff_find_similar(
	git_diff *diff,
	const(git_diff_find_options)* options);
int git_diff_options_init(
	git_diff_options *options,
	uint version_);
size_t git_diff_num_deltas(const(git_diff)* diff);
size_t git_diff_num_deltas_of_type(
	const(git_diff)* diff, git_delta_t type);
const(git_diff_delta)* git_diff_get_delta(
	const(git_diff)* diff, size_t idx);
int git_diff_is_sorted_icase(const(git_diff)* diff);
int git_diff_foreach(
	git_diff *diff,
	git_diff_file_cb file_cb,
	git_diff_hunk_cb hunk_cb,
	git_diff_line_cb line_cb,
	void *payload);
char git_diff_status_char(git_delta_t status);

enum git_diff_format_t {
	GIT_DIFF_FORMAT_PATCH        = 1u,
	GIT_DIFF_FORMAT_PATCH_HEADER = 2u,
	GIT_DIFF_FORMAT_RAW          = 3u,
	GIT_DIFF_FORMAT_NAME_ONLY    = 4u,
	GIT_DIFF_FORMAT_NAME_STATUS  = 5u,
}

int git_diff_print(
	git_diff *diff,
	git_diff_format_t format,
	git_diff_line_cb print_cb,
	void *payload);
int git_diff_blobs(
	const(git_blob)* old_blob,
	const(char)* old_as_path,
	const(git_blob)* new_blob,
	const(char)* new_as_path,
	const(git_diff_options)* options,
	git_diff_file_cb file_cb,
	git_diff_hunk_cb hunk_cb,
	git_diff_line_cb line_cb,
	void *payload);
int git_diff_blob_to_buffer(
	const(git_blob)* old_blob,
	const(char)* old_as_path,
	const(char)* buffer,
	size_t buffer_len,
	const(char)* buffer_as_path,
	const(git_diff_options)* options,
	git_diff_file_cb file_cb,
	git_diff_hunk_cb hunk_cb,
	git_diff_line_cb line_cb,
	void *payload);
