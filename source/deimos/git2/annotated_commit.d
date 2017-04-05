module deimos.git2.annotated_commit;

import deimos.git2.common;
import deimos.git2.oid;
import deimos.git2.repository;
import deimos.git2.types;

extern(C):

int git_annotated_commit_from_ref(
    git_annotated_commit **out_,
    git_repository *repo,
    const(git_reference)* ref_);

int git_annotated_commit_from_fetchhead(
    git_annotated_commit **out_,
    git_repository* repo,
    const(char)* branch_name,
    const(char)* remote_url,
    const(git_oid)* id);

int git_annotated_commit_lookup(
       git_annotated_commit **out_,
       git_repository *repo,
       const(git_oid)* id);

int git_annotated_commit_from_revspec(
       git_annotated_commit **out_,
       git_repository* repo,
       const(char)* revspec);

const(git_oid)* git_annotated_commit_id(
       const(git_annotated_commit)* commit);

void git_annotated_commit_free(
       git_annotated_commit* commit);
