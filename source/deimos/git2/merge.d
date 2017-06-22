module deimos.git2.merge;

import deimos.git2.annotated_commit;
import deimos.git2.common;
import deimos.git2.checkout;
import deimos.git2.diff;
import deimos.git2.index;
import deimos.git2.oid;
import deimos.git2.oidarray;
import deimos.git2.util;
import deimos.git2.types;

extern (C):

struct git_merge_file_input {
    uint version_;
    const(char)* ptr;
    size_t size;
    const(char)* path;
    uint mode;
}

enum GIT_MERGE_FILE_INPUT_VERSION = 1;
enum git_merge_file_input GIT_MERGE_FILE_INPUT_INIT = {GIT_MERGE_FILE_INPUT_VERSION};

int git_merge_file_init_input(git_merge_file_input* opts, uint version_);

enum git_merge_flag_t {
    GIT_MERGE_FIND_RENAMES = (1 << 0),
    GIT_MERGE_FAIL_ON_CONFLICT = (1 << 1),
    GIT_MERGE_SKIP_REUC = (1 << 2),
    GIT_MERGE_NO_RECURSIVE = (1 << 3),
}
mixin _ExportEnumMembers!git_merge_flag_t;

enum git_merge_file_favor_t {
    GIT_MERGE_FILE_FAVOR_NORMAL = 0,
    GIT_MERGE_FILE_FAVOR_OURS = 1,
    GIT_MERGE_FILE_FAVOR_THEIRS = 2,
    GIT_MERGE_FILE_FAVOR_UNION = 3,
}
mixin _ExportEnumMembers!git_merge_file_favor_t;

enum git_merge_file_flag_t {
    GIT_MERGE_FILE_DEFAULT = 0,
    GIT_MERGE_FILE_STYLE_MERGE = (1 << 0),
    GIT_MERGE_FILE_STYLE_DIFF3 = (1 << 1),
    GIT_MERGE_FILE_SIMPLIFY_ALNUM = (1 << 2),
    GIT_MERGE_FILE_IGNORE_WHITESPACE = (1 << 3),
    GIT_MERGE_FILE_IGNORE_WHITESPACE_CHANGE = (1 << 4),
    GIT_MERGE_FILE_IGNORE_WHITESPACE_EOL = (1 << 5),
    GIT_MERGE_FILE_DIFF_PATIENCE = (1 << 6),
    GIT_MERGE_FILE_DIFF_MINIMAL = (1 << 7),
}
mixin _ExportEnumMembers!git_merge_file_flag_t;
struct git_merge_file_options {
    uint version_;
    const(char)* ancestor_label;
    const(char)* our_label;
    const(char)* their_label;
    git_merge_file_favor_t favor;
    git_merge_file_flag_t flags;
}

enum GIT_MERGE_FILE_OPTIONS_VERSION = 1;
enum git_merge_file_options GIT_MERGE_FILE_OPTIONS_INIT = {GIT_MERGE_FILE_OPTIONS_VERSION};

int git_merge_file_init_options(git_merge_file_options* opts, uint version_);
struct git_merge_file_result {
    uint automergeable;
    const(char)* path;
    uint mode;
    const(char)* ptr;
    size_t len;
}

struct git_merge_options {
    uint version_;
    git_merge_flag_t flags;
    uint rename_threshold;
    uint target_limit;
    git_diff_similarity_metric* metric;
    uint recursion_limit;
    const(char)* default_driver;
    git_merge_file_favor_t file_favor;
    git_merge_file_flag_t file_flags;
}

enum GIT_MERGE_OPTIONS_VERSION = 1;
enum git_merge_options GIT_MERGE_OPTIONS_INIT = {GIT_MERGE_OPTIONS_VERSION};

int git_merge_init_options(git_merge_options *opts, uint version_);

enum git_merge_flags_t {
	GIT_MERGE_NO_FASTFORWARD      = 1,
	GIT_MERGE_FASTFORWARD_ONLY    = 2,
}

enum git_merge_analysis_t {
    GIT_MERGE_ANALYSIS_NONE = 0,
    GIT_MERGE_ANALYSIS_NORMAL = (1 << 0),
    GIT_MERGE_ANALYSIS_UP_TO_DATE = (1 << 1),
    GIT_MERGE_ANALYSIS_FASTFORWARD = (1 << 2),
    GIT_MERGE_ANALYSIS_UNBORN = (1 << 3),
}

enum git_merge_preference_t{
    GIT_MERGE_PREFERENCE_NONE = 0,
    GIT_MERGE_PREFERENCE_NO_FASTFORWARD = (1 << 0),
    GIT_MERGE_PREFERENCE_FASTFORWARD_ONLY = (1 << 1),
}

int git_merge_analysis(
    git_merge_analysis_t* analysis_out,
    git_merge_preference_t* preference_out,
    git_repository* repo,
    const(git_annotated_commit)** their_heads,
    size_t their_heads_len,
);


int git_merge_base(
	git_oid *out_,
	git_repository *repo,
	const(git_oid)* one,
	const(git_oid)* two);

int git_merge_bases(
	git_oidarray *out_,
    git_repository *repo,
    const(git_oid)* one,
    const(git_oid)* two);

int git_merge_base_many(
	git_oid *out_,
	git_repository *repo,
	size_t length,
	const(git_oid)* input_array);
int git_merge_bases_many(
    git_oidarray* out_,
    git_repository* repo,
    size_t length,
    const(git_oid)[] input_array);
int git_merge_base_octopus(
    git_oid* out_,
    git_repository* repo,
    size_t length,
    const(git_oid)[] input_array);
int git_merge_file(
    git_merge_file_result* out_,
    const(git_merge_file_input)* ancestor,
    const(git_merge_file_input)* ours,
    const(git_merge_file_input)* theirs,
    const(git_merge_file_options)* opts);
int git_merge_file_from_index(
    git_merge_file_result* out_,
    git_repository *repo,
    const(git_index_entry)* ancestor,
    const(git_index_entry)* ours,
    const(git_index_entry)* theirs,
    const(git_merge_file_options)* opts);

void git_merge_file_result_free(git_merge_file_result* result);

int git_merge_trees(
	git_index **out_,
	git_repository *repo,
	const(git_tree)* ancestor_tree,
	const(git_tree)* our_tree,
	const(git_tree)* their_tree,
	const(git_merge_options)* opts);
int git_merge_commits(
    git_index** out_,
    git_repository* repo,
    const(git_commit)* our_commit,
    const(git_commit)* their_commit,
    const(git_merge_options)* opts);

int git_merge(
    git_repository* repo,
    const(git_annotated_commit)** their_heads,
    size_t their_heads_len,
    const(git_merge_options)* merge_opts,
    const(git_checkout_options)* checkout_opts);
