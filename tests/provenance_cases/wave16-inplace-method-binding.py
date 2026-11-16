"""Positive method-source queries needed by S46; these are analysis inputs.

MethodBindingTask.read corresponds to ordinary record-field reads in all eight
S46 methods. MethodBindingTask.qpkt is the original Richards source pattern:
shared source analysis must first bind these original methods before a typed
consumer can prove their effects and nonnumeric return-owner transfers.
CO_METHOD is installed CPython3.14 metadata, never permission to drop other
code/source/dependency checks. Unknown remains a decline.
"""
class MethodBindingTask:
    def read(self):
        return self.value

    def qpkt(self, pkt):
        t = self.findtcb(pkt.ident)
        taskWorkArea.qpktCount += 1
        pkt.link = None
        pkt.ident = self.ident
        return t.addPacket(pkt, self)

PROVENANCE_CASES = (
    {'function': 'MethodBindingTask.read', 'query': 'valid original method source binding then argument0.value origin', 'expected': 'source binding succeeds; typed field effects still consumer guarded', 'source_function': 'S46 ordinary object-field reads'},
    {'function': 'MethodBindingTask.qpkt', 'query': 'valid original method source binding before per-site call/store queries', 'expected': 'source binding succeeds; unknown calls remain conservative', 'source_function': 'richards_super Task.qpkt'},
)

def ordinary_field_control(value):
    """Same field-origin query as the method, without class-definition metadata."""
    return value.value
