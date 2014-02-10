module deimos.git2.sys.refs;

import deimos.git2.common;
import deimos.git2.oid;
import deimos.git2.types;

extern (C):

git_reference * git_reference__alloc(
	const(char)* name,
	const(git_oid)* oid,
	const(git_oid)* peel);
git_reference * git_reference__alloc_symbolic(
	const(char)* name,
	const(char)* target);
