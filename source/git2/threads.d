module git2.threads;

import git2.common;

extern (C):

shared static this()
{
    git_threads_init();
}

shared static ~this()
{
    git_threads_shutdown();
}

int git_threads_init();
void git_threads_shutdown();
