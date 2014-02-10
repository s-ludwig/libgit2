module deimos.git2.indexer;

import deimos.git2.common;
import deimos.git2.oid;
import deimos.git2.types;

extern (C):

struct git_indexer_stream
{
    @disable this();
    @disable this(this);
}

int git_indexer_stream_new(
		git_indexer_stream **out_,
		const(char)* path,
		git_transfer_progress_callback progress_cb,
		void *progress_cb_payload);
int git_indexer_stream_add(git_indexer_stream *idx, const(void)* data, size_t size, git_transfer_progress *stats);
int git_indexer_stream_finalize(git_indexer_stream *idx, git_transfer_progress *stats);
const(git_oid)*  git_indexer_stream_hash(const(git_indexer_stream)* idx);
void git_indexer_stream_free(git_indexer_stream *idx);
