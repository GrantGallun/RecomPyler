"""Complete lexical operation; the default POSIX lexer never escapes."""
import shlex
LEXER = shlex.shlex

def token(text):
    return LEXER(text, posix=True).read_token()
