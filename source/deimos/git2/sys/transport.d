module deimos.git2.sys.transport;

import deimos.git2.transport;
import deimos.git2.types;

extern (C):

int git_transport_smart_certificate_check(git_transport *transport, git_cert *cert, int valid, const(char)* hostname);
