module deimos.git2.sys.repository;

import deimos.git2.odb;
import deimos.git2.types;

extern (C):

int git_repository_new(git_repository **out_);
void git_repository__cleanup(git_repository *repo);
int git_repository_reinit_filesystem(
	git_repository *repo,
	int recurse_submodules);
void git_repository_set_config(git_repository *repo, git_config *config);
void git_repository_set_odb(git_repository *repo, git_odb *odb);
void git_repository_set_refdb(git_repository *repo, git_refdb *refdb);
void git_repository_set_index(git_repository *repo, git_index *index);
