module deimos.git2.message;

import deimos.git2.buffer;
import deimos.git2.common;

extern (C):

int git_message_prettify(git_buf* out_, const(char)* message, int strip_comments, char comment_char);
