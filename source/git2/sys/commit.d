module git2.sys.commit;

import git2.common;
import git2.oid;
import git2.types;

extern (C):

int git_commit_create_from_oids(
	git_oid *oid,
	git_repository *repo,
	const(char)* update_ref,
	const(git_signature)* author,
	const(git_signature)* committer,
	const(char)* message_encoding,
	const(char)* message,
	const(git_oid)* tree,
	int parent_count,
	const(git_oid)** parents);
