"""Application-output boundary in the existing pipes; no stream/handle replacement."""
import json
import os
from pathlib import Path
import re
import secrets
import sys

class ApplicationOutput:
    def __init__(self,plan):self.prefix=Path(str(plan)+'.application')
    def __enter__(self):
        self.marker=('\nRECOMPYLER_APPLICATION_END_'+secrets.token_hex(24)+'\n').encode('ascii')
        return self
    def __exit__(self,exc_type,exc,tb):
        sys.stdout.flush();sys.stderr.flush()
        code=0 if exc_type is None else (exc.code if isinstance(exc,SystemExit) and type(exc.code) is int else 1)
        metadata=dict(marker=self.marker.decode('ascii'),exit_code=code,exception=None if exc_type is None or isinstance(exc,SystemExit) else exc_type.__name__)
        Path(str(self.prefix)+'.json').write_text(json.dumps(metadata),encoding='utf8')
        for fd in (1,2):os.write(fd,self.marker)

def extract(plan,profile_stem):
    prefix=Path(str(plan)+'.application');metadata=json.loads(Path(str(prefix)+'.json').read_text())
    marker=metadata['marker'].encode('ascii')
    for suffix in ('.stdout','.stderr'):
        data=Path(str(profile_stem)+suffix).read_bytes()
        before,found,after=data.partition(marker)
        if not found:raise RuntimeError('Missing application output boundary')
        Path(str(prefix)+suffix).write_bytes(before+after if suffix=='.stderr' and metadata['exit_code'] else before)
    return metadata

def stderr_class(data):
    text=data.decode('utf8',errors='replace')
    classes=sorted(set(re.findall(r'\b[A-Za-z_]\w*(?:Error|Warning|Exception)\b',text)))
    return classes or (['nonempty stderr'] if data else [])
