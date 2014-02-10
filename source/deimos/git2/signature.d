module deimos.git2.signature;

import deimos.git2.common;
import deimos.git2.types;

extern (C):

int git_signature_new(git_signature **out_, const(char)* name, const(char)* email, git_time_t time, int offset);
int git_signature_now(git_signature **out_, const(char)* name, const(char)* email);
git_signature * git_signature_dup(const(git_signature)* sig);
void git_signature_free(git_signature *sig);
