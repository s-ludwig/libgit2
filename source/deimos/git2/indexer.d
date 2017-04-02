module deimos.git2.indexer;

import deimos.git2.common;
import deimos.git2.oid;
import deimos.git2.types;

extern (C):

struct git_indexer
{
    @disable this();
    @disable this(this);
}

int git_indexer_new(
		git_indexer **out_,
		const(char)* path,
		uint mode,
		git_odb *odb,
		git_transfer_progress_cb progress_cb,
		void *progress_cb_payload);
int git_indexer_append(git_indexer *idx, const(void)* data, size_t size, git_transfer_progress *stats);
int git_indexer_commit(git_indexer *idx, git_transfer_progress *stats);
const(git_oid)*  git_indexer_hash(const(git_indexer)* idx);
void git_indexer_free(git_indexer *idx);
