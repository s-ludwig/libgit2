module deimos.git2.cred_helpers;

import deimos.git2.transport;

extern (C):

struct git_cred_userpass_payload {
	const(char)* username;
	const(char)* password;
}

int git_cred_userpass(
		git_cred **cred,
		const(char)* url,
		const(char)* user_from_url,
		uint allowed_types,
		void *payload);
