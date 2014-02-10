module deimos.git2.diff;

import deimos.git2.common;
import deimos.git2.oid;
import deimos.git2.refs;
import deimos.git2.strarray;
import deimos.git2.util;
import deimos.git2.tree;
import deimos.git2.types;

extern (C):

enum git_diff_option_t {
	GIT_DIFF_NORMAL = 0,
	GIT_DIFF_REVERSE = (1 << 0),
	GIT_DIFF_FORCE_TEXT = (1 << 1),
	GIT_DIFF_IGNORE_WHITESPACE = (1 << 2),
	GIT_DIFF_IGNORE_WHITESPACE_CHANGE = (1 << 3),
	GIT_DIFF_IGNORE_WHITESPACE_EOL = (1 << 4),
	GIT_DIFF_IGNORE_SUBMODULES = (1 << 5),
	GIT_DIFF_PATIENCE = (1 << 6),
	GIT_DIFF_INCLUDE_IGNORED = (1 << 7),
	GIT_DIFF_INCLUDE_UNTRACKED = (1 << 8),
	GIT_DIFF_INCLUDE_UNMODIFIED = (1 << 9),
	GIT_DIFF_RECURSE_UNTRACKED_DIRS = (1 << 10),
	GIT_DIFF_DISABLE_PATHSPEC_MATCH = (1 << 11),
	GIT_DIFF_DELTAS_ARE_ICASE = (1 << 12),
	GIT_DIFF_INCLUDE_UNTRACKED_CONTENT = (1 << 13),
	GIT_DIFF_SKIP_BINARY_CHECK = (1 << 14),
	GIT_DIFF_INCLUDE_TYPECHANGE = (1 << 15),
	GIT_DIFF_INCLUDE_TYPECHANGE_TREES  = (1 << 16),
	GIT_DIFF_IGNORE_FILEMODE = (1 << 17),
	GIT_DIFF_RECURSE_IGNORED_DIRS = (1 << 18),
	GIT_DIFF_FAST_UNTRACKED_DIRS = (1 << 19),
	GIT_DIFF_FORCE_BINARY = (1 << 20),
}
mixin _ExportEnumMembers!git_diff_option_t;

struct git_diff_list
{
    @disable this();
    @disable this(this);
}

enum git_diff_flag_t {
	GIT_DIFF_FLAG_BINARY     = (1 << 0),
	GIT_DIFF_FLAG_NOT_BINARY = (1 << 1),
	GIT_DIFF_FLAG_VALID_OID  = (1 << 2),
}
mixin _ExportEnumMembers!git_diff_flag_t;

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
mixin _ExportEnumMembers!git_delta_t;

struct git_diff_file {
	git_oid     oid;
	const(char)* path;
	git_off_t   size;
	uint32_t    flags;
	uint16_t    mode;
}

struct git_diff_delta {
	git_diff_file old_file;
	git_diff_file new_file;
	git_delta_t   status;
	uint32_t      similarity;
	uint32_t      flags;
}

alias git_diff_notify_cb = int function(
	const(git_diff_list)* diff_so_far,
	const(git_diff_delta)* delta_to_add,
	const(char)* matched_pathspec,
	void *payload);

struct git_diff_options {
	uint version_ = GIT_DIFF_OPTIONS_VERSION;
	uint32_t flags;
	uint16_t context_lines;
	uint16_t interhunk_lines;
	const(char)* old_prefix;
	const(char)* new_prefix;
	git_strarray pathspec;
	git_off_t max_size;
	git_diff_notify_cb notify_cb;
	void *notify_payload;
} ;

enum GIT_DIFF_OPTIONS_VERSION = 1;
enum git_diff_options GIT_DIFF_OPTIONS_INIT = { GIT_DIFF_OPTIONS_VERSION, GIT_DIFF_NORMAL, 3 };

alias git_diff_file_cb = int function(
	const(git_diff_delta)* delta,
	float progress,
	void *payload);

struct git_diff_range {
	int old_start;
	int old_lines;
	int new_start;
	int new_lines;
}

alias git_diff_hunk_cb = int function(
	const(git_diff_delta)* delta,
	const(git_diff_range)* range,
	const(char)* header,
	size_t header_len,
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
mixin _ExportEnumMembers!git_diff_line_t;

alias git_diff_data_cb = int function(
	const(git_diff_delta)* delta,
	const(git_diff_range)* range,
	char line_origin,
	const(char)* content,
	size_t content_len,
	void *payload);

struct git_diff_patch
{
    @disable this();
    @disable this(this);
}

enum git_diff_find_t {
	GIT_DIFF_FIND_RENAMES = (1 << 0),
	GIT_DIFF_FIND_RENAMES_FROM_REWRITES = (1 << 1),
	GIT_DIFF_FIND_COPIES = (1 << 2),
	GIT_DIFF_FIND_COPIES_FROM_UNMODIFIED = (1 << 3),
	GIT_DIFF_FIND_REWRITES = (1 << 4),
	GIT_DIFF_BREAK_REWRITES = (1 << 5),
	GIT_DIFF_FIND_AND_BREAK_REWRITES =
		(GIT_DIFF_FIND_REWRITES | GIT_DIFF_BREAK_REWRITES),
	GIT_DIFF_FIND_FOR_UNTRACKED = (1 << 6),
	GIT_DIFF_FIND_ALL = (0x0ff),
	GIT_DIFF_FIND_IGNORE_LEADING_WHITESPACE = 0,
	GIT_DIFF_FIND_IGNORE_WHITESPACE = (1 << 12),
	GIT_DIFF_FIND_DONT_IGNORE_WHITESPACE = (1 << 13),
	GIT_DIFF_FIND_EXACT_MATCH_ONLY = (1 << 14),
}
mixin _ExportEnumMembers!git_diff_find_t;

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
enum git_diff_find_options GIT_DIFF_FIND_OPTIONS_INIT = { GIT_DIFF_FIND_OPTIONS_VERSION };

void git_diff_list_free(git_diff_list *diff);
int git_diff_tree_to_tree(
	git_diff_list **diff,
	git_repository *repo,
	git_tree *old_tree,
	git_tree *new_tree,
	const(git_diff_options)* opts);
int git_diff_tree_to_index(
	git_diff_list **diff,
	git_repository *repo,
	git_tree *old_tree,
	git_index *index,
	const(git_diff_options)* opts);
int git_diff_index_to_workdir(
	git_diff_list **diff,
	git_repository *repo,
	git_index *index,
	const(git_diff_options)* opts);
int git_diff_tree_to_workdir(
	git_diff_list **diff,
	git_repository *repo,
	git_tree *old_tree,
	const(git_diff_options)* opts);
int git_diff_merge(
	git_diff_list *onto,
	const(git_diff_list)* from);
int git_diff_find_similar(
	git_diff_list *diff,
	git_diff_find_options *options);
int git_diff_foreach(
	git_diff_list *diff,
	git_diff_file_cb file_cb,
	git_diff_hunk_cb hunk_cb,
	git_diff_data_cb line_cb,
	void *payload);
int git_diff_print_compact(
	git_diff_list *diff,
	git_diff_data_cb print_cb,
	void *payload);
int git_diff_print_raw(
	git_diff_list *diff,
	git_diff_data_cb print_cb,
	void *payload);
char git_diff_status_char(git_delta_t status);
int git_diff_print_patch(
	git_diff_list *diff,
	git_diff_data_cb print_cb,
	void *payload);
size_t git_diff_num_deltas(git_diff_list *diff);
size_t git_diff_num_deltas_of_type(
	git_diff_list *diff,
	git_delta_t type);
int git_diff_get_patch(
	git_diff_patch **patch_out,
	const(git_diff_delta)** delta_out,
	git_diff_list *diff,
	size_t idx);
void git_diff_patch_free(
	git_diff_patch *patch);
const(git_diff_delta)*  git_diff_patch_delta(
	git_diff_patch *patch);
size_t git_diff_patch_num_hunks(
	git_diff_patch *patch);
int git_diff_patch_line_stats(
	size_t *total_context,
	size_t *total_additions,
	size_t *total_deletions,
	const(git_diff_patch)* patch);
int git_diff_patch_get_hunk(
	const(git_diff_range)** range,
	const(char)** header,
	size_t *header_len,
	size_t *lines_in_hunk,
	git_diff_patch *patch,
	size_t hunk_idx);
int git_diff_patch_num_lines_in_hunk(
	git_diff_patch *patch,
	size_t hunk_idx);
int git_diff_patch_get_line_in_hunk(
	char *line_origin,
	const(char)** content,
	size_t *content_len,
	int *old_lineno,
	int *new_lineno,
	git_diff_patch *patch,
	size_t hunk_idx,
	size_t line_of_hunk);
int git_diff_patch_print(
	git_diff_patch *patch,
	git_diff_data_cb print_cb,
	void *payload);
int git_diff_patch_to_str(
	char **string,
	git_diff_patch *patch);
int git_diff_blobs(
	const(git_blob)* old_blob,
	const(char)* old_as_path,
	const(git_blob)* new_blob,
	const(char)* new_as_path,
	const(git_diff_options)* options,
	git_diff_file_cb file_cb,
	git_diff_hunk_cb hunk_cb,
	git_diff_data_cb line_cb,
	void *payload);
int git_diff_patch_from_blobs(
	git_diff_patch **out_,
	const(git_blob)* old_blob,
	const(char)* old_as_path,
	const(git_blob)* new_blob,
	const(char)* new_as_path,
	const(git_diff_options)* opts);
int git_diff_blob_to_buffer(
	const(git_blob)* old_blob,
	const(char)* old_as_path,
	const(char)* buffer,
	size_t buffer_len,
	const(char)* buffer_as_path,
	const(git_diff_options)* options,
	git_diff_file_cb file_cb,
	git_diff_hunk_cb hunk_cb,
	git_diff_data_cb data_cb,
	void *payload);
int git_diff_patch_from_blob_and_buffer(
	git_diff_patch **out_,
	const(git_blob)* old_blob,
	const(char)* old_as_path,
	const(char)* buffer,
	size_t buffer_len,
	const(char)* buffer_as_path,
	const(git_diff_options)* opts);
