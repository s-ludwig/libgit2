module deimos.git2.oid;

import deimos.git2.common;
import deimos.git2.types;

extern (C):

enum GIT_OID_RAWSZ = 20;
enum GIT_OID_HEXSZ = (GIT_OID_RAWSZ * 2);
enum GIT_OID_MINPREFIXLEN = 4;

struct git_oid
{
	ubyte[GIT_OID_RAWSZ] id;
}

int git_oid_fromstr(git_oid *out_, const(char)* str);
int git_oid_fromstrp(git_oid *out_, const(char)* str);
int git_oid_fromstrn(git_oid *out_, const(char)* str, size_t length);
void git_oid_fromraw(git_oid *out_, const(ubyte)* raw);
void git_oid_fmt(char *out_, const(git_oid)* id);
void git_oid_nfmt(char *out_, size_t n, const(git_oid)* id);
void git_oid_pathfmt(char *out_, const(git_oid)* id);
char* git_oid_allocfmt(const(git_oid)* id);
char * git_oid_tostr(char *out_, size_t n, const(git_oid)* id);
void git_oid_cpy(git_oid *out_, const(git_oid)* src);
int git_oid_cmp(const(git_oid)* a, const(git_oid)* b);
int git_oid_equal(const(git_oid)* a, const(git_oid)* b)
{
	return !git_oid_cmp(a, b);
}
int git_oid_ncmp(const(git_oid)* a, const(git_oid)* b, size_t len);
int git_oid_streq(const(git_oid)* id, const(char)* str);
int git_oid_strcmp(const(git_oid)* id, const(char)* str);
int git_oid_iszero(const(git_oid)* id);

struct git_oid_shorten {
	@disable this();
	@disable this(this);
}

git_oid_shorten * git_oid_shorten_new(size_t min_length);
int git_oid_shorten_add(git_oid_shorten *os, const(char)* text_id);
void git_oid_shorten_free(git_oid_shorten *os);
