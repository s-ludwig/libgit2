module deimos.git2.buffer;

import deimos.git2.common;

extern(C):

struct git_buf {
	char   *ptr = null;
	size_t asize = 0;
	size_t size = 0;

	this(char* mem, size_t len) { ptr = mem; size = len; }
}

void git_buf_free(git_buf *buffer);
int git_buf_grow(git_buf *buffer, size_t target_size);
int git_buf_set(git_buf *buffer, const(void)* data, size_t datalen);
int git_buf_is_binary(const(git_buf)* buf);
int git_buf_contains_nul(const(git_buf)* buf);
