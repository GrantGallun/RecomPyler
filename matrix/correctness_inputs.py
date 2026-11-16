"""Immutable per-attempt shared corpus snapshots for correctness consumers."""
import hashlib,json
from pathlib import Path
R=Path(__file__).resolve().parents[1]

def freeze_corpus(folder):
    target=folder/'corpus';target.mkdir()
    hashes={}
    for path in sorted((R.parent/'provenance-cases').iterdir()):
        if path.suffix not in ('.py','.json'):continue
        data=path.read_bytes();(target/path.name).write_bytes(data)
        hashes[path.name]=hashlib.sha256(data).hexdigest()
    (folder/'corpus-seal.json').write_text(json.dumps(hashes,indent=2))
    return target,hashes

def corpus_matches(target,hashes):
    current={p.name:hashlib.sha256(p.read_bytes()).hexdigest() for p in target.iterdir() if p.is_file()}
    return current==hashes
