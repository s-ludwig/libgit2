module deimos.git2.notes;

import deimos.git2.oid;
import deimos.git2.types;

extern (C):

alias git_note_foreach_cb = int function(
	const(git_oid)* blob_id, const(git_oid)* annotated_object_id, void *payload);

struct git_note_iterator
{
    @disable this();
    @disable this(this);
}

int git_note_iterator_new(
	git_note_iterator **out_,
	git_repository *repo,
	const(char)* notes_ref);
void git_note_iterator_free(git_note_iterator *it);
int git_note_next(
	git_oid* note_id,
	git_oid* annotated_id,
	git_note_iterator *it);
int git_note_read(
	git_note **out_,
	git_repository *repo,
	const(char)* notes_ref,
	const(git_oid)* oid);
const(char)*  git_note_message(const(git_note)* note);
const(git_oid)*  git_note_oid(const(git_note)* note);
int git_note_create(
	git_oid *out_,
	git_repository *repo,
	const(git_signature)* author,
	const(git_signature)* committer,
	const(char)* notes_ref,
	const(git_oid)* oid,
	const(char)* note,
	int force);
int git_note_remove(
	git_repository *repo,
	const(char)* notes_ref,
	const(git_signature)* author,
	const(git_signature)* committer,
	const(git_oid)* oid);
void git_note_free(git_note *note);
int git_note_default_ref(const(char)** out_, git_repository *repo);
int git_note_foreach(
	git_repository *repo,
	const(char)* notes_ref,
	git_note_foreach_cb note_cb,
	void *payload);
