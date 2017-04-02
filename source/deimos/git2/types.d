module deimos.git2.types;

import deimos.git2.common;
import deimos.git2.util;
import std.conv;
import core.stdc.stdint;

extern (C):

alias int32_t = core.stdc.stdint.int32_t;
alias int64_t = core.stdc.stdint.int64_t;
alias uint16_t = core.stdc.stdint.uint16_t;
alias uint32_t = core.stdc.stdint.uint32_t;

alias off64_t = long;
alias __time64_t = long;
alias __int64 = long;
alias __haiku_std_int64 = long;

alias git_off_t = long;
alias git_time_t = long;

enum git_otype
{
	GIT_OBJ_ANY = -2,
	GIT_OBJ_BAD = -1,
	GIT_OBJ__EXT1 = 0,
	GIT_OBJ_COMMIT = 1,
	GIT_OBJ_TREE = 2,
	GIT_OBJ_BLOB = 3,
	GIT_OBJ_TAG = 4,
	GIT_OBJ__EXT2 = 5,
	GIT_OBJ_OFS_DELTA = 6,
	GIT_OBJ_REF_DELTA = 7,
}
mixin _ExportEnumMembers!git_otype;

struct git_odb
{
    @disable this();
    @disable this(this);
}

struct git_odb_object
{
    @disable this();
    @disable this(this);
}

struct git_refdb
{
    @disable this();
    @disable this(this);
}

struct git_repository
{
    @disable this();
    @disable this(this);
}

struct git_object
{
    @disable this();
    @disable this(this);
}

struct git_revwalk
{
    @disable this();
    @disable this(this);
}

struct git_tag
{
    @disable this();
    @disable this(this);
}

struct git_blob
{
    @disable this();
    @disable this(this);
}

struct git_commit
{
    @disable this();
    @disable this(this);
}

struct git_tree_entry
{
    @disable this();
    @disable this(this);
}

struct git_tree
{
    @disable this();
    @disable this(this);
}

struct git_treebuilder
{
    @disable this();
    @disable this(this);
}

struct git_index
{
    @disable this();
    @disable this(this);
}

struct git_index_conflict_iterator
{
    @disable this();
    @disable this(this);
}

struct git_config
{
    @disable this();
    @disable this(this);
}

struct git_reflog_entry
{
    @disable this();
    @disable this(this);
}

struct git_reflog
{
    @disable this();
    @disable this(this);
}

struct git_note
{
    @disable this();
    @disable this(this);
}

struct git_packbuilder
{
    @disable this();
    @disable this(this);
}

struct git_time
{
	git_time_t time;
	int offset;
}

struct git_signature
{
	char *name;
	char *email;
	git_time when;
}

struct git_cert
{
    git_cert_t cert_type;
}

struct git_reference
{
    @disable this();
    @disable this(this);
}

struct git_merge_head
{
    @disable this();
    @disable this(this);
}

struct git_merge_result
{
    @disable this();
    @disable this(this);
}

struct git_status_list
{
    @disable this();
    @disable this(this);
}

enum git_cert_t
{
    GIT_CERT_NONE,
    GIT_CERT_X509,
    GIT_CERT_HOSTKEY_LIBSSH2,
    GIT_CERT_STRARRAY,
}
mixin _ExportEnumMembers!git_cert_t;

enum git_ref_t
{
	GIT_REF_INVALID = 0,
	GIT_REF_OID = 1,
	GIT_REF_SYMBOLIC = 2,
	GIT_REF_LISTALL = GIT_REF_OID|GIT_REF_SYMBOLIC,
}
mixin _ExportEnumMembers!git_ref_t;

enum git_branch_t
{
	GIT_BRANCH_LOCAL = 1,
	GIT_BRANCH_REMOTE = 2,
}
mixin _ExportEnumMembers!git_branch_t;

enum git_filemode_t
{
	GIT_FILEMODE_NEW					= octal!0,
	GIT_FILEMODE_TREE					= octal!40000,
	GIT_FILEMODE_BLOB					= octal!100644,
	GIT_FILEMODE_BLOB_EXECUTABLE		= octal!100755,
	GIT_FILEMODE_LINK					= octal!120000,
	GIT_FILEMODE_COMMIT					= octal!160000,
}
mixin _ExportEnumMembers!git_filemode_t;

struct git_refspec
{
    @disable this();
    @disable this(this);
}

struct git_remote
{
    @disable this();
    @disable this(this);
}

struct git_push
{
    @disable this();
    @disable this(this);
}

struct git_transfer_progress
{
	uint total_objects;
	uint indexed_objects;
	uint received_objects;
    uint local_objects;
    uint total_deltas;
    uint indexed_deltas;
	size_t received_bytes;
}

alias git_transfer_progress_callback = int function(const(git_transfer_progress)* stats, void* payload);
alias git_transport_certificate_check_cb = int function(git_cert *cert, int valid, const(char) *host, void *payload);

struct git_submodule
{
    @disable this();
    @disable this(this);
}

enum git_submodule_update_t {
    GIT_SUBMODULE_UPDATE_RESET    = -1,

    GIT_SUBMODULE_UPDATE_CHECKOUT = 1,
    GIT_SUBMODULE_UPDATE_REBASE   = 2,
    GIT_SUBMODULE_UPDATE_MERGE    = 3,
    GIT_SUBMODULE_UPDATE_NONE     = 4,

    GIT_SUBMODULE_UPDATE_DEFAULT  = 0
}

enum git_submodule_ignore_t {
    GIT_SUBMODULE_IGNORE_RESET     = -1,

    GIT_SUBMODULE_IGNORE_NONE      = 1,
    GIT_SUBMODULE_IGNORE_UNTRACKED = 2,
    GIT_SUBMODULE_IGNORE_DIRTY     = 3,
    GIT_SUBMODULE_IGNORE_ALL       = 4,

    GIT_SUBMODULE_IGNORE_DEFAULT   = 0
}
