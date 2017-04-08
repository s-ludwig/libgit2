module deimos.git2.remote;

import deimos.git2.buffer;
import deimos.git2.common;
import deimos.git2.indexer;
import deimos.git2.net;
import deimos.git2.oid;
import deimos.git2.pack;
import deimos.git2.push;
import deimos.git2.proxy;
import deimos.git2.refspec;
import deimos.git2.repository;
import deimos.git2.strarray;
import deimos.git2.util;
import deimos.git2.transport;
import deimos.git2.types;

extern (C):

int git_remote_create(
		git_remote **out_,
		git_repository *repo,
		const(char)* name,
		const(char)* url);
int git_remote_create_with_fetchspec(
		git_remote **out_,
		git_repository *repo,
		const(char)* name,
		const(char)* url,
		const(char)* fetch);
int git_remote_create_anonymous(
		git_remote **out_,
		git_repository *repo,
		const(char)* url);
int git_remote_lookup(git_remote **out_, git_repository* repo, const(char)* name);
int git_remote_dup(git_remote **dest, git_remote* source);
git_repository* git_remote_owner(const(git_remote)* remote);
const(char)*  git_remote_name(const(git_remote)* remote);
const(char)*  git_remote_url(const(git_remote)* remote);
const(char)*  git_remote_pushurl(const(git_remote)* remote);
int git_remote_set_url(git_repository* repo, const(char)* remote, const(char)* url);
int git_remote_set_pushurl(git_repository* repo, const(char)* remote, const(char)* url);
int git_remote_add_fetch(git_repository* repo, const(char)* remote, const(char)* refspec);
int git_remote_get_fetch_refspecs(git_strarray* array, const(git_remote)* remote);
int git_remote_add_push(git_repository* repo, const(char)* remote, const(char)* refspec);
int git_remote_get_push_refspecs(git_strarray* array, const(git_remote)* remote);
size_t git_remote_refspec_count(const(git_remote)* remote);
const(git_refspec)* git_remote_get_refspec(const(git_remote)* remote, size_t n);
int git_remote_connect(
	git_remote* remote,
	git_direction direction,
	const(git_remote_callbacks)* callbacks,
	const(git_proxy_options)* proxy_opts,
	const(git_strarray)* custom_headers);
int git_remote_ls(const(git_remote_head)*** out_,  size_t *size, git_remote *remote);
int git_remote_connected(const(git_remote)* remote);
void git_remote_stop(git_remote *remote);
void git_remote_disconnect(git_remote *remote);
void git_remote_free(git_remote *remote);
int git_remote_list(git_strarray *out_, git_repository *repo);

enum git_remote_completion_type {
	GIT_REMOTE_COMPLETION_DOWNLOAD,
	GIT_REMOTE_COMPLETION_INDEXING,
	GIT_REMOTE_COMPLETION_ERROR,
}
mixin _ExportEnumMembers!git_remote_completion_type;

alias git_push_transfer_progress = int function(
    uint current,
    uint total,
    size_t bytes,
    void* payload);

struct git_push_update {
    char* src_refname;
    char* dst_refname;
    git_oid src;
    git_oid dst;
}

alias git_push_negotiation = int function(const(git_push_update) **updates, size_t len, void* payload);

struct git_remote_callbacks {
	uint version_ = GIT_REMOTE_CALLBACKS_VERSION;
	git_transport_message_cb sideband_progress;
	int function(git_remote_completion_type type, void *data) completion;
	git_cred_acquire_cb credentials;
	git_transport_certificate_check_cb certificate_check;
	git_transfer_progress_cb transfer_progress;
	int function(const(char)* refname, const(git_oid)* a, const(git_oid)* b, void *data) update_tips;
	git_packbuilder_progress pack_progress;
    git_push_transfer_progress push_transfer_progress;
    int function(const(char)* refname, const(char)* status, void* data) push_update_reference;
	git_push_negotiation push_negotiation;
	git_transport_cb transport;
	void *payload;
}


int git_remote_init_callbacks(git_remote_callbacks *opts, uint version_);

enum git_fetch_prune_t {
    GIT_FETCH_PRUNE_UNSPECIFIED,
    GIT_FETCH_PRUNE,
    GIT_FETCH_NO_PRUNE,
}
mixin _ExportEnumMembers!git_fetch_prune_t;

enum git_remote_autotag_option_t {
    GIT_REMOTE_DOWNLOAD_TAGS_UNSPECIFIED = 0,
    GIT_REMOTE_DOWNLOAD_TAGS_AUTO,
    GIT_REMOTE_DOWNLOAD_TAGS_NONE,
    GIT_REMOTE_DOWNLOAD_TAGS_ALL,
}
mixin _ExportEnumMembers!git_remote_autotag_option_t;

struct git_fetch_options {
    int version_;
    git_remote_callbacks callbacks;
    git_fetch_prune_t prune;

    int update_fetchhead;

    git_remote_autotag_option_t download_tags;
    git_proxy_options proxy_opts;
    git_strarray custom_headers;
}
enum GIT_FETCH_OPTIONS_VERSION = 1;
enum git_fetch_options GIT_FETCH_OPTIONS_INIT = {
     GIT_FETCH_OPTIONS_VERSION,
     GIT_REMOTE_CALLBACKS_INIT,
     GIT_FETCH_PRUNE_UNSPECIFIED, 1,
     GIT_REMOTE_DOWNLOAD_TAGS_UNSPECIFIED,
     GIT_PROXY_OPTIONS_INIT
};

int git_push_init_options(
    git_push_options* opts,
    uint version_);

int git_remote_download(git_remote* remote, const(git_strarray)* refspecs, const(git_fetch_options)* opts);
int git_remote_upload(git_remote* remote, const(git_strarray)* refspecs, const(git_push_options)* opts);
int git_remote_update_tips(
    git_remote* remote,
    const(git_remote_callbacks)* callbacks,
    int update_fetchhead,
    git_remote_autotag_option_t download_tags,
    const(char)* reflog_message);

enum GIT_REMOTE_CALLBACKS_VERSION = 1;
enum git_remote_callbacks GIT_REMOTE_CALLBACKS_INIT = { GIT_REMOTE_CALLBACKS_VERSION };

int git_remote_fetch(
    git_remote* remote,
    const(git_strarray)* refspecs,
    const(git_fetch_options)* opts,
    const(char)* reflog_message);

int git_remote_prune(git_remote* remote, const(git_remote_callbacks)* callbacks);
int git_remote_push(git_remote* remote, const(git_strarray)* refspecs, const(git_push_options)* opts);


const(git_transfer_progress)*  git_remote_stats(git_remote *remote);

git_remote_autotag_option_t git_remote_autotag(const(git_remote)* remote);
int git_remote_set_autotag(git_repository* repo, const(char)* remote, git_remote_autotag_option_t value);
int git_remote_prune_refs(const(git_remote)* remote);
int git_remote_rename(
    git_strarray* problems,
    git_repository* repo,
    const(char)* name,
    const(char)* new_name);

int git_remote_is_valid_name(const(char)* remote_name);
int git_remote_delete(git_repository* repo, const(char)* name);
int git_remote_default_branch(git_buf* out_, git_remote* remote);
