module git2.message;

import git2.common;

extern (C):

int git_message_prettify(
	char *out_,
	size_t out_size,
	const(char)* message,
	int strip_comments);
