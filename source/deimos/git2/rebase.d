module deimos.git2.rebase;

import deimos.git2.annotated_commit;
import deimos.git2.checkout;
import deimos.git2.common;
import deimos.git2.merge;
import deimos.git2.oid;
import deimos.git2.types;
import deimos.git2.util;


extern (C):

struct git_rebase_options {
    uint version_;
    int quiet;
    int inmemory;
    const(char)* rewrite_notes_ref;
    git_merge_options merge_options;
    git_checkout_options checkout_options;
}

enum git_rebase_operation_t {
    GIT_REBASE_OPERATION_PICK = 0,
    GIT_REBASE_OPERATION_REWORD,
    GIT_REBASE_OPERATION_EDIT,
    GIT_REBASE_OPERATION_SQUASH,
    GIT_REBASE_OPERATION_FIXUP,
    GIT_REBASE_OPERATION_EXEC,
}
mixin _ExportEnumMembers!git_rebase_operation_t;

enum GIT_REBASE_OPTIONS_VERSION = 1;
enum git_rebase_options GIT_REBASE_OPTIONS_INIT = {
    GIT_REBASE_OPTIONS_VERSION, 0, 0, NULL,
    GIT_MERGE_OPTIONS_INIT,
    GIT_CHECKOUT_OPTIONS_INIT
};

enum GIT_REBASE_NO_OPERATION = ulong.max;

struct git_rebase_operation {
    git_rebase_operation_t type;
    const git_oid id;
    const(char)* exec;
}

int git_rebase_init_options(
    git_rebase_options *opts,
    uint version_,
);

int git_rebase_init(
    git_rebase **out_,
    git_repository *repo,
    const(git_annotated_commit)* branch,
    const(git_annotated_commit)* upstream,
    const(git_annotated_commit)* onto,
    const(git_rebase_options)* opts,
);

int git_rebase_open(
    git_rebase **out_,
    git_repository *repo,
    const(git_rebase_options)* opts,
);

size_t git_rebase_operation_entrycount(git_rebase *rebase);
size_t git_rebase_operation_current(git_rebase *rebase);
git_rebase_operation* git_rebase_operation_byindex(
    git_rebase *rebase,
    size_t idx,
);
int git_rebase_next(git_rebase_operation **operation, git_rebase *rebase);
int git_rebase_inmemory_index(git_index **index, git_rebase *rebase);

int git_rebase_commit(
    git_oid *id,
    git_rebase *rebase,
    const(git_signature)* author,
    const(git_signature)* committer,
    const(char)* message_encoding,
    const(char)* message,
);

int git_rebase_abort(git_rebase *rebase);
int git_rebase_finish(git_rebase *rebase, const(git_signature)* signature);
void git_rebase_free(git_rebase *rebase);
