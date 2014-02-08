module git2.signature;

import git2.common;
import git2.types;

extern (C):

int git_signature_new(git_signature **out_, const(char)* name, const(char)* email, git_time_t time, int offset);
int git_signature_now(git_signature **out_, const(char)* name, const(char)* email);
int git_signature_default(git_signature **out_, git_repository *repo);
git_signature * git_signature_dup(const(git_signature)* sig);
void git_signature_free(git_signature *sig);
