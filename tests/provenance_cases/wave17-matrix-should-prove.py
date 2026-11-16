"""S52 positive consumer queries from unchanged original held-out modules.

Each CASES entry names the original function and required consumer query.
SOURCES retains whole original modules and their source hashes, preserving
class scopes, closures, evaluation order, and every unsupported construct.
These are desired proofs, not declarations of current support. Source origin
answers still require consumer type/layout/effect guards. No timings.
"""

SOURCES = {'richards_super': {'path': 'wave14-capture\\capture\\inputs\\richards_super\\run_benchmark.py',
                    'sha256': '665b3d5551171e147c127b6f8671edc9a7703c736d317cc4a991bb00f599dc36',
                    'text_sha256': '665b3d5551171e147c127b6f8671edc9a7703c736d317cc4a991bb00f599dc36',
                    'text': '"""\n'
                            'based on a Java version:\n'
                            ' Based on original version written in BCPL by Dr Martin Richards\n'
                            ' in 1981 at Cambridge University Computer Laboratory, England\n'
                            ' and a C++ version derived from a Smalltalk version written by\n'
                            ' L Peter Deutsch.\n'
                            ' Java version:  Copyright (C) 1995 Sun Microsystems, Inc.\n'
                            ' Translation from C++, Mario Wolczko\n'
                            ' Outer loop added by Alex Jacoby\n'
                            ' super() usage added by Carl Meyer\n'
                            '"""\n'
                            '\n'
                            'import pyperf\n'
                            '\n'
                            '\n'
                            '# Task IDs\n'
                            'I_IDLE = 1\n'
                            'I_WORK = 2\n'
                            'I_HANDLERA = 3\n'
                            'I_HANDLERB = 4\n'
                            'I_DEVA = 5\n'
                            'I_DEVB = 6\n'
                            '\n'
                            '# Packet types\n'
                            'K_DEV = 1000\n'
                            'K_WORK = 1001\n'
                            '\n'
                            '# Packet\n'
                            '\n'
                            'BUFSIZE = 4\n'
                            '\n'
                            'BUFSIZE_RANGE = range(BUFSIZE)\n'
                            '\n'
                            '\n'
                            'class Packet:\n'
                            '\n'
                            '    def __init__(self, l, i, k):\n'
                            '        self.link = l\n'
                            '        self.ident = i\n'
                            '        self.kind = k\n'
                            '        self.datum = 0\n'
                            '        self.data = [0] * BUFSIZE\n'
                            '\n'
                            '    def append_to(self, lst):\n'
                            '        self.link = None\n'
                            '        if lst is None:\n'
                            '            return self\n'
                            '        else:\n'
                            '            p = lst\n'
                            '            next = p.link\n'
                            '            while next is not None:\n'
                            '                p = next\n'
                            '                next = p.link\n'
                            '            p.link = self\n'
                            '            return lst\n'
                            '\n'
                            '# Task Records\n'
                            '\n'
                            '\n'
                            'class TaskRec:\n'
                            '    pass\n'
                            '\n'
                            '\n'
                            'class DeviceTaskRec(TaskRec):\n'
                            '\n'
                            '    def __init__(self):\n'
                            '        self.pending = None\n'
                            '\n'
                            '\n'
                            'class IdleTaskRec(TaskRec):\n'
                            '\n'
                            '    def __init__(self):\n'
                            '        self.control = 1\n'
                            '        self.count = 10000\n'
                            '\n'
                            '\n'
                            'class HandlerTaskRec(TaskRec):\n'
                            '\n'
                            '    def __init__(self):\n'
                            '        self.work_in = None\n'
                            '        self.device_in = None\n'
                            '\n'
                            '    def workInAdd(self, p):\n'
                            '        self.work_in = p.append_to(self.work_in)\n'
                            '        return self.work_in\n'
                            '\n'
                            '    def deviceInAdd(self, p):\n'
                            '        self.device_in = p.append_to(self.device_in)\n'
                            '        return self.device_in\n'
                            '\n'
                            '\n'
                            'class WorkerTaskRec(TaskRec):\n'
                            '\n'
                            '    def __init__(self):\n'
                            '        self.destination = I_HANDLERA\n'
                            '        self.count = 0\n'
                            '# Task\n'
                            '\n'
                            '\n'
                            'class TaskState:\n'
                            '\n'
                            '    def __init__(self):\n'
                            '        self.packet_pending = True\n'
                            '        self.task_waiting = False\n'
                            '        self.task_holding = False\n'
                            '\n'
                            '    def packetPending(self):\n'
                            '        self.packet_pending = True\n'
                            '        self.task_waiting = False\n'
                            '        self.task_holding = False\n'
                            '        return self\n'
                            '\n'
                            '    def waiting(self):\n'
                            '        self.packet_pending = False\n'
                            '        self.task_waiting = True\n'
                            '        self.task_holding = False\n'
                            '        return self\n'
                            '\n'
                            '    def running(self):\n'
                            '        self.packet_pending = False\n'
                            '        self.task_waiting = False\n'
                            '        self.task_holding = False\n'
                            '        return self\n'
                            '\n'
                            '    def waitingWithPacket(self):\n'
                            '        self.packet_pending = True\n'
                            '        self.task_waiting = True\n'
                            '        self.task_holding = False\n'
                            '        return self\n'
                            '\n'
                            '    def isPacketPending(self):\n'
                            '        return self.packet_pending\n'
                            '\n'
                            '    def isTaskWaiting(self):\n'
                            '        return self.task_waiting\n'
                            '\n'
                            '    def isTaskHolding(self):\n'
                            '        return self.task_holding\n'
                            '\n'
                            '    def isTaskHoldingOrWaiting(self):\n'
                            '        return self.task_holding or (not self.packet_pending and '
                            'self.task_waiting)\n'
                            '\n'
                            '    def isWaitingWithPacket(self):\n'
                            '        return self.packet_pending and self.task_waiting and not '
                            'self.task_holding\n'
                            '\n'
                            '\n'
                            'tracing = False\n'
                            'layout = 0\n'
                            '\n'
                            '\n'
                            'def trace(a):\n'
                            '    global layout\n'
                            '    layout -= 1\n'
                            '    if layout <= 0:\n'
                            '        print()\n'
                            '        layout = 50\n'
                            "    print(a, end='')\n"
                            '\n'
                            '\n'
                            'TASKTABSIZE = 10\n'
                            '\n'
                            '\n'
                            'class TaskWorkArea:\n'
                            '\n'
                            '    def __init__(self):\n'
                            '        self.taskTab = [None] * TASKTABSIZE\n'
                            '\n'
                            '        self.taskList = None\n'
                            '\n'
                            '        self.holdCount = 0\n'
                            '        self.qpktCount = 0\n'
                            '\n'
                            '\n'
                            'taskWorkArea = TaskWorkArea()\n'
                            '\n'
                            '\n'
                            'class Task(TaskState):\n'
                            '\n'
                            '    def __init__(self, i, p, w, initialState, r):\n'
                            '        self.link = taskWorkArea.taskList\n'
                            '        self.ident = i\n'
                            '        self.priority = p\n'
                            '        self.input = w\n'
                            '\n'
                            '        self.packet_pending = initialState.isPacketPending()\n'
                            '        self.task_waiting = initialState.isTaskWaiting()\n'
                            '        self.task_holding = initialState.isTaskHolding()\n'
                            '\n'
                            '        self.handle = r\n'
                            '\n'
                            '        taskWorkArea.taskList = self\n'
                            '        taskWorkArea.taskTab[i] = self\n'
                            '\n'
                            '        self.last_packet = None\n'
                            '\n'
                            '    def fn(self, pkt, r):\n'
                            '        self.last_packet = pkt\n'
                            '\n'
                            '    def addPacket(self, p, old):\n'
                            '        if self.input is None:\n'
                            '            self.input = p\n'
                            '            self.packet_pending = True\n'
                            '            if self.priority > old.priority:\n'
                            '                return self\n'
                            '        else:\n'
                            '            p.append_to(self.input)\n'
                            '        return old\n'
                            '\n'
                            '    def runTask(self):\n'
                            '        if self.isWaitingWithPacket():\n'
                            '            msg = self.input\n'
                            '            self.input = msg.link\n'
                            '            if self.input is None:\n'
                            '                self.running()\n'
                            '            else:\n'
                            '                self.packetPending()\n'
                            '        else:\n'
                            '            msg = None\n'
                            '\n'
                            '        return self.fn(msg, self.handle)\n'
                            '\n'
                            '    def waitTask(self):\n'
                            '        self.task_waiting = True\n'
                            '        return self\n'
                            '\n'
                            '    def hold(self):\n'
                            '        taskWorkArea.holdCount += 1\n'
                            '        self.task_holding = True\n'
                            '        return self.link\n'
                            '\n'
                            '    def release(self, i):\n'
                            '        t = self.findtcb(i)\n'
                            '        t.task_holding = False\n'
                            '        if t.priority > self.priority:\n'
                            '            return t\n'
                            '        else:\n'
                            '            return self\n'
                            '\n'
                            '    def qpkt(self, pkt):\n'
                            '        t = self.findtcb(pkt.ident)\n'
                            '        taskWorkArea.qpktCount += 1\n'
                            '        pkt.link = None\n'
                            '        pkt.ident = self.ident\n'
                            '        return t.addPacket(pkt, self)\n'
                            '\n'
                            '    def findtcb(self, id):\n'
                            '        t = taskWorkArea.taskTab[id]\n'
                            '        if t is None:\n'
                            '            raise Exception("Bad task id %d" % id)\n'
                            '        return t\n'
                            '\n'
                            '\n'
                            '# DeviceTask\n'
                            '\n'
                            '\n'
                            'class DeviceTask(Task):\n'
                            '\n'
                            '    def __init__(self, i, p, w, s, r):\n'
                            '        super().__init__(i, p, w, s, r)\n'
                            '\n'
                            '    def fn(self, pkt, r):\n'
                            '        d = r\n'
                            '        assert isinstance(d, DeviceTaskRec)\n'
                            '        super().fn(pkt, r)\n'
                            '        if pkt is None:\n'
                            '            pkt = d.pending\n'
                            '            if pkt is None:\n'
                            '                return self.waitTask()\n'
                            '            else:\n'
                            '                d.pending = None\n'
                            '                return self.qpkt(pkt)\n'
                            '        else:\n'
                            '            d.pending = pkt\n'
                            '            if tracing:\n'
                            '                trace(pkt.datum)\n'
                            '            return self.hold()\n'
                            '\n'
                            '\n'
                            'class HandlerTask(Task):\n'
                            '\n'
                            '    def __init__(self, i, p, w, s, r):\n'
                            '        super().__init__(i, p, w, s, r)\n'
                            '\n'
                            '    def fn(self, pkt, r):\n'
                            '        h = r\n'
                            '        assert isinstance(h, HandlerTaskRec)\n'
                            '        super().fn(pkt, r)\n'
                            '        if pkt is not None:\n'
                            '            if pkt.kind == K_WORK:\n'
                            '                h.workInAdd(pkt)\n'
                            '            else:\n'
                            '                h.deviceInAdd(pkt)\n'
                            '        work = h.work_in\n'
                            '        if work is None:\n'
                            '            return self.waitTask()\n'
                            '        count = work.datum\n'
                            '        if count >= BUFSIZE:\n'
                            '            h.work_in = work.link\n'
                            '            return self.qpkt(work)\n'
                            '\n'
                            '        dev = h.device_in\n'
                            '        if dev is None:\n'
                            '            return self.waitTask()\n'
                            '\n'
                            '        h.device_in = dev.link\n'
                            '        dev.datum = work.data[count]\n'
                            '        work.datum = count + 1\n'
                            '        return self.qpkt(dev)\n'
                            '\n'
                            '# IdleTask\n'
                            '\n'
                            '\n'
                            'class IdleTask(Task):\n'
                            '\n'
                            '    def __init__(self, i, p, w, s, r):\n'
                            '        super().__init__(i, 0, None, s, r)\n'
                            '\n'
                            '    def fn(self, pkt, r):\n'
                            '        i = r\n'
                            '        assert isinstance(i, IdleTaskRec)\n'
                            '        super().fn(pkt, r)\n'
                            '        i.count -= 1\n'
                            '        if i.count == 0:\n'
                            '            return self.hold()\n'
                            '        elif i.control & 1 == 0:\n'
                            '            i.control //= 2\n'
                            '            return self.release(I_DEVA)\n'
                            '        else:\n'
                            '            i.control = i.control // 2 ^ 0xd008\n'
                            '            return self.release(I_DEVB)\n'
                            '\n'
                            '\n'
                            '# WorkTask\n'
                            '\n'
                            '\n'
                            "A = ord('A')\n"
                            '\n'
                            '\n'
                            'class WorkTask(Task):\n'
                            '\n'
                            '    def __init__(self, i, p, w, s, r):\n'
                            '        super().__init__(i, p, w, s, r)\n'
                            '\n'
                            '    def fn(self, pkt, r):\n'
                            '        w = r\n'
                            '        assert isinstance(w, WorkerTaskRec)\n'
                            '        super().fn(pkt, r)\n'
                            '        if pkt is None:\n'
                            '            return self.waitTask()\n'
                            '\n'
                            '        if w.destination == I_HANDLERA:\n'
                            '            dest = I_HANDLERB\n'
                            '        else:\n'
                            '            dest = I_HANDLERA\n'
                            '\n'
                            '        w.destination = dest\n'
                            '        pkt.ident = dest\n'
                            '        pkt.datum = 0\n'
                            '\n'
                            '        for i in BUFSIZE_RANGE:  # range(BUFSIZE)\n'
                            '            w.count += 1\n'
                            '            if w.count > 26:\n'
                            '                w.count = 1\n'
                            '            pkt.data[i] = A + w.count - 1\n'
                            '\n'
                            '        return self.qpkt(pkt)\n'
                            '\n'
                            '\n'
                            'def schedule():\n'
                            '    t = taskWorkArea.taskList\n'
                            '    while t is not None:\n'
                            '        if tracing:\n'
                            '            print("tcb =", t.ident)\n'
                            '\n'
                            '        if t.isTaskHoldingOrWaiting():\n'
                            '            t = t.link\n'
                            '        else:\n'
                            '            if tracing:\n'
                            '                trace(chr(ord("0") + t.ident))\n'
                            '            t = t.runTask()\n'
                            '\n'
                            '\n'
                            'class Richards:\n'
                            '\n'
                            '    def run(self, iterations):\n'
                            '        for i in range(iterations):\n'
                            '            taskWorkArea.holdCount = 0\n'
                            '            taskWorkArea.qpktCount = 0\n'
                            '\n'
                            '            IdleTask(I_IDLE, 1, 10000, TaskState().running(), IdleTaskRec())\n'
                            '\n'
                            '            wkq = Packet(None, 0, K_WORK)\n'
                            '            wkq = Packet(wkq, 0, K_WORK)\n'
                            '            WorkTask(I_WORK, 1000, wkq, TaskState(\n'
                            '            ).waitingWithPacket(), WorkerTaskRec())\n'
                            '\n'
                            '            wkq = Packet(None, I_DEVA, K_DEV)\n'
                            '            wkq = Packet(wkq, I_DEVA, K_DEV)\n'
                            '            wkq = Packet(wkq, I_DEVA, K_DEV)\n'
                            '            HandlerTask(I_HANDLERA, 2000, wkq, TaskState(\n'
                            '            ).waitingWithPacket(), HandlerTaskRec())\n'
                            '\n'
                            '            wkq = Packet(None, I_DEVB, K_DEV)\n'
                            '            wkq = Packet(wkq, I_DEVB, K_DEV)\n'
                            '            wkq = Packet(wkq, I_DEVB, K_DEV)\n'
                            '            HandlerTask(I_HANDLERB, 3000, wkq, TaskState(\n'
                            '            ).waitingWithPacket(), HandlerTaskRec())\n'
                            '\n'
                            '            wkq = None\n'
                            '            DeviceTask(I_DEVA, 4000, wkq,\n'
                            '                       TaskState().waiting(), DeviceTaskRec())\n'
                            '            DeviceTask(I_DEVB, 5000, wkq,\n'
                            '                       TaskState().waiting(), DeviceTaskRec())\n'
                            '\n'
                            '            schedule()\n'
                            '\n'
                            '            if taskWorkArea.holdCount == 9297 and taskWorkArea.qpktCount == '
                            '23246:\n'
                            '                pass\n'
                            '            else:\n'
                            '                return False\n'
                            '\n'
                            '        return True\n'
                            '\n'
                            '\n'
                            'if __name__ == "__main__":\n'
                            '    runner = pyperf.Runner()\n'
                            '    runner.metadata[\'description\'] = "The Richards benchmark, with super()"\n'
                            '\n'
                            '    richard = Richards()\n'
                            "    runner.bench_func('richards_super', richard.run, 1)\n"},
 'hexiom': {'path': 'wave14-capture\\capture\\inputs\\hexiom\\run_benchmark.py',
            'sha256': 'd7518220380d27449b8951bc9ca2e19593569d9bd9f5cb6d86867f354f22e115',
            'text_sha256': 'd7518220380d27449b8951bc9ca2e19593569d9bd9f5cb6d86867f354f22e115',
            'text': '"""\n'
                    'Solver of Hexiom board game.\n'
                    '\n'
                    'Benchmark from Laurent Vaucher.\n'
                    '\n'
                    'Source: https://github.com/slowfrog/hexiom : hexiom2.py, level36.txt\n'
                    '\n'
                    '(Main function tweaked by Armin Rigo.)\n'
                    '"""\n'
                    '\n'
                    'import io\n'
                    '\n'
                    'import pyperf\n'
                    '\n'
                    '# 2016-07-07: CPython 3.6 takes ~25 ms to solve the board level 25\n'
                    'DEFAULT_LEVEL = 25\n'
                    '\n'
                    '\n'
                    '##################################\n'
                    'class Dir(object):\n'
                    '\n'
                    '    def __init__(self, x, y):\n'
                    '        self.x = x\n'
                    '        self.y = y\n'
                    '\n'
                    '\n'
                    'DIRS = [Dir(1, 0),\n'
                    '        Dir(-1, 0),\n'
                    '        Dir(0, 1),\n'
                    '        Dir(0, -1),\n'
                    '        Dir(1, 1),\n'
                    '        Dir(-1, -1)]\n'
                    '\n'
                    'EMPTY = 7\n'
                    '\n'
                    '##################################\n'
                    '\n'
                    '\n'
                    'class Done(object):\n'
                    '    MIN_CHOICE_STRATEGY = 0\n'
                    '    MAX_CHOICE_STRATEGY = 1\n'
                    '    HIGHEST_VALUE_STRATEGY = 2\n'
                    '    FIRST_STRATEGY = 3\n'
                    '    MAX_NEIGHBORS_STRATEGY = 4\n'
                    '    MIN_NEIGHBORS_STRATEGY = 5\n'
                    '\n'
                    '    def __init__(self, count, empty=False):\n'
                    '        self.count = count\n'
                    '        self.cells = None if empty else [\n'
                    '            [0, 1, 2, 3, 4, 5, 6, EMPTY] for i in range(count)]\n'
                    '\n'
                    '    def clone(self):\n'
                    '        ret = Done(self.count, True)\n'
                    '        ret.cells = [self.cells[i][:] for i in range(self.count)]\n'
                    '        return ret\n'
                    '\n'
                    '    def __getitem__(self, i):\n'
                    '        return self.cells[i]\n'
                    '\n'
                    '    def set_done(self, i, v):\n'
                    '        self.cells[i] = [v]\n'
                    '\n'
                    '    def already_done(self, i):\n'
                    '        return len(self.cells[i]) == 1\n'
                    '\n'
                    '    def remove(self, i, v):\n'
                    '        if v in self.cells[i]:\n'
                    '            self.cells[i].remove(v)\n'
                    '            return True\n'
                    '        else:\n'
                    '            return False\n'
                    '\n'
                    '    def remove_all(self, v):\n'
                    '        for i in range(self.count):\n'
                    '            self.remove(i, v)\n'
                    '\n'
                    '    def remove_unfixed(self, v):\n'
                    '        changed = False\n'
                    '        for i in range(self.count):\n'
                    '            if not self.already_done(i):\n'
                    '                if self.remove(i, v):\n'
                    '                    changed = True\n'
                    '        return changed\n'
                    '\n'
                    '    def filter_tiles(self, tiles):\n'
                    '        for v in range(8):\n'
                    '            if tiles[v] == 0:\n'
                    '                self.remove_all(v)\n'
                    '\n'
                    '    def next_cell_min_choice(self):\n'
                    '        minlen = 10\n'
                    '        mini = -1\n'
                    '        for i in range(self.count):\n'
                    '            if 1 < len(self.cells[i]) < minlen:\n'
                    '                minlen = len(self.cells[i])\n'
                    '                mini = i\n'
                    '        return mini\n'
                    '\n'
                    '    def next_cell_max_choice(self):\n'
                    '        maxlen = 1\n'
                    '        maxi = -1\n'
                    '        for i in range(self.count):\n'
                    '            if maxlen < len(self.cells[i]):\n'
                    '                maxlen = len(self.cells[i])\n'
                    '                maxi = i\n'
                    '        return maxi\n'
                    '\n'
                    '    def next_cell_highest_value(self):\n'
                    '        maxval = -1\n'
                    '        maxi = -1\n'
                    '        for i in range(self.count):\n'
                    '            if (not self.already_done(i)):\n'
                    '                maxvali = max(k for k in self.cells[i] if k != EMPTY)\n'
                    '                if maxval < maxvali:\n'
                    '                    maxval = maxvali\n'
                    '                    maxi = i\n'
                    '        return maxi\n'
                    '\n'
                    '    def next_cell_first(self):\n'
                    '        for i in range(self.count):\n'
                    '            if (not self.already_done(i)):\n'
                    '                return i\n'
                    '        return -1\n'
                    '\n'
                    '    def next_cell_max_neighbors(self, pos):\n'
                    '        maxn = -1\n'
                    '        maxi = -1\n'
                    '        for i in range(self.count):\n'
                    '            if not self.already_done(i):\n'
                    '                cells_around = pos.hex.get_by_id(i).links\n'
                    '                n = sum(1 if (self.already_done(nid) and (self[nid][0] != EMPTY)) else '
                    '0\n'
                    '                        for nid in cells_around)\n'
                    '                if n > maxn:\n'
                    '                    maxn = n\n'
                    '                    maxi = i\n'
                    '        return maxi\n'
                    '\n'
                    '    def next_cell_min_neighbors(self, pos):\n'
                    '        minn = 7\n'
                    '        mini = -1\n'
                    '        for i in range(self.count):\n'
                    '            if not self.already_done(i):\n'
                    '                cells_around = pos.hex.get_by_id(i).links\n'
                    '                n = sum(1 if (self.already_done(nid) and (self[nid][0] != EMPTY)) else '
                    '0\n'
                    '                        for nid in cells_around)\n'
                    '                if n < minn:\n'
                    '                    minn = n\n'
                    '                    mini = i\n'
                    '        return mini\n'
                    '\n'
                    '    def next_cell(self, pos, strategy=HIGHEST_VALUE_STRATEGY):\n'
                    '        if strategy == Done.HIGHEST_VALUE_STRATEGY:\n'
                    '            return self.next_cell_highest_value()\n'
                    '        elif strategy == Done.MIN_CHOICE_STRATEGY:\n'
                    '            return self.next_cell_min_choice()\n'
                    '        elif strategy == Done.MAX_CHOICE_STRATEGY:\n'
                    '            return self.next_cell_max_choice()\n'
                    '        elif strategy == Done.FIRST_STRATEGY:\n'
                    '            return self.next_cell_first()\n'
                    '        elif strategy == Done.MAX_NEIGHBORS_STRATEGY:\n'
                    '            return self.next_cell_max_neighbors(pos)\n'
                    '        elif strategy == Done.MIN_NEIGHBORS_STRATEGY:\n'
                    '            return self.next_cell_min_neighbors(pos)\n'
                    '        else:\n'
                    '            raise Exception("Wrong strategy: %d" % strategy)\n'
                    '\n'
                    '##################################\n'
                    '\n'
                    '\n'
                    'class Node(object):\n'
                    '\n'
                    '    def __init__(self, pos, id, links):\n'
                    '        self.pos = pos\n'
                    '        self.id = id\n'
                    '        self.links = links\n'
                    '\n'
                    '##################################\n'
                    '\n'
                    '\n'
                    'class Hex(object):\n'
                    '\n'
                    '    def __init__(self, size):\n'
                    '        self.size = size\n'
                    '        self.count = 3 * size * (size - 1) + 1\n'
                    '        self.nodes_by_id = self.count * [None]\n'
                    '        self.nodes_by_pos = {}\n'
                    '        id = 0\n'
                    '        for y in range(size):\n'
                    '            for x in range(size + y):\n'
                    '                pos = (x, y)\n'
                    '                node = Node(pos, id, [])\n'
                    '                self.nodes_by_pos[pos] = node\n'
                    '                self.nodes_by_id[node.id] = node\n'
                    '                id += 1\n'
                    '        for y in range(1, size):\n'
                    '            for x in range(y, size * 2 - 1):\n'
                    '                ry = size + y - 1\n'
                    '                pos = (x, ry)\n'
                    '                node = Node(pos, id, [])\n'
                    '                self.nodes_by_pos[pos] = node\n'
                    '                self.nodes_by_id[node.id] = node\n'
                    '                id += 1\n'
                    '\n'
                    '    def link_nodes(self):\n'
                    '        for node in self.nodes_by_id:\n'
                    '            (x, y) = node.pos\n'
                    '            for dir in DIRS:\n'
                    '                nx = x + dir.x\n'
                    '                ny = y + dir.y\n'
                    '                if self.contains_pos((nx, ny)):\n'
                    '                    node.links.append(self.nodes_by_pos[(nx, ny)].id)\n'
                    '\n'
                    '    def contains_pos(self, pos):\n'
                    '        return pos in self.nodes_by_pos\n'
                    '\n'
                    '    def get_by_pos(self, pos):\n'
                    '        return self.nodes_by_pos[pos]\n'
                    '\n'
                    '    def get_by_id(self, id):\n'
                    '        return self.nodes_by_id[id]\n'
                    '\n'
                    '\n'
                    '##################################\n'
                    'class Pos(object):\n'
                    '\n'
                    '    def __init__(self, hex, tiles, done=None):\n'
                    '        self.hex = hex\n'
                    '        self.tiles = tiles\n'
                    '        self.done = Done(hex.count) if done is None else done\n'
                    '\n'
                    '    def clone(self):\n'
                    '        return Pos(self.hex, self.tiles, self.done.clone())\n'
                    '\n'
                    '##################################\n'
                    '\n'
                    '\n'
                    'def constraint_pass(pos, last_move=None):\n'
                    '    changed = False\n'
                    '    left = pos.tiles[:]\n'
                    '    done = pos.done\n'
                    '\n'
                    '    # Remove impossible values from free cells\n'
                    '    free_cells = (range(done.count) if last_move is None\n'
                    '                  else pos.hex.get_by_id(last_move).links)\n'
                    '    for i in free_cells:\n'
                    '        if not done.already_done(i):\n'
                    '            vmax = 0\n'
                    '            vmin = 0\n'
                    '            cells_around = pos.hex.get_by_id(i).links\n'
                    '            for nid in cells_around:\n'
                    '                if done.already_done(nid):\n'
                    '                    if done[nid][0] != EMPTY:\n'
                    '                        vmin += 1\n'
                    '                        vmax += 1\n'
                    '                else:\n'
                    '                    vmax += 1\n'
                    '\n'
                    '            for num in range(7):\n'
                    '                if (num < vmin) or (num > vmax):\n'
                    '                    if done.remove(i, num):\n'
                    '                        changed = True\n'
                    '\n'
                    '    # Computes how many of each value is still free\n'
                    '    for cell in done.cells:\n'
                    '        if len(cell) == 1:\n'
                    '            left[cell[0]] -= 1\n'
                    '\n'
                    '    for v in range(8):\n'
                    '        # If there is none, remove the possibility from all tiles\n'
                    '        if (pos.tiles[v] > 0) and (left[v] == 0):\n'
                    '            if done.remove_unfixed(v):\n'
                    '                changed = True\n'
                    '        else:\n'
                    '            possible = sum((1 if v in cell else 0) for cell in done.cells)\n'
                    '            # If the number of possible cells for a value is exactly the number of '
                    'available tiles\n'
                    '            # put a tile in each cell\n'
                    '            if pos.tiles[v] == possible:\n'
                    '                for i in range(done.count):\n'
                    '                    cell = done.cells[i]\n'
                    '                    if (not done.already_done(i)) and (v in cell):\n'
                    '                        done.set_done(i, v)\n'
                    '                        changed = True\n'
                    '\n'
                    '    # Force empty or non-empty around filled cells\n'
                    '    filled_cells = (range(done.count) if last_move is None\n'
                    '                    else [last_move])\n'
                    '    for i in filled_cells:\n'
                    '        if done.already_done(i):\n'
                    '            num = done[i][0]\n'
                    '            empties = 0\n'
                    '            filled = 0\n'
                    '            unknown = []\n'
                    '            cells_around = pos.hex.get_by_id(i).links\n'
                    '            for nid in cells_around:\n'
                    '                if done.already_done(nid):\n'
                    '                    if done[nid][0] == EMPTY:\n'
                    '                        empties += 1\n'
                    '                    else:\n'
                    '                        filled += 1\n'
                    '                else:\n'
                    '                    unknown.append(nid)\n'
                    '            if len(unknown) > 0:\n'
                    '                if num == filled:\n'
                    '                    for u in unknown:\n'
                    '                        if EMPTY in done[u]:\n'
                    '                            done.set_done(u, EMPTY)\n'
                    '                            changed = True\n'
                    '                        # else:\n'
                    '                        #    raise Exception("Houston, we\'ve got a problem")\n'
                    '                elif num == filled + len(unknown):\n'
                    '                    for u in unknown:\n'
                    '                        if done.remove(u, EMPTY):\n'
                    '                            changed = True\n'
                    '\n'
                    '    return changed\n'
                    '\n'
                    '\n'
                    'ASCENDING = 1\n'
                    'DESCENDING = -1\n'
                    '\n'
                    '\n'
                    'def find_moves(pos, strategy, order):\n'
                    '    done = pos.done\n'
                    '    cell_id = done.next_cell(pos, strategy)\n'
                    '    if cell_id < 0:\n'
                    '        return []\n'
                    '\n'
                    '    if order == ASCENDING:\n'
                    '        return [(cell_id, v) for v in done[cell_id]]\n'
                    '    else:\n'
                    '        # Try higher values first and EMPTY last\n'
                    '        moves = list(reversed([(cell_id, v)\n'
                    '                               for v in done[cell_id] if v != EMPTY]))\n'
                    '        if EMPTY in done[cell_id]:\n'
                    '            moves.append((cell_id, EMPTY))\n'
                    '        return moves\n'
                    '\n'
                    '\n'
                    'def play_move(pos, move):\n'
                    '    (cell_id, i) = move\n'
                    '    pos.done.set_done(cell_id, i)\n'
                    '\n'
                    '\n'
                    'def print_pos(pos, output):\n'
                    '    hex = pos.hex\n'
                    '    done = pos.done\n'
                    '    size = hex.size\n'
                    '    for y in range(size):\n'
                    '        print(" " * (size - y - 1), end="", file=output)\n'
                    '        for x in range(size + y):\n'
                    '            pos2 = (x, y)\n'
                    '            id = hex.get_by_pos(pos2).id\n'
                    '            if done.already_done(id):\n'
                    '                c = str(done[id][0]) if done[id][0] != EMPTY else "."\n'
                    '            else:\n'
                    '                c = "?"\n'
                    '            print("%s " % c, end="", file=output)\n'
                    '        print(end="\\n", file=output)\n'
                    '    for y in range(1, size):\n'
                    '        print(" " * y, end="", file=output)\n'
                    '        for x in range(y, size * 2 - 1):\n'
                    '            ry = size + y - 1\n'
                    '            pos2 = (x, ry)\n'
                    '            id = hex.get_by_pos(pos2).id\n'
                    '            if done.already_done(id):\n'
                    '                c = str(done[id][0]) if done[id][0] != EMPTY else "."\n'
                    '            else:\n'
                    '                c = "?"\n'
                    '            print("%s " % c, end="", file=output)\n'
                    '        print(end="\\n", file=output)\n'
                    '\n'
                    '\n'
                    'OPEN = 0\n'
                    'SOLVED = 1\n'
                    'IMPOSSIBLE = -1\n'
                    '\n'
                    '\n'
                    'def solved(pos, output, verbose=False):\n'
                    '    hex = pos.hex\n'
                    '    tiles = pos.tiles[:]\n'
                    '    done = pos.done\n'
                    '    exact = True\n'
                    '    all_done = True\n'
                    '    for i in range(hex.count):\n'
                    '        if len(done[i]) == 0:\n'
                    '            return IMPOSSIBLE\n'
                    '        elif done.already_done(i):\n'
                    '            num = done[i][0]\n'
                    '            tiles[num] -= 1\n'
                    '            if (tiles[num] < 0):\n'
                    '                return IMPOSSIBLE\n'
                    '            vmax = 0\n'
                    '            vmin = 0\n'
                    '            if num != EMPTY:\n'
                    '                cells_around = hex.get_by_id(i).links\n'
                    '                for nid in cells_around:\n'
                    '                    if done.already_done(nid):\n'
                    '                        if done[nid][0] != EMPTY:\n'
                    '                            vmin += 1\n'
                    '                            vmax += 1\n'
                    '                    else:\n'
                    '                        vmax += 1\n'
                    '\n'
                    '                if (num < vmin) or (num > vmax):\n'
                    '                    return IMPOSSIBLE\n'
                    '                if num != vmin:\n'
                    '                    exact = False\n'
                    '        else:\n'
                    '            all_done = False\n'
                    '\n'
                    '    if (not all_done) or (not exact):\n'
                    '        return OPEN\n'
                    '\n'
                    '    print_pos(pos, output)\n'
                    '    return SOLVED\n'
                    '\n'
                    '\n'
                    'def solve_step(prev, strategy, order, output, first=False):\n'
                    '    if first:\n'
                    '        pos = prev.clone()\n'
                    '        while constraint_pass(pos):\n'
                    '            pass\n'
                    '    else:\n'
                    '        pos = prev\n'
                    '\n'
                    '    moves = find_moves(pos, strategy, order)\n'
                    '    if len(moves) == 0:\n'
                    '        return solved(pos, output)\n'
                    '    else:\n'
                    '        for move in moves:\n'
                    '            # print("Trying (%d, %d)" % (move[0], move[1]))\n'
                    '            ret = OPEN\n'
                    '            new_pos = pos.clone()\n'
                    '            play_move(new_pos, move)\n'
                    '            # print_pos(new_pos)\n'
                    '            while constraint_pass(new_pos, move[0]):\n'
                    '                pass\n'
                    '            cur_status = solved(new_pos, output)\n'
                    '            if cur_status != OPEN:\n'
                    '                ret = cur_status\n'
                    '            else:\n'
                    '                ret = solve_step(new_pos, strategy, order, output)\n'
                    '            if ret == SOLVED:\n'
                    '                return SOLVED\n'
                    '    return IMPOSSIBLE\n'
                    '\n'
                    '\n'
                    'def check_valid(pos):\n'
                    '    hex = pos.hex\n'
                    '    tiles = pos.tiles\n'
                    '    # fill missing entries in tiles\n'
                    '    tot = 0\n'
                    '    for i in range(8):\n'
                    '        if tiles[i] > 0:\n'
                    '            tot += tiles[i]\n'
                    '        else:\n'
                    '            tiles[i] = 0\n'
                    '    # check total\n'
                    '    if tot != hex.count:\n'
                    '        raise Exception(\n'
                    '            "Invalid input. Expected %d tiles, got %d." % (hex.count, tot))\n'
                    '\n'
                    '\n'
                    'def solve(pos, strategy, order, output):\n'
                    '    check_valid(pos)\n'
                    '    return solve_step(pos, strategy, order, output, first=True)\n'
                    '\n'
                    '\n'
                    "# TODO Write an 'iterator' to go over all x,y positions\n"
                    '\n'
                    'def read_file(file):\n'
                    '    lines = [line.strip("\\r\\n") for line in file.splitlines()]\n'
                    '    size = int(lines[0])\n'
                    '    hex = Hex(size)\n'
                    '    linei = 1\n'
                    '    tiles = 8 * [0]\n'
                    '    done = Done(hex.count)\n'
                    '    for y in range(size):\n'
                    '        line = lines[linei][size - y - 1:]\n'
                    '        p = 0\n'
                    '        for x in range(size + y):\n'
                    '            tile = line[p:p + 2]\n'
                    '            p += 2\n'
                    '            if tile[1] == ".":\n'
                    '                inctile = EMPTY\n'
                    '            else:\n'
                    '                inctile = int(tile)\n'
                    '            tiles[inctile] += 1\n'
                    '            # Look for locked tiles\n'
                    '            if tile[0] == "+":\n'
                    '                # print("Adding locked tile: %d at pos %d, %d, id=%d" %\n'
                    '                #      (inctile, x, y, hex.get_by_pos((x, y)).id))\n'
                    '                done.set_done(hex.get_by_pos((x, y)).id, inctile)\n'
                    '\n'
                    '        linei += 1\n'
                    '    for y in range(1, size):\n'
                    '        ry = size - 1 + y\n'
                    '        line = lines[linei][y:]\n'
                    '        p = 0\n'
                    '        for x in range(y, size * 2 - 1):\n'
                    '            tile = line[p:p + 2]\n'
                    '            p += 2\n'
                    '            if tile[1] == ".":\n'
                    '                inctile = EMPTY\n'
                    '            else:\n'
                    '                inctile = int(tile)\n'
                    '            tiles[inctile] += 1\n'
                    '            # Look for locked tiles\n'
                    '            if tile[0] == "+":\n'
                    '                # print("Adding locked tile: %d at pos %d, %d, id=%d" %\n'
                    '                #      (inctile, x, ry, hex.get_by_pos((x, ry)).id))\n'
                    '                done.set_done(hex.get_by_pos((x, ry)).id, inctile)\n'
                    '        linei += 1\n'
                    '    hex.link_nodes()\n'
                    '    done.filter_tiles(tiles)\n'
                    '    return Pos(hex, tiles, done)\n'
                    '\n'
                    '\n'
                    'def solve_file(file, strategy, order, output):\n'
                    '    pos = read_file(file)\n'
                    '    solve(pos, strategy, order, output)\n'
                    '\n'
                    '\n'
                    'LEVELS = {}\n'
                    '\n'
                    'LEVELS[2] = ("""\n'
                    '2\n'
                    '  . 1\n'
                    ' . 1 1\n'
                    '  1 .\n'
                    '""", """\\\n'
                    ' 1 1\n'
                    '. . .\n'
                    ' 1 1\n'
                    '""")\n'
                    '\n'
                    'LEVELS[10] = ("""\n'
                    '3\n'
                    '  +.+. .\n'
                    ' +. 0 . 2\n'
                    ' . 1+2 1 .\n'
                    '  2 . 0+.\n'
                    '   .+.+.\n'
                    '""", """\\\n'
                    '  . . 1\n'
                    ' . 1 . 2\n'
                    '0 . 2 2 .\n'
                    ' . . . .\n'
                    '  0 . .\n'
                    '""")\n'
                    '\n'
                    'LEVELS[20] = ("""\n'
                    '3\n'
                    '   . 5 4\n'
                    '  . 2+.+1\n'
                    ' . 3+2 3 .\n'
                    ' +2+. 5 .\n'
                    '   . 3 .\n'
                    '""", """\\\n'
                    '  3 3 2\n'
                    ' 4 5 . 1\n'
                    '3 5 2 . .\n'
                    ' 2 . . .\n'
                    '  . . .\n'
                    '""")\n'
                    '\n'
                    'LEVELS[25] = ("""\n'
                    '3\n'
                    '   4 . .\n'
                    '  . . 2 .\n'
                    ' 4 3 2 . 4\n'
                    '  2 2 3 .\n'
                    '   4 2 4\n'
                    '""", """\\\n'
                    '  3 4 2\n'
                    ' 2 4 4 .\n'
                    '. . . 4 2\n'
                    ' . 2 4 3\n'
                    '  . 2 .\n'
                    '""")\n'
                    '\n'
                    'LEVELS[30] = ("""\n'
                    '4\n'
                    '    5 5 . .\n'
                    '   3 . 2+2 6\n'
                    '  3 . 2 . 5 .\n'
                    ' . 3 3+4 4 . 3\n'
                    '  4 5 4 . 5 4\n'
                    '   5+2 . . 3\n'
                    '    4 . . .\n'
                    '""", """\\\n'
                    '   3 4 3 .\n'
                    '  4 6 5 2 .\n'
                    ' 2 5 5 . . 2\n'
                    '. . 5 4 . 4 3\n'
                    ' . 3 5 4 5 4\n'
                    '  . 2 . 3 3\n'
                    '   . . . .\n'
                    '""")\n'
                    '\n'
                    'LEVELS[36] = ("""\n'
                    '4\n'
                    '    2 1 1 2\n'
                    '   3 3 3 . .\n'
                    '  2 3 3 . 4 .\n'
                    ' . 2 . 2 4 3 2\n'
                    '  2 2 . . . 2\n'
                    '   4 3 4 . .\n'
                    '    3 2 3 3\n'
                    '""", """\\\n'
                    '   3 4 3 2\n'
                    '  3 4 4 . 3\n'
                    ' 2 . . 3 4 3\n'
                    '2 . 1 . 3 . 2\n'
                    ' 3 3 . 2 . 2\n'
                    '  3 . 2 . 2\n'
                    '   2 2 . 1\n'
                    '""")\n'
                    '\n'
                    '\n'
                    'def main(loops, level):\n'
                    '    board, solution = LEVELS[level]\n'
                    '    order = DESCENDING\n'
                    '    strategy = Done.FIRST_STRATEGY\n'
                    '    stream = io.StringIO()\n'
                    '\n'
                    '    board = board.strip()\n'
                    '    expected = solution.rstrip()\n'
                    '\n'
                    '    range_it = range(loops)\n'
                    '    t0 = pyperf.perf_counter()\n'
                    '\n'
                    '    for _ in range_it:\n'
                    '        stream = io.StringIO()\n'
                    '        solve_file(board, strategy, order, stream)\n'
                    '        output = stream.getvalue()\n'
                    '        stream = None\n'
                    '\n'
                    '    dt = pyperf.perf_counter() - t0\n'
                    '\n'
                    "    output = '\\n'.join(line.rstrip() for line in output.splitlines())\n"
                    '    if output != expected:\n'
                    '        raise AssertionError("got a wrong answer:\\n%s\\nexpected: %s"\n'
                    '                             % (output, expected))\n'
                    '\n'
                    '    return dt\n'
                    '\n'
                    '\n'
                    'def add_cmdline_args(cmd, args):\n'
                    '    cmd.extend(("--level", str(args.level)))\n'
                    '\n'
                    '\n'
                    'if __name__ == "__main__":\n'
                    '    runner = pyperf.Runner(add_cmdline_args=add_cmdline_args)\n'
                    '    levels = sorted(LEVELS)\n'
                    '    runner.argparser.add_argument("--level", type=int,\n'
                    '                                  choices=levels,\n'
                    '                                  default=DEFAULT_LEVEL,\n'
                    '                                  help="Hexiom board level (default: %s)"\n'
                    '                                       % DEFAULT_LEVEL)\n'
                    '\n'
                    '    args = runner.parse_args()\n'
                    '    runner.metadata[\'description\'] = "Solver of Hexiom board game"\n'
                    "    runner.metadata['hexiom_level'] = args.level\n"
                    '\n'
                    "    runner.bench_time_func('hexiom', main, args.level)\n"},
 'chaos': {'path': 'wave14-capture\\capture\\inputs\\chaos\\run_benchmark.py',
           'sha256': '5d20fd29c8ea89e0ebe4040ae4c05f26f1a620cd2a7fc654d9d7f8cb205651ac',
           'text_sha256': '5d20fd29c8ea89e0ebe4040ae4c05f26f1a620cd2a7fc654d9d7f8cb205651ac',
           'text': '"""create chaosgame-like fractals\n'
                   '\n'
                   'Copyright (C) 2005 Carl Friedrich Bolz\n'
                   '"""\n'
                   '\n'
                   'import math\n'
                   'import random\n'
                   '\n'
                   'import pyperf\n'
                   '\n'
                   '\n'
                   'DEFAULT_THICKNESS = 0.25\n'
                   'DEFAULT_WIDTH = 256\n'
                   'DEFAULT_HEIGHT = 256\n'
                   'DEFAULT_ITERATIONS = 5000\n'
                   'DEFAULT_RNG_SEED = 1234\n'
                   '\n'
                   '\n'
                   'class GVector(object):\n'
                   '\n'
                   '    def __init__(self, x=0, y=0, z=0):\n'
                   '        self.x = x\n'
                   '        self.y = y\n'
                   '        self.z = z\n'
                   '\n'
                   '    def Mag(self):\n'
                   '        return math.sqrt(self.x ** 2 + self.y ** 2 + self.z ** 2)\n'
                   '\n'
                   '    def dist(self, other):\n'
                   '        return math.sqrt((self.x - other.x) ** 2\n'
                   '                         + (self.y - other.y) ** 2\n'
                   '                         + (self.z - other.z) ** 2)\n'
                   '\n'
                   '    def __add__(self, other):\n'
                   '        if not isinstance(other, GVector):\n'
                   '            raise ValueError("Can\'t add GVector to " + str(type(other)))\n'
                   '        v = GVector(self.x + other.x, self.y + other.y, self.z + other.z)\n'
                   '        return v\n'
                   '\n'
                   '    def __sub__(self, other):\n'
                   '        return self + other * -1\n'
                   '\n'
                   '    def __mul__(self, other):\n'
                   '        v = GVector(self.x * other, self.y * other, self.z * other)\n'
                   '        return v\n'
                   '    __rmul__ = __mul__\n'
                   '\n'
                   '    def linear_combination(self, other, l1, l2=None):\n'
                   '        if l2 is None:\n'
                   '            l2 = 1 - l1\n'
                   '        v = GVector(self.x * l1 + other.x * l2,\n'
                   '                    self.y * l1 + other.y * l2,\n'
                   '                    self.z * l1 + other.z * l2)\n'
                   '        return v\n'
                   '\n'
                   '    def __str__(self):\n'
                   '        return "<%f, %f, %f>" % (self.x, self.y, self.z)\n'
                   '\n'
                   '    def __repr__(self):\n'
                   '        return "GVector(%f, %f, %f)" % (self.x, self.y, self.z)\n'
                   '\n'
                   '\n'
                   'class Spline(object):\n'
                   '    """Class for representing B-Splines and NURBS of arbitrary degree"""\n'
                   '\n'
                   '    def __init__(self, points, degree, knots):\n'
                   '        """Creates a Spline.\n'
                   '\n'
                   '        points is a list of GVector, degree is the degree of the Spline.\n'
                   '        """\n'
                   '        if len(points) > len(knots) - degree + 1:\n'
                   '            raise ValueError("too many control points")\n'
                   '        elif len(points) < len(knots) - degree + 1:\n'
                   '            raise ValueError("not enough control points")\n'
                   '        last = knots[0]\n'
                   '        for cur in knots[1:]:\n'
                   '            if cur < last:\n'
                   '                raise ValueError("knots not strictly increasing")\n'
                   '            last = cur\n'
                   '        self.knots = knots\n'
                   '        self.points = points\n'
                   '        self.degree = degree\n'
                   '\n'
                   '    def GetDomain(self):\n'
                   '        """Returns the domain of the B-Spline"""\n'
                   '        return (self.knots[self.degree - 1],\n'
                   '                self.knots[len(self.knots) - self.degree])\n'
                   '\n'
                   '    def __call__(self, u):\n'
                   '        """Calculates a point of the B-Spline using de Boors Algorithm"""\n'
                   '        dom = self.GetDomain()\n'
                   '        if u < dom[0] or u > dom[1]:\n'
                   '            raise ValueError("Function value not in domain")\n'
                   '        if u == dom[0]:\n'
                   '            return self.points[0]\n'
                   '        if u == dom[1]:\n'
                   '            return self.points[-1]\n'
                   '        I = self.GetIndex(u)\n'
                   '        d = [self.points[I - self.degree + 1 + ii]\n'
                   '             for ii in range(self.degree + 1)]\n'
                   '        U = self.knots\n'
                   '        for ik in range(1, self.degree + 1):\n'
                   '            for ii in range(I - self.degree + ik + 1, I + 2):\n'
                   '                ua = U[ii + self.degree - ik]\n'
                   '                ub = U[ii - 1]\n'
                   '                co1 = (ua - u) / (ua - ub)\n'
                   '                co2 = (u - ub) / (ua - ub)\n'
                   '                index = ii - I + self.degree - ik - 1\n'
                   '                d[index] = d[index].linear_combination(d[index + 1], co1, co2)\n'
                   '        return d[0]\n'
                   '\n'
                   '    def GetIndex(self, u):\n'
                   '        dom = self.GetDomain()\n'
                   '        for ii in range(self.degree - 1, len(self.knots) - self.degree):\n'
                   '            if u >= self.knots[ii] and u < self.knots[ii + 1]:\n'
                   '                I = ii\n'
                   '                break\n'
                   '        else:\n'
                   '            I = dom[1] - 1\n'
                   '        return I\n'
                   '\n'
                   '    def __len__(self):\n'
                   '        return len(self.points)\n'
                   '\n'
                   '    def __repr__(self):\n'
                   '        return "Spline(%r, %r, %r)" % (self.points, self.degree, self.knots)\n'
                   '\n'
                   '\n'
                   'def write_ppm(im, filename):\n'
                   "    magic = 'P6\\n'\n"
                   '    maxval = 255\n'
                   '    w = len(im)\n'
                   '    h = len(im[0])\n'
                   '\n'
                   '    with open(filename, "w", encoding="latin1", newline=\'\') as fp:\n'
                   '        fp.write(magic)\n'
                   "        fp.write('%i %i\\n%i\\n' % (w, h, maxval))\n"
                   '        for j in range(h):\n'
                   '            for i in range(w):\n'
                   '                val = im[i][j]\n'
                   '                c = val * 255\n'
                   "                fp.write('%c%c%c' % (c, c, c))\n"
                   '\n'
                   '\n'
                   'class Chaosgame(object):\n'
                   '\n'
                   '    def __init__(self, splines, thickness=0.1):\n'
                   '        self.splines = splines\n'
                   '        self.thickness = thickness\n'
                   '        self.minx = min([p.x for spl in splines for p in spl.points])\n'
                   '        self.miny = min([p.y for spl in splines for p in spl.points])\n'
                   '        self.maxx = max([p.x for spl in splines for p in spl.points])\n'
                   '        self.maxy = max([p.y for spl in splines for p in spl.points])\n'
                   '        self.height = self.maxy - self.miny\n'
                   '        self.width = self.maxx - self.minx\n'
                   '        self.num_trafos = []\n'
                   '        maxlength = thickness * self.width / self.height\n'
                   '        for spl in splines:\n'
                   '            length = 0\n'
                   '            curr = spl(0)\n'
                   '            for i in range(1, 1000):\n'
                   '                last = curr\n'
                   '                t = 1 / 999 * i\n'
                   '                curr = spl(t)\n'
                   '                length += curr.dist(last)\n'
                   '            self.num_trafos.append(max(1, int(length / maxlength * 1.5)))\n'
                   '        self.num_total = sum(self.num_trafos)\n'
                   '\n'
                   '    def get_random_trafo(self):\n'
                   '        r = random.randrange(int(self.num_total) + 1)\n'
                   '        l = 0\n'
                   '        for i in range(len(self.num_trafos)):\n'
                   '            if r >= l and r < l + self.num_trafos[i]:\n'
                   '                return i, random.randrange(self.num_trafos[i])\n'
                   '            l += self.num_trafos[i]\n'
                   '        return len(self.num_trafos) - 1, random.randrange(self.num_trafos[-1])\n'
                   '\n'
                   '    def transform_point(self, point, trafo=None):\n'
                   '        x = (point.x - self.minx) / self.width\n'
                   '        y = (point.y - self.miny) / self.height\n'
                   '        if trafo is None:\n'
                   '            trafo = self.get_random_trafo()\n'
                   '        start, end = self.splines[trafo[0]].GetDomain()\n'
                   '        length = end - start\n'
                   '        seg_length = length / self.num_trafos[trafo[0]]\n'
                   '        t = start + seg_length * trafo[1] + seg_length * x\n'
                   '        basepoint = self.splines[trafo[0]](t)\n'
                   '        if t + 1 / 50000 > end:\n'
                   '            neighbour = self.splines[trafo[0]](t - 1 / 50000)\n'
                   '            derivative = neighbour - basepoint\n'
                   '        else:\n'
                   '            neighbour = self.splines[trafo[0]](t + 1 / 50000)\n'
                   '            derivative = basepoint - neighbour\n'
                   '        if derivative.Mag() != 0:\n'
                   '            basepoint.x += derivative.y / derivative.Mag() * (y - 0.5) * \\\n'
                   '                self.thickness\n'
                   '            basepoint.y += -derivative.x / derivative.Mag() * (y - 0.5) * \\\n'
                   '                self.thickness\n'
                   '        else:\n'
                   '            print("r", end=\'\')\n'
                   '        self.truncate(basepoint)\n'
                   '        return basepoint\n'
                   '\n'
                   '    def truncate(self, point):\n'
                   '        if point.x >= self.maxx:\n'
                   '            point.x = self.maxx\n'
                   '        if point.y >= self.maxy:\n'
                   '            point.y = self.maxy\n'
                   '        if point.x < self.minx:\n'
                   '            point.x = self.minx\n'
                   '        if point.y < self.miny:\n'
                   '            point.y = self.miny\n'
                   '\n'
                   '    def create_image_chaos(self, w, h, iterations, filename, rng_seed):\n'
                   '        # Always use the same sequence of random numbers\n'
                   '        # to get reproductible benchmark\n'
                   '        random.seed(rng_seed)\n'
                   '\n'
                   '        im = [[1] * h for i in range(w)]\n'
                   '        point = GVector((self.maxx + self.minx) / 2,\n'
                   '                        (self.maxy + self.miny) / 2, 0)\n'
                   '        for _ in range(iterations):\n'
                   '            point = self.transform_point(point)\n'
                   '            x = (point.x - self.minx) / self.width * w\n'
                   '            y = (point.y - self.miny) / self.height * h\n'
                   '            x = int(x)\n'
                   '            y = int(y)\n'
                   '            if x == w:\n'
                   '                x -= 1\n'
                   '            if y == h:\n'
                   '                y -= 1\n'
                   '            im[x][h - y - 1] = 0\n'
                   '\n'
                   '        if filename:\n'
                   '            write_ppm(im, filename)\n'
                   '\n'
                   '\n'
                   'def main(runner, args):\n'
                   '    splines = [\n'
                   '        Spline([\n'
                   '            GVector(1.597350, 3.304460, 0.000000),\n'
                   '            GVector(1.575810, 4.123260, 0.000000),\n'
                   '            GVector(1.313210, 5.288350, 0.000000),\n'
                   '            GVector(1.618900, 5.329910, 0.000000),\n'
                   '            GVector(2.889940, 5.502700, 0.000000),\n'
                   '            GVector(2.373060, 4.381830, 0.000000),\n'
                   '            GVector(1.662000, 4.360280, 0.000000)],\n'
                   '            3, [0, 0, 0, 1, 1, 1, 2, 2, 2]),\n'
                   '        Spline([\n'
                   '            GVector(2.804500, 4.017350, 0.000000),\n'
                   '            GVector(2.550500, 3.525230, 0.000000),\n'
                   '            GVector(1.979010, 2.620360, 0.000000),\n'
                   '            GVector(1.979010, 2.620360, 0.000000)],\n'
                   '            3, [0, 0, 0, 1, 1, 1]),\n'
                   '        Spline([\n'
                   '            GVector(2.001670, 4.011320, 0.000000),\n'
                   '            GVector(2.335040, 3.312830, 0.000000),\n'
                   '            GVector(2.366800, 3.233460, 0.000000),\n'
                   '            GVector(2.366800, 3.233460, 0.000000)],\n'
                   '            3, [0, 0, 0, 1, 1, 1])\n'
                   '    ]\n'
                   '\n'
                   "    runner.metadata['chaos_thickness'] = args.thickness\n"
                   "    runner.metadata['chaos_width'] = args.width\n"
                   "    runner.metadata['chaos_height'] = args.height\n"
                   "    runner.metadata['chaos_iterations'] = args.iterations\n"
                   "    runner.metadata['chaos_rng_seed'] = args.rng_seed\n"
                   '\n'
                   '    chaos = Chaosgame(splines, args.thickness)\n'
                   "    runner.bench_func('chaos', chaos.create_image_chaos,\n"
                   '                      args.width, args.height, args.iterations,\n'
                   '                      args.filename, args.rng_seed)\n'
                   '\n'
                   '\n'
                   'def add_cmdline_args(cmd, args):\n'
                   '    cmd.append("--width=%s" % args.width)\n'
                   '    cmd.append("--height=%s" % args.height)\n'
                   '    cmd.append("--thickness=%s" % args.thickness)\n'
                   '    cmd.append("--rng-seed=%s" % args.rng_seed)\n'
                   '    if args.filename:\n'
                   '        cmd.extend(("--filename", args.filename))\n'
                   '\n'
                   '\n'
                   'if __name__ == "__main__":\n'
                   '    runner = pyperf.Runner(add_cmdline_args=add_cmdline_args)\n'
                   '    runner.metadata[\'description\'] = "Create chaosgame-like fractals"\n'
                   '    cmd = runner.argparser\n'
                   '    cmd.add_argument("--thickness",\n'
                   '                     type=float, default=DEFAULT_THICKNESS,\n'
                   '                     help="Thickness (default: %s)" % DEFAULT_THICKNESS)\n'
                   '    cmd.add_argument("--width",\n'
                   '                     type=int, default=DEFAULT_WIDTH,\n'
                   '                     help="Image width (default: %s)" % DEFAULT_WIDTH)\n'
                   '    cmd.add_argument("--height",\n'
                   '                     type=int, default=DEFAULT_HEIGHT,\n'
                   '                     help="Image height (default: %s)" % DEFAULT_HEIGHT)\n'
                   '    cmd.add_argument("--iterations",\n'
                   '                     type=int, default=DEFAULT_ITERATIONS,\n'
                   '                     help="Number of iterations (default: %s)"\n'
                   '                          % DEFAULT_ITERATIONS)\n'
                   '    cmd.add_argument("--filename", metavar="FILENAME.PPM",\n'
                   '                     help="Output filename of the PPM picture")\n'
                   '    cmd.add_argument("--rng-seed",\n'
                   '                     type=int, default=DEFAULT_RNG_SEED,\n'
                   '                     help="Random number generator seed (default: %s)"\n'
                   '                          % DEFAULT_RNG_SEED)\n'
                   '\n'
                   '    args = runner.parse_args()\n'
                   '    main(runner, args)\n'},
 'gc_collect': {'path': 'wave14-capture\\capture\\inputs\\gc_collect\\run_benchmark.py',
                'sha256': '7886042f07e517abb79c58643a4b488710f3079936c6990522624bfb9c2acb9b',
                'text_sha256': '7886042f07e517abb79c58643a4b488710f3079936c6990522624bfb9c2acb9b',
                'text': 'import pyperf\n'
                        'import gc\n'
                        '\n'
                        'CYCLES = 100\n'
                        'LINKS = 20\n'
                        '\n'
                        '\n'
                        'class Node:\n'
                        '    def __init__(self):\n'
                        '        self.next = None\n'
                        '        self.prev = None\n'
                        '\n'
                        '    def link_next(self, next):\n'
                        '        self.next = next\n'
                        '        self.next.prev = self\n'
                        '\n'
                        '\n'
                        'def create_cycle(node, n_links):\n'
                        '    """Create a cycle of n_links nodes, starting with node."""\n'
                        '\n'
                        '    if n_links == 0:\n'
                        '        return\n'
                        '\n'
                        '    current = node\n'
                        '    for i in range(n_links):\n'
                        '        next_node = Node()\n'
                        '        current.link_next(next_node)\n'
                        '        current = next_node\n'
                        '\n'
                        '    current.link_next(node)\n'
                        '\n'
                        '\n'
                        'def create_gc_cycles(n_cycles, n_links):\n'
                        '    """Create n_cycles cycles n_links+1 nodes each."""\n'
                        '\n'
                        '    cycles = []\n'
                        '    for _ in range(n_cycles):\n'
                        '        node = Node()\n'
                        '        cycles.append(node)\n'
                        '        create_cycle(node, n_links)\n'
                        '    return cycles\n'
                        '\n'
                        '\n'
                        'def benchamark_collection(loops, cycles, links):\n'
                        '    total_time = 0\n'
                        '    for _ in range(loops):\n'
                        '        gc.collect()\n'
                        '        all_cycles = create_gc_cycles(cycles, links)\n'
                        '\n'
                        '        # Main loop to measure\n'
                        '        del all_cycles\n'
                        '        t0 = pyperf.perf_counter()\n'
                        '        collected = gc.collect()\n'
                        '        total_time += pyperf.perf_counter() - t0\n'
                        '\n'
                        '        assert collected is None or collected >= cycles * (links + 1)\n'
                        '\n'
                        '    return total_time\n'
                        '\n'
                        '\n'
                        'if __name__ == "__main__":\n'
                        '    runner = pyperf.Runner()\n'
                        '    runner.metadata["description"] = "GC link benchmark"\n'
                        '    runner.bench_time_func("create_gc_cycles", benchamark_collection, CYCLES, '
                        'LINKS)\n'},
 'regex_effbot': {'path': 'wave14-capture\\capture\\inputs\\regex_effbot\\run_benchmark.py',
                  'sha256': '0823b6507f8babea2238847562d9c9af31000ea57cbb695e5d47053321ea68c7',
                  'text_sha256': '0823b6507f8babea2238847562d9c9af31000ea57cbb695e5d47053321ea68c7',
                  'text': '\n'
                          '"""Benchmarks for Python\'s regex engine.\n'
                          '\n'
                          "These are some of the original benchmarks used to tune Python's regex engine\n"
                          'in 2000 written by Fredrik Lundh. Retreived from\n'
                          'http://mail.python.org/pipermail/python-dev/2000-August/007797.html and\n'
                          "integrated into Unladen Swallow's pyperf.py in 2009 by David Laing.\n"
                          '\n'
                          'These benchmarks are of interest since they helped to guide the original\n'
                          "optimization of the sre engine, and we shouldn't necessarily ignore them just\n"
                          'because they\'re "old".\n'
                          '"""\n'
                          '\n'
                          '# Python imports\n'
                          'import re\n'
                          '\n'
                          '# Local imports\n'
                          'import pyperf\n'
                          '\n'
                          'USE_BYTES = False\n'
                          '\n'
                          '\n'
                          'def re_compile(s):\n'
                          '    if USE_BYTES:\n'
                          "        return re.compile(s.encode('latin1'))\n"
                          '    else:\n'
                          '        return re.compile(s)\n'
                          '\n'
                          '# These are the regular expressions to be tested. These sync up,\n'
                          '# index-for-index with the list of strings generated by gen_string_table()\n'
                          '# below.\n'
                          '\n'
                          '\n'
                          'def gen_regex_table():\n'
                          '    return [\n'
                          "        re_compile('Python|Perl'),\n"
                          "        re_compile('Python|Perl'),\n"
                          "        re_compile('(Python|Perl)'),\n"
                          "        re_compile('(?:Python|Perl)'),\n"
                          "        re_compile('Python'),\n"
                          "        re_compile('Python'),\n"
                          "        re_compile('.*Python'),\n"
                          "        re_compile('.*Python.*'),\n"
                          "        re_compile('.*(Python)'),\n"
                          "        re_compile('.*(?:Python)'),\n"
                          "        re_compile('Python|Perl|Tcl'),\n"
                          "        re_compile('Python|Perl|Tcl'),\n"
                          "        re_compile('(Python|Perl|Tcl)'),\n"
                          "        re_compile('(?:Python|Perl|Tcl)'),\n"
                          "        re_compile('(Python)\\\\1'),\n"
                          "        re_compile('(Python)\\\\1'),\n"
                          "        re_compile('([0a-z][a-z0-9]*,)+'),\n"
                          "        re_compile('(?:[0a-z][a-z0-9]*,)+'),\n"
                          "        re_compile('([a-z][a-z0-9]*,)+'),\n"
                          "        re_compile('(?:[a-z][a-z0-9]*,)+'),\n"
                          "        re_compile('.*P.*y.*t.*h.*o.*n.*')]\n"
                          '\n'
                          '\n'
                          'def gen_string_table(n):\n'
                          '    """Generates the list of strings that will be used in the benchmarks.\n'
                          '\n'
                          '    All strings have repeated prefixes and suffices, and n specifies the\n'
                          '    number of repetitions.\n'
                          '    """\n'
                          '    strings = []\n'
                          '\n'
                          '    def append(s):\n'
                          '        if USE_BYTES:\n'
                          "            strings.append(s.encode('latin1'))\n"
                          '        else:\n'
                          '            strings.append(s)\n'
                          "    append('-' * n + 'Perl' + '-' * n)\n"
                          "    append('P' * n + 'Perl' + 'P' * n)\n"
                          "    append('-' * n + 'Perl' + '-' * n)\n"
                          "    append('-' * n + 'Perl' + '-' * n)\n"
                          "    append('-' * n + 'Python' + '-' * n)\n"
                          "    append('P' * n + 'Python' + 'P' * n)\n"
                          "    append('-' * n + 'Python' + '-' * n)\n"
                          "    append('-' * n + 'Python' + '-' * n)\n"
                          "    append('-' * n + 'Python' + '-' * n)\n"
                          "    append('-' * n + 'Python' + '-' * n)\n"
                          "    append('-' * n + 'Perl' + '-' * n)\n"
                          "    append('P' * n + 'Perl' + 'P' * n)\n"
                          "    append('-' * n + 'Perl' + '-' * n)\n"
                          "    append('-' * n + 'Perl' + '-' * n)\n"
                          "    append('-' * n + 'PythonPython' + '-' * n)\n"
                          "    append('P' * n + 'PythonPython' + 'P' * n)\n"
                          "    append('-' * n + 'a5,b7,c9,' + '-' * n)\n"
                          "    append('-' * n + 'a5,b7,c9,' + '-' * n)\n"
                          "    append('-' * n + 'a5,b7,c9,' + '-' * n)\n"
                          "    append('-' * n + 'a5,b7,c9,' + '-' * n)\n"
                          "    append('-' * n + 'Python' + '-' * n)\n"
                          '    return strings\n'
                          '\n'
                          '\n'
                          'def init_benchmarks(n_values=None):\n'
                          '    """Initialize the strings we\'ll run the regexes against.\n'
                          '\n'
                          '    The strings used in the benchmark are prefixed and suffixed by\n'
                          '    strings that are repeated n times.\n'
                          '\n'
                          '    The sequence n_values contains the values for n.\n'
                          '    If n_values is None the values of n from the original benchmark\n'
                          '    are used.\n'
                          '\n'
                          '    The generated list of strings is cached in the string_tables\n'
                          '    variable, which is indexed by n.\n'
                          '\n'
                          '    Returns:\n'
                          '    A list of string prefix/suffix lengths.\n'
                          '    """\n'
                          '\n'
                          '    if n_values is None:\n'
                          '        n_values = (0, 5, 50, 250, 1000, 5000, 10000)\n'
                          '\n'
                          '    string_tables = {n: gen_string_table(n) for n in n_values}\n'
                          '    regexs = gen_regex_table()\n'
                          '\n'
                          '    data = []\n'
                          '    for n in n_values:\n'
                          '        for id in range(len(regexs)):\n'
                          '            regex = regexs[id]\n'
                          '            string = string_tables[n][id]\n'
                          '            data.append((regex, string))\n'
                          '    return data\n'
                          '\n'
                          '\n'
                          'def bench_regex_effbot(loops):\n'
                          '    if bench_regex_effbot.data is None:\n'
                          '        bench_regex_effbot.data = init_benchmarks()\n'
                          '    data = bench_regex_effbot.data\n'
                          '\n'
                          '    range_it = range(loops)\n'
                          '    search = re.search\n'
                          '    t0 = pyperf.perf_counter()\n'
                          '\n'
                          '    for _ in range_it:\n'
                          '        # Runs all of the benchmarks for a given value of n.\n'
                          '        for regex, string in data:\n'
                          '            # search 10 times\n'
                          '            search(regex, string)\n'
                          '            search(regex, string)\n'
                          '            search(regex, string)\n'
                          '            search(regex, string)\n'
                          '            search(regex, string)\n'
                          '            search(regex, string)\n'
                          '            search(regex, string)\n'
                          '            search(regex, string)\n'
                          '            search(regex, string)\n'
                          '            search(regex, string)\n'
                          '\n'
                          '    return pyperf.perf_counter() - t0\n'
                          '\n'
                          '\n'
                          '# cached data, generated at the first call\n'
                          'bench_regex_effbot.data = None\n'
                          '\n'
                          '\n'
                          'def add_cmdline_args(cmd, args):\n'
                          '    if args.force_bytes:\n'
                          '        cmd.append("--force_bytes")\n'
                          '\n'
                          '\n'
                          "if __name__ == '__main__':\n"
                          '    runner = pyperf.Runner(add_cmdline_args=add_cmdline_args)\n'
                          '    runner.metadata[\'description\'] = ("Test the performance of regexps "\n'
                          '                                      "using Fredik Lundh\'s benchmarks.")\n'
                          '    runner.argparser.add_argument("-B", "--force_bytes", action="store_true",\n'
                          '                                  help="test bytes regexps")\n'
                          '    options = runner.parse_args()\n'
                          '    if options.force_bytes:\n'
                          '        USE_BYTES = True\n'
                          '\n'
                          "    runner.bench_time_func('regex_effbot', bench_regex_effbot,\n"
                          '                           inner_loops=10)\n'},
 'regex_dna': {'path': 'wave14-capture\\capture\\inputs\\regex_dna\\run_benchmark.py',
               'sha256': 'd820dbdf12262cd11a543ae3dc3fd85793a20220d5a15ef687d8ef57a75c97c6',
               'text_sha256': 'd820dbdf12262cd11a543ae3dc3fd85793a20220d5a15ef687d8ef57a75c97c6',
               'text': '#!/usr/bin/env python\n'
                       '"""\n'
                       'The Computer Language Benchmarks Game\n'
                       'http://benchmarksgame.alioth.debian.org/\n'
                       '\n'
                       'regex-dna Python 3 #5 program:\n'
                       'contributed by Dominique Wahli\n'
                       '2to3\n'
                       'modified by Justin Peel\n'
                       '\n'
                       'fasta Python 3 #3 program:\n'
                       'modified by Ian Osgood\n'
                       'modified again by Heinrich Acker\n'
                       'modified by Justin Peel\n'
                       'Modified by Christopher Sean Forgeron\n'
                       '"""\n'
                       '\n'
                       'import bisect\n'
                       'import re\n'
                       '\n'
                       'import pyperf\n'
                       '\n'
                       '\n'
                       'DEFAULT_INIT_LEN = 100000\n'
                       'DEFAULT_RNG_SEED = 42\n'
                       '\n'
                       "ALU = ('GGCCGGGCGCGGTGGCTCACGCCTGTAATCCCAGCACTTTGG'\n"
                       "       'GAGGCCGAGGCGGGCGGATCACCTGAGGTCAGGAGTTCGAGA'\n"
                       "       'CCAGCCTGGCCAACATGGTGAAACCCCGTCTCTACTAAAAAT'\n"
                       "       'ACAAAAATTAGCCGGGCGTGGTGGCGCGCGCCTGTAATCCCA'\n"
                       "       'GCTACTCGGGAGGCTGAGGCAGGAGAATCGCTTGAACCCGGG'\n"
                       "       'AGGCGGAGGTTGCAGTGAGCCGAGATCGCGCCACTGCACTCC'\n"
                       "       'AGCCTGGGCGACAGAGCGAGACTCCGTCTCAAAAA')\n"
                       '\n'
                       "IUB = list(zip('acgtBDHKMNRSVWY', [0.27, 0.12, 0.12, 0.27] + [0.02] * 11))\n"
                       '\n'
                       'HOMOSAPIENS = [\n'
                       "    ('a', 0.3029549426680),\n"
                       "    ('c', 0.1979883004921),\n"
                       "    ('g', 0.1975473066391),\n"
                       "    ('t', 0.3015094502008),\n"
                       ']\n'
                       '\n'
                       '\n'
                       'def make_cumulative(table):\n'
                       '    P = []\n'
                       '    C = []\n'
                       '    prob = 0.\n'
                       '    for char, p in table:\n'
                       '        prob += p\n'
                       '        P += [prob]\n'
                       '        C += [ord(char)]\n'
                       '    return (P, C)\n'
                       '\n'
                       '\n'
                       'def repeat_fasta(src, n, nprint):\n'
                       '    width = 60\n'
                       '\n'
                       '    is_trailing_line = False\n'
                       '    count_modifier = 0.0\n'
                       '\n'
                       '    len_of_src = len(src)\n'
                       '    ss = src + src + src[:n % len_of_src]\n'
                       "    # CSF - It's faster to work with a bytearray than a string\n"
                       "    s = bytearray(ss, encoding='utf8')\n"
                       '\n'
                       '    if n % width:\n'
                       "        # We don't end on a 60 char wide line\n"
                       '        is_trailing_line = True\n'
                       '        count_modifier = 1.0\n'
                       '\n'
                       '    # CSF - Here we are stuck with using an int instead of a float for the loop,\n'
                       '    # but testing showed it still to be faster than a for loop\n'
                       '    count = 0\n'
                       '    end = (n / float(width)) - count_modifier\n'
                       '    while count < end:\n'
                       '        i = count * 60 % len_of_src\n'
                       "        nprint(s[i:i + 60] + b'\\n')\n"
                       '        count += 1\n'
                       '    if is_trailing_line:\n'
                       "        nprint(s[-(n % width):] + b'\\n')\n"
                       '\n'
                       '\n'
                       'def random_fasta(table, n, seed, nprint):\n'
                       '    width = 60\n'
                       '    r = range(width)\n'
                       '    bb = bisect.bisect\n'
                       '\n'
                       "    # If we don't have a multiple of the width, then we will have a trailing\n"
                       '    # line, which needs a slightly different approach\n'
                       '    is_trailing_line = False\n'
                       '    count_modifier = 0.0\n'
                       '\n'
                       '    line = bytearray(width + 1)    # Width of 60 + 1 for the \\n char\n'
                       '\n'
                       '    probs, chars = make_cumulative(table)\n'
                       '\n'
                       '    # pRNG Vars\n'
                       '    im = 139968.0\n'
                       '    seed = float(seed)\n'
                       '\n'
                       '    if n % width:\n'
                       "        # We don't end on a 60 char wide line\n"
                       '        is_trailing_line = True\n'
                       '        count_modifier = 1.0\n'
                       '\n'
                       '    # CSF - Loops with a high iteration count run faster as a while/float loop.\n'
                       '    count = 0.0\n'
                       '    end = (n / float(width)) - count_modifier\n'
                       '    while count < end:\n'
                       '        # CSF - Low iteration count loops may run faster as a for loop.\n'
                       '        for i in r:\n'
                       '            # CSF - Python is faster for all float math than it is for int, on my\n'
                       '            # machine at least.\n'
                       '            seed = (seed * 3877.0 + 29573.0) % 139968.0\n'
                       '            # CSF - While real values, not variables are faster for most things, on '
                       'my\n'
                       "            # machine, it's faster to have 'im' already in a var\n"
                       '            line[i] = chars[bb(probs, seed / im)]\n'
                       '\n'
                       '        line[60] = 10   # End of Line\n'
                       '        nprint(line)\n'
                       '        count += 1.0\n'
                       '\n'
                       '    if is_trailing_line:\n'
                       '        for i in range(n % width):\n'
                       '            seed = (seed * 3877.0 + 29573.0) % 139968.0\n'
                       '            line[i] = chars[bb(probs, seed / im)]\n'
                       '\n'
                       '        nprint(line[:i + 1] + b"\\n")\n'
                       '\n'
                       '    return seed\n'
                       '\n'
                       '\n'
                       'def init_benchmarks(n, rng_seed):\n'
                       '    result = bytearray()\n'
                       '    nprint = result.extend\n'
                       "    nprint(b'>ONE Homo sapiens alu\\n')\n"
                       '    repeat_fasta(ALU, n * 2, nprint=nprint)\n'
                       '\n'
                       "    # We need to keep track of the state of 'seed' so we pass it in, and return\n"
                       '    # it back so our output can pass the diff test\n'
                       "    nprint(b'>TWO IUB ambiguity codes\\n')\n"
                       '    seed = random_fasta(IUB, n * 3, seed=rng_seed, nprint=nprint)\n'
                       '\n'
                       "    nprint(b'>THREE Homo sapiens frequency\\n')\n"
                       '    random_fasta(HOMOSAPIENS, n * 5, seed, nprint=nprint)\n'
                       '\n'
                       '    return bytes(result)\n'
                       '\n'
                       '\n'
                       'VARIANTS = (\n'
                       "    b'agggtaaa|tttaccct',\n"
                       "    b'[cgt]gggtaaa|tttaccc[acg]',\n"
                       "    b'a[act]ggtaaa|tttacc[agt]t',\n"
                       "    b'ag[act]gtaaa|tttac[agt]ct',\n"
                       "    b'agg[act]taaa|ttta[agt]cct',\n"
                       "    b'aggg[acg]aaa|ttt[cgt]ccct',\n"
                       "    b'agggt[cgt]aa|tt[acg]accct',\n"
                       "    b'agggta[cgt]a|t[acg]taccct',\n"
                       "    b'agggtaa[cgt]|[acg]ttaccct',\n"
                       ')\n'
                       '\n'
                       'SUBST = (\n'
                       "    (b'B', b'(c|g|t)'), (b'D', b'(a|g|t)'), (b'H', b'(a|c|t)'),\n"
                       "    (b'K', b'(g|t)'), (b'M', b'(a|c)'), (b'N', b'(a|c|g|t)'),\n"
                       "    (b'R', b'(a|g)'), (b'S', b'(c|g)'), (b'V', b'(a|c|g)'),\n"
                       "    (b'W', b'(a|t)'), (b'Y', b'(c|t)'),\n"
                       ')\n'
                       '\n'
                       '\n'
                       'def run_benchmarks(seq):\n'
                       '    ilen = len(seq)\n'
                       '\n'
                       "    seq = re.sub(b'>.*\\n|\\n', b'', seq)\n"
                       '    clen = len(seq)\n'
                       '\n'
                       '    results = []\n'
                       '    for f in VARIANTS:\n'
                       '        results.append(len(re.findall(f, seq)))\n'
                       '\n'
                       '    for f, r in SUBST:\n'
                       '        seq = re.sub(f, r, seq)\n'
                       '\n'
                       '    return results, ilen, clen, len(seq)\n'
                       '\n'
                       '\n'
                       'def bench_regex_dna(loops, seq, expected_res):\n'
                       '    range_it = range(loops)\n'
                       '    t0 = pyperf.perf_counter()\n'
                       '\n'
                       '    for i in range_it:\n'
                       '        res = run_benchmarks(seq)\n'
                       '\n'
                       '    dt = pyperf.perf_counter() - t0\n'
                       '    if (expected_res is not None) and (res != expected_res):\n'
                       '        raise Exception("run_benchmarks() error")\n'
                       '\n'
                       '    return dt\n'
                       '\n'
                       '\n'
                       'def add_cmdline_args(cmd, args):\n'
                       '    cmd.extend(("--fasta-length", str(args.fasta_length),\n'
                       '                "--rng-seed", str(args.rng_seed)))\n'
                       '\n'
                       '\n'
                       "if __name__ == '__main__':\n"
                       '    runner = pyperf.Runner(add_cmdline_args=add_cmdline_args)\n'
                       '    runner.metadata[\'description\'] = ("Test the performance of regexps "\n'
                       '                                      "using benchmarks from "\n'
                       '                                      "The Computer Language Benchmarks Game.")\n'
                       '\n'
                       '    cmd = runner.argparser\n'
                       '    cmd.add_argument("--fasta-length", type=int, default=DEFAULT_INIT_LEN,\n'
                       '                     help="Length of the fasta sequence "\n'
                       '                          "(default: %s)" % DEFAULT_INIT_LEN)\n'
                       '    cmd.add_argument("--rng-seed", type=int, default=DEFAULT_RNG_SEED,\n'
                       '                     help="Seed of the random number generator "\n'
                       '                          "(default: %s)" % DEFAULT_RNG_SEED)\n'
                       '\n'
                       '    args = runner.parse_args()\n'
                       '    if args.fasta_length == 100000:\n'
                       '        expected_len = 1016745\n'
                       '        expected_res = ([6, 26, 86, 58, 113, 31, 31, 32, 43],\n'
                       '                        1016745, 1000000, 1336326)\n'
                       '    else:\n'
                       '        expected_len = None\n'
                       '        expected_res = None\n'
                       '\n'
                       "    runner.metadata['regex_dna_fasta_len'] = args.fasta_length\n"
                       "    runner.metadata['regex_dna_rng_seed'] = args.rng_seed\n"
                       '\n'
                       '    seq = init_benchmarks(args.fasta_length, args.rng_seed)\n'
                       '    if (expected_len is not None) and (len(seq) != expected_len):\n'
                       '        raise Exception("init_benchmarks() error")\n'
                       '\n'
                       "    runner.bench_time_func('regex_dna', bench_regex_dna, seq, expected_res)\n"},
 'base64': {'path': 'wave14-capture\\capture\\inputs\\base64\\run_benchmark.py',
            'sha256': 'e2f1e7d4dbfbb2c722833081496497344550e4367f85f67f373fb8aa22cd35ed',
            'text_sha256': 'e2f1e7d4dbfbb2c722833081496497344550e4367f85f67f373fb8aa22cd35ed',
            'text': '"""Benchmark for the base64 module\'s primary public APIs.\n'
                    '\n'
                    'Tests encoding and decoding performance across various variants\n'
                    'and data sizes, split into _small (balanced small data) and _large variants.\n'
                    '\n'
                    'Small weighs towards measuring overhead, large measures the core algorithm\n'
                    'loop implementation.\n'
                    '"""\n'
                    '\n'
                    'import base64\n'
                    'import random\n'
                    'import pyperf\n'
                    '\n'
                    '\n'
                    '# Generate test data with a fixed seed for reproducibility\n'
                    'random.seed(12345)\n'
                    'DATA_TINY = random.randbytes(20)\n'
                    'DATA_SMALL = random.randbytes(127)  # odd on purpose\n'
                    'DATA_MEDIUM = random.randbytes(3072)\n'
                    'DATA_9K = random.randbytes(9000)\n'
                    'DATA_LARGE = random.randbytes(102400)\n'
                    'DATA_HUGE = random.randbytes(1048574)  # 1M-2\n'
                    '\n'
                    '# Pre-encoded data for decode benchmarks\n'
                    'B64_TINY = base64.b64encode(DATA_TINY)\n'
                    'B64_SMALL = base64.b64encode(DATA_SMALL)\n'
                    'B64_MEDIUM = base64.b64encode(DATA_MEDIUM)\n'
                    "B64_9K_STR = base64.b64encode(DATA_9K).decode('ascii')\n"
                    'B64_LARGE = base64.b64encode(DATA_LARGE)\n'
                    'B64_HUGE = base64.b64encode(DATA_HUGE)\n'
                    '\n'
                    'B64_URLSAFE_TINY = base64.urlsafe_b64encode(DATA_TINY)\n'
                    'B64_URLSAFE_SMALL = base64.urlsafe_b64encode(DATA_SMALL)\n'
                    'B64_URLSAFE_MEDIUM = base64.urlsafe_b64encode(DATA_MEDIUM)\n'
                    "B64_URLSAFE_9K_STR = base64.urlsafe_b64encode(DATA_9K).decode('ascii')\n"
                    '\n'
                    'B32_TINY = base64.b32encode(DATA_TINY)\n'
                    'B32_SMALL = base64.b32encode(DATA_SMALL)\n'
                    'B32_MEDIUM = base64.b32encode(DATA_MEDIUM)\n'
                    "B32_9K_STR = base64.b32encode(DATA_9K).decode('ascii')\n"
                    'B32_LARGE = base64.b32encode(DATA_LARGE)\n'
                    'B32_HUGE = base64.b32encode(DATA_HUGE)\n'
                    '\n'
                    'B16_TINY = base64.b16encode(DATA_TINY)\n'
                    'B16_SMALL = base64.b16encode(DATA_SMALL)\n'
                    'B16_MEDIUM = base64.b16encode(DATA_MEDIUM)\n'
                    "B16_9K_STR = base64.b16encode(DATA_9K).decode('ascii')\n"
                    'B16_LARGE = base64.b16encode(DATA_LARGE)\n'
                    'B16_HUGE = base64.b16encode(DATA_HUGE)\n'
                    '\n'
                    'A85_TINY = base64.a85encode(DATA_TINY)\n'
                    'A85_SMALL = base64.a85encode(DATA_SMALL)\n'
                    'A85_MEDIUM = base64.a85encode(DATA_MEDIUM)\n'
                    "A85_9K_STR = base64.a85encode(DATA_9K).decode('ascii')\n"
                    'A85_LARGE = base64.a85encode(DATA_LARGE)\n'
                    'A85_HUGE = base64.a85encode(DATA_HUGE)\n'
                    '\n'
                    'B85_TINY = base64.b85encode(DATA_TINY)\n'
                    'B85_SMALL = base64.b85encode(DATA_SMALL)\n'
                    'B85_MEDIUM = base64.b85encode(DATA_MEDIUM)\n'
                    "B85_9K_STR = base64.b85encode(DATA_9K).decode('ascii')\n"
                    'B85_LARGE = base64.b85encode(DATA_LARGE)\n'
                    'B85_HUGE = base64.b85encode(DATA_HUGE)\n'
                    '\n'
                    '\n'
                    '# --- Base64 ---\n'
                    '\n'
                    'def bench_b64_small(loops):\n'
                    '    range_it = range(loops)\n'
                    '    t0 = pyperf.perf_counter()\n'
                    '    for _ in range_it:\n'
                    '        for _ in range(450):\n'
                    '            base64.b64encode(DATA_TINY)\n'
                    '            base64.b64decode(B64_TINY)\n'
                    '        for _ in range(71):\n'
                    '            base64.b64encode(DATA_SMALL)\n'
                    '            base64.b64decode(B64_SMALL)\n'
                    '        for _ in range(3):\n'
                    '            base64.b64encode(DATA_MEDIUM)\n'
                    '            base64.b64decode(B64_MEDIUM)\n'
                    '        base64.b64encode(DATA_9K)\n'
                    '        base64.b64decode(B64_9K_STR)\n'
                    '    return pyperf.perf_counter() - t0\n'
                    '\n'
                    '\n'
                    'def bench_b64_large(loops):\n'
                    '    range_it = range(loops)\n'
                    '    t0 = pyperf.perf_counter()\n'
                    '    for _ in range_it:\n'
                    '        for _ in range(10):\n'
                    '            base64.b64encode(DATA_LARGE)\n'
                    '            base64.b64decode(B64_LARGE)\n'
                    '        base64.b64encode(DATA_HUGE)\n'
                    '        base64.b64decode(B64_HUGE)\n'
                    '    return pyperf.perf_counter() - t0\n'
                    '\n'
                    '\n'
                    '# --- URL-safe Base64 (small only) ---\n'
                    '\n'
                    'def bench_urlsafe_b64_small(loops):\n'
                    '    range_it = range(loops)\n'
                    '    t0 = pyperf.perf_counter()\n'
                    '    for _ in range_it:\n'
                    '        for _ in range(450):\n'
                    '            base64.urlsafe_b64encode(DATA_TINY)\n'
                    '            base64.urlsafe_b64decode(B64_URLSAFE_TINY)\n'
                    '        for _ in range(71):\n'
                    '            base64.urlsafe_b64encode(DATA_SMALL)\n'
                    '            base64.urlsafe_b64decode(B64_URLSAFE_SMALL)\n'
                    '        for _ in range(3):\n'
                    '            base64.urlsafe_b64encode(DATA_MEDIUM)\n'
                    '            base64.urlsafe_b64decode(B64_URLSAFE_MEDIUM)\n'
                    '        base64.urlsafe_b64encode(DATA_9K)\n'
                    '        base64.urlsafe_b64decode(B64_URLSAFE_9K_STR)\n'
                    '    return pyperf.perf_counter() - t0\n'
                    '\n'
                    '\n'
                    '# --- Base32 ---\n'
                    '\n'
                    'def bench_b32_small(loops):\n'
                    '    range_it = range(loops)\n'
                    '    t0 = pyperf.perf_counter()\n'
                    '    for _ in range_it:\n'
                    '        for _ in range(450):\n'
                    '            base64.b32encode(DATA_TINY)\n'
                    '            base64.b32decode(B32_TINY)\n'
                    '        for _ in range(71):\n'
                    '            base64.b32encode(DATA_SMALL)\n'
                    '            base64.b32decode(B32_SMALL)\n'
                    '        for _ in range(3):\n'
                    '            base64.b32encode(DATA_MEDIUM)\n'
                    '            base64.b32decode(B32_MEDIUM)\n'
                    '        base64.b32encode(DATA_9K)\n'
                    '        base64.b32decode(B32_9K_STR)\n'
                    '    return pyperf.perf_counter() - t0\n'
                    '\n'
                    '\n'
                    'def bench_b32_large(loops):\n'
                    '    range_it = range(loops)\n'
                    '    t0 = pyperf.perf_counter()\n'
                    '    for _ in range_it:\n'
                    '        for _ in range(10):\n'
                    '            base64.b32encode(DATA_LARGE)\n'
                    '            base64.b32decode(B32_LARGE)\n'
                    '        base64.b32encode(DATA_HUGE)\n'
                    '        base64.b32decode(B32_HUGE)\n'
                    '    return pyperf.perf_counter() - t0\n'
                    '\n'
                    '\n'
                    '# --- Base16 ---\n'
                    '\n'
                    'def bench_b16_small(loops):\n'
                    '    range_it = range(loops)\n'
                    '    t0 = pyperf.perf_counter()\n'
                    '    for _ in range_it:\n'
                    '        for _ in range(450):\n'
                    '            base64.b16encode(DATA_TINY)\n'
                    '            base64.b16decode(B16_TINY)\n'
                    '        for _ in range(71):\n'
                    '            base64.b16encode(DATA_SMALL)\n'
                    '            base64.b16decode(B16_SMALL)\n'
                    '        for _ in range(3):\n'
                    '            base64.b16encode(DATA_MEDIUM)\n'
                    '            base64.b16decode(B16_MEDIUM)\n'
                    '        base64.b16encode(DATA_9K)\n'
                    '        base64.b16decode(B16_9K_STR)\n'
                    '    return pyperf.perf_counter() - t0\n'
                    '\n'
                    '\n'
                    'def bench_b16_large(loops):\n'
                    '    range_it = range(loops)\n'
                    '    t0 = pyperf.perf_counter()\n'
                    '    for _ in range_it:\n'
                    '        for _ in range(10):\n'
                    '            base64.b16encode(DATA_LARGE)\n'
                    '            base64.b16decode(B16_LARGE)\n'
                    '        base64.b16encode(DATA_HUGE)\n'
                    '        base64.b16decode(B16_HUGE)\n'
                    '    return pyperf.perf_counter() - t0\n'
                    '\n'
                    '\n'
                    '# --- Ascii85 (includes wrapcol=76) ---\n'
                    '\n'
                    'def bench_a85_small(loops):\n'
                    '    range_it = range(loops)\n'
                    '    t0 = pyperf.perf_counter()\n'
                    '    for _ in range_it:\n'
                    '        for _ in range(450):\n'
                    '            base64.a85encode(DATA_TINY)\n'
                    '            base64.a85encode(DATA_TINY, wrapcol=76)\n'
                    '            base64.a85decode(A85_TINY)\n'
                    '            base64.a85decode(A85_TINY)  # balance enc+dec weight\n'
                    '        for _ in range(71):\n'
                    '            base64.a85encode(DATA_SMALL)\n'
                    '            base64.a85encode(DATA_SMALL, wrapcol=76)\n'
                    '            base64.a85decode(A85_SMALL)\n'
                    '            base64.a85decode(A85_SMALL)  # balance enc+dec weight\n'
                    '        for _ in range(3):\n'
                    '            base64.a85encode(DATA_MEDIUM)\n'
                    '            base64.a85encode(DATA_MEDIUM, wrapcol=76)\n'
                    '            base64.a85decode(A85_MEDIUM)\n'
                    '            base64.a85decode(A85_MEDIUM)  # balance enc+dec weight\n'
                    '        base64.a85encode(DATA_9K)\n'
                    '        base64.a85encode(DATA_9K, wrapcol=76)\n'
                    '        base64.a85decode(A85_9K_STR)\n'
                    '        base64.a85decode(A85_9K_STR)  # balance enc+dec weight\n'
                    '    return pyperf.perf_counter() - t0\n'
                    '\n'
                    '\n'
                    'def bench_a85_large(loops):\n'
                    '    range_it = range(loops)\n'
                    '    t0 = pyperf.perf_counter()\n'
                    '    for _ in range_it:\n'
                    '        for _ in range(10):\n'
                    '            base64.a85encode(DATA_LARGE)\n'
                    '            base64.a85encode(DATA_LARGE, wrapcol=76)\n'
                    '            base64.a85decode(A85_LARGE)\n'
                    '            base64.a85decode(A85_LARGE)  # balance enc+dec weight\n'
                    '        base64.a85encode(DATA_HUGE)\n'
                    '        base64.a85encode(DATA_HUGE, wrapcol=76)\n'
                    '        base64.a85decode(A85_HUGE)\n'
                    '        base64.a85decode(A85_HUGE)  # balance enc+dec weight\n'
                    '    return pyperf.perf_counter() - t0\n'
                    '\n'
                    '\n'
                    '# --- Base85 ---\n'
                    '\n'
                    'def bench_b85_small(loops):\n'
                    '    range_it = range(loops)\n'
                    '    t0 = pyperf.perf_counter()\n'
                    '    for _ in range_it:\n'
                    '        for _ in range(450):\n'
                    '            base64.b85encode(DATA_TINY)\n'
                    '            base64.b85decode(B85_TINY)\n'
                    '        for _ in range(71):\n'
                    '            base64.b85encode(DATA_SMALL)\n'
                    '            base64.b85decode(B85_SMALL)\n'
                    '        for _ in range(3):\n'
                    '            base64.b85encode(DATA_MEDIUM)\n'
                    '            base64.b85decode(B85_MEDIUM)\n'
                    '        base64.b85encode(DATA_9K)\n'
                    '        base64.b85decode(B85_9K_STR)\n'
                    '    return pyperf.perf_counter() - t0\n'
                    '\n'
                    '\n'
                    'def bench_b85_large(loops):\n'
                    '    range_it = range(loops)\n'
                    '    t0 = pyperf.perf_counter()\n'
                    '    for _ in range_it:\n'
                    '        for _ in range(10):\n'
                    '            base64.b85encode(DATA_LARGE)\n'
                    '            base64.b85decode(B85_LARGE)\n'
                    '        base64.b85encode(DATA_HUGE)\n'
                    '        base64.b85decode(B85_HUGE)\n'
                    '    return pyperf.perf_counter() - t0\n'
                    '\n'
                    '\n'
                    'if __name__ == "__main__":\n'
                    '    runner = pyperf.Runner()\n'
                    '    runner.metadata[\'description\'] = "Benchmark base64 module encoding/decoding"\n'
                    '\n'
                    "    runner.bench_time_func('base64_small', bench_b64_small)\n"
                    "    runner.bench_time_func('base64_large', bench_b64_large)\n"
                    '\n'
                    "    runner.bench_time_func('urlsafe_base64_small', bench_urlsafe_b64_small)\n"
                    '\n'
                    "    runner.bench_time_func('base32_small', bench_b32_small)\n"
                    "    runner.bench_time_func('base32_large', bench_b32_large)\n"
                    '\n'
                    "    runner.bench_time_func('base16_small', bench_b16_small)\n"
                    "    runner.bench_time_func('base16_large', bench_b16_large)\n"
                    '\n'
                    "    runner.bench_time_func('ascii85_small', bench_a85_small)\n"
                    "    runner.bench_time_func('ascii85_large', bench_a85_large)\n"
                    '\n'
                    "    runner.bench_time_func('base85_small', bench_b85_small)\n"
                    "    runner.bench_time_func('base85_large', bench_b85_large)\n"},
 'shlex': {'path': 'C:\\Python314\\Lib\\shlex.py',
           'sha256': 'c9d15fd608e9ea2e7ffa92e72bb4aaf2d0b30712f919fb88dfa4901e10e4ce0d',
           'text_sha256': 'aeda1c54188363d907654a19d338e5961416ebec2e2f506afab19be61ada8120',
           'text': '"""A lexical analyzer class for simple shell-like syntaxes."""\n'
                   '\n'
                   '# Module and documentation by Eric S. Raymond, 21 Dec 1998\n'
                   '# Input stacking and error message cleanup added by ESR, March 2000\n'
                   '# push_source() and pop_source() made explicit by ESR, January 2001.\n'
                   '# Posix compliance, split(), string arguments, and\n'
                   '# iterator interface by Gustavo Niemeyer, April 2003.\n'
                   '# changes to tokenize more like Posix shells by Vinay Sajip, July 2016.\n'
                   '\n'
                   'import sys\n'
                   'from io import StringIO\n'
                   '\n'
                   '__all__ = ["shlex", "split", "quote", "join"]\n'
                   '\n'
                   'class shlex:\n'
                   '    "A lexical analyzer class for simple shell-like syntaxes."\n'
                   '    def __init__(self, instream=None, infile=None, posix=False,\n'
                   '                 punctuation_chars=False):\n'
                   '        from collections import deque  # deferred import for performance\n'
                   '\n'
                   '        if isinstance(instream, str):\n'
                   '            instream = StringIO(instream)\n'
                   '        if instream is not None:\n'
                   '            self.instream = instream\n'
                   '            self.infile = infile\n'
                   '        else:\n'
                   '            self.instream = sys.stdin\n'
                   '            self.infile = None\n'
                   '        self.posix = posix\n'
                   '        if posix:\n'
                   '            self.eof = None\n'
                   '        else:\n'
                   "            self.eof = ''\n"
                   "        self.commenters = '#'\n"
                   "        self.wordchars = ('abcdfeghijklmnopqrstuvwxyz'\n"
                   "                          'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_')\n"
                   '        if self.posix:\n'
                   "            self.wordchars += ('ßàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿ'\n"
                   "                               'ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞ')\n"
                   "        self.whitespace = ' \\t\\r\\n'\n"
                   '        self.whitespace_split = False\n'
                   '        self.quotes = \'\\\'"\'\n'
                   "        self.escape = '\\\\'\n"
                   '        self.escapedquotes = \'"\'\n'
                   "        self.state = ' '\n"
                   '        self.pushback = deque()\n'
                   '        self.lineno = 1\n'
                   '        self.debug = 0\n'
                   "        self.token = ''\n"
                   '        self.filestack = deque()\n'
                   '        self.source = None\n'
                   '        if not punctuation_chars:\n'
                   "            punctuation_chars = ''\n"
                   '        elif punctuation_chars is True:\n'
                   "            punctuation_chars = '();<>|&'\n"
                   '        self._punctuation_chars = punctuation_chars\n'
                   '        if punctuation_chars:\n'
                   '            # _pushback_chars is a push back queue used by lookahead logic\n'
                   '            self._pushback_chars = deque()\n'
                   '            # these chars added because allowed in file names, args, wildcards\n'
                   "            self.wordchars += '~-./*?='\n"
                   '            #remove any punctuation chars from wordchars\n'
                   '            t = self.wordchars.maketrans(dict.fromkeys(punctuation_chars))\n'
                   '            self.wordchars = self.wordchars.translate(t)\n'
                   '\n'
                   '    @property\n'
                   '    def punctuation_chars(self):\n'
                   '        return self._punctuation_chars\n'
                   '\n'
                   '    def push_token(self, tok):\n'
                   '        "Push a token onto the stack popped by the get_token method"\n'
                   '        if self.debug >= 1:\n'
                   '            print("shlex: pushing token " + repr(tok))\n'
                   '        self.pushback.appendleft(tok)\n'
                   '\n'
                   '    def push_source(self, newstream, newfile=None):\n'
                   '        "Push an input source onto the lexer\'s input source stack."\n'
                   '        if isinstance(newstream, str):\n'
                   '            newstream = StringIO(newstream)\n'
                   '        self.filestack.appendleft((self.infile, self.instream, self.lineno))\n'
                   '        self.infile = newfile\n'
                   '        self.instream = newstream\n'
                   '        self.lineno = 1\n'
                   '        if self.debug:\n'
                   '            if newfile is not None:\n'
                   "                print('shlex: pushing to file %s' % (self.infile,))\n"
                   '            else:\n'
                   "                print('shlex: pushing to stream %s' % (self.instream,))\n"
                   '\n'
                   '    def pop_source(self):\n'
                   '        "Pop the input source stack."\n'
                   '        self.instream.close()\n'
                   '        (self.infile, self.instream, self.lineno) = self.filestack.popleft()\n'
                   '        if self.debug:\n'
                   "            print('shlex: popping to %s, line %d' \\\n"
                   '                  % (self.instream, self.lineno))\n'
                   "        self.state = ' '\n"
                   '\n'
                   '    def get_token(self):\n'
                   '        "Get a token from the input stream (or from stack if it\'s nonempty)"\n'
                   '        if self.pushback:\n'
                   '            tok = self.pushback.popleft()\n'
                   '            if self.debug >= 1:\n'
                   '                print("shlex: popping token " + repr(tok))\n'
                   '            return tok\n'
                   '        # No pushback.  Get a token.\n'
                   '        raw = self.read_token()\n'
                   '        # Handle inclusions\n'
                   '        if self.source is not None:\n'
                   '            while raw == self.source:\n'
                   '                spec = self.sourcehook(self.read_token())\n'
                   '                if spec:\n'
                   '                    (newfile, newstream) = spec\n'
                   '                    self.push_source(newstream, newfile)\n'
                   '                raw = self.get_token()\n'
                   '        # Maybe we got EOF instead?\n'
                   '        while raw == self.eof:\n'
                   '            if not self.filestack:\n'
                   '                return self.eof\n'
                   '            else:\n'
                   '                self.pop_source()\n'
                   '                raw = self.get_token()\n'
                   '        # Neither inclusion nor EOF\n'
                   '        if self.debug >= 1:\n'
                   '            if raw != self.eof:\n'
                   '                print("shlex: token=" + repr(raw))\n'
                   '            else:\n'
                   '                print("shlex: token=EOF")\n'
                   '        return raw\n'
                   '\n'
                   '    def read_token(self):\n'
                   '        quoted = False\n'
                   "        escapedstate = ' '\n"
                   '        while True:\n'
                   '            if self.punctuation_chars and self._pushback_chars:\n'
                   '                nextchar = self._pushback_chars.pop()\n'
                   '            else:\n'
                   '                nextchar = self.instream.read(1)\n'
                   "            if nextchar == '\\n':\n"
                   '                self.lineno += 1\n'
                   '            if self.debug >= 3:\n'
                   '                print("shlex: in state %r I see character: %r" % (self.state,\n'
                   '                                                                  nextchar))\n'
                   '            if self.state is None:\n'
                   "                self.token = ''        # past end of file\n"
                   '                break\n'
                   "            elif self.state == ' ':\n"
                   '                if not nextchar:\n'
                   '                    self.state = None  # end of file\n'
                   '                    break\n'
                   '                elif nextchar in self.whitespace:\n'
                   '                    if self.debug >= 2:\n'
                   '                        print("shlex: I see whitespace in whitespace state")\n'
                   '                    if self.token or (self.posix and quoted):\n'
                   '                        break   # emit current token\n'
                   '                    else:\n'
                   '                        continue\n'
                   '                elif nextchar in self.commenters:\n'
                   '                    self.instream.readline()\n'
                   '                    self.lineno += 1\n'
                   '                elif self.posix and nextchar in self.escape:\n'
                   "                    escapedstate = 'a'\n"
                   '                    self.state = nextchar\n'
                   '                elif nextchar in self.wordchars:\n'
                   '                    self.token = nextchar\n'
                   "                    self.state = 'a'\n"
                   '                elif nextchar in self.punctuation_chars:\n'
                   '                    self.token = nextchar\n'
                   "                    self.state = 'c'\n"
                   '                elif nextchar in self.quotes:\n'
                   '                    if not self.posix:\n'
                   '                        self.token = nextchar\n'
                   '                    self.state = nextchar\n'
                   '                elif self.whitespace_split:\n'
                   '                    self.token = nextchar\n'
                   "                    self.state = 'a'\n"
                   '                else:\n'
                   '                    self.token = nextchar\n'
                   '                    if self.token or (self.posix and quoted):\n'
                   '                        break   # emit current token\n'
                   '                    else:\n'
                   '                        continue\n'
                   '            elif self.state in self.quotes:\n'
                   '                quoted = True\n'
                   '                if not nextchar:      # end of file\n'
                   '                    if self.debug >= 2:\n'
                   '                        print("shlex: I see EOF in quotes state")\n'
                   '                    # XXX what error should be raised here?\n'
                   '                    raise ValueError("No closing quotation")\n'
                   '                if nextchar == self.state:\n'
                   '                    if not self.posix:\n'
                   '                        self.token += nextchar\n'
                   "                        self.state = ' '\n"
                   '                        break\n'
                   '                    else:\n'
                   "                        self.state = 'a'\n"
                   '                elif (self.posix and nextchar in self.escape and self.state\n'
                   '                      in self.escapedquotes):\n'
                   '                    escapedstate = self.state\n'
                   '                    self.state = nextchar\n'
                   '                else:\n'
                   '                    self.token += nextchar\n'
                   '            elif self.state in self.escape:\n'
                   '                if not nextchar:      # end of file\n'
                   '                    if self.debug >= 2:\n'
                   '                        print("shlex: I see EOF in escape state")\n'
                   '                    # XXX what error should be raised here?\n'
                   '                    raise ValueError("No escaped character")\n'
                   '                # In posix shells, only the quote itself or the escape\n'
                   '                # character may be escaped within quotes.\n'
                   '                if (escapedstate in self.quotes and\n'
                   '                        nextchar != self.state and nextchar != escapedstate):\n'
                   '                    self.token += self.state\n'
                   '                self.token += nextchar\n'
                   '                self.state = escapedstate\n'
                   "            elif self.state in ('a', 'c'):\n"
                   '                if not nextchar:\n'
                   '                    self.state = None   # end of file\n'
                   '                    break\n'
                   '                elif nextchar in self.whitespace:\n'
                   '                    if self.debug >= 2:\n'
                   '                        print("shlex: I see whitespace in word state")\n'
                   "                    self.state = ' '\n"
                   '                    if self.token or (self.posix and quoted):\n'
                   '                        break   # emit current token\n'
                   '                    else:\n'
                   '                        continue\n'
                   '                elif nextchar in self.commenters:\n'
                   '                    self.instream.readline()\n'
                   '                    self.lineno += 1\n'
                   '                    if self.posix:\n'
                   "                        self.state = ' '\n"
                   '                        if self.token or (self.posix and quoted):\n'
                   '                            break   # emit current token\n'
                   '                        else:\n'
                   '                            continue\n'
                   "                elif self.state == 'c':\n"
                   '                    if nextchar in self.punctuation_chars:\n'
                   '                        self.token += nextchar\n'
                   '                    else:\n'
                   '                        if nextchar not in self.whitespace:\n'
                   '                            self._pushback_chars.append(nextchar)\n'
                   "                        self.state = ' '\n"
                   '                        break\n'
                   '                elif self.posix and nextchar in self.quotes:\n'
                   '                    self.state = nextchar\n'
                   '                elif self.posix and nextchar in self.escape:\n'
                   "                    escapedstate = 'a'\n"
                   '                    self.state = nextchar\n'
                   '                elif (nextchar in self.wordchars or nextchar in self.quotes\n'
                   '                      or (self.whitespace_split and\n'
                   '                          nextchar not in self.punctuation_chars)):\n'
                   '                    self.token += nextchar\n'
                   '                else:\n'
                   '                    if self.punctuation_chars:\n'
                   '                        self._pushback_chars.append(nextchar)\n'
                   '                    else:\n'
                   '                        self.pushback.appendleft(nextchar)\n'
                   '                    if self.debug >= 2:\n'
                   '                        print("shlex: I see punctuation in word state")\n'
                   "                    self.state = ' '\n"
                   '                    if self.token or (self.posix and quoted):\n'
                   '                        break   # emit current token\n'
                   '                    else:\n'
                   '                        continue\n'
                   '        result = self.token\n'
                   "        self.token = ''\n"
                   "        if self.posix and not quoted and result == '':\n"
                   '            result = None\n'
                   '        if self.debug > 1:\n'
                   '            if result:\n'
                   '                print("shlex: raw token=" + repr(result))\n'
                   '            else:\n'
                   '                print("shlex: raw token=EOF")\n'
                   '        return result\n'
                   '\n'
                   '    def sourcehook(self, newfile):\n'
                   '        "Hook called on a filename to be sourced."\n'
                   '        import os.path\n'
                   '        if newfile[0] == \'"\':\n'
                   '            newfile = newfile[1:-1]\n'
                   '        # This implements cpp-like semantics for relative-path inclusion.\n'
                   '        if isinstance(self.infile, str) and not os.path.isabs(newfile):\n'
                   '            newfile = os.path.join(os.path.dirname(self.infile), newfile)\n'
                   '        return (newfile, open(newfile, "r"))\n'
                   '\n'
                   '    def error_leader(self, infile=None, lineno=None):\n'
                   '        "Emit a C-compiler-like, Emacs-friendly error-message leader."\n'
                   '        if infile is None:\n'
                   '            infile = self.infile\n'
                   '        if lineno is None:\n'
                   '            lineno = self.lineno\n'
                   '        return "\\"%s\\", line %d: " % (infile, lineno)\n'
                   '\n'
                   '    def __iter__(self):\n'
                   '        return self\n'
                   '\n'
                   '    def __next__(self):\n'
                   '        token = self.get_token()\n'
                   '        if token == self.eof:\n'
                   '            raise StopIteration\n'
                   '        return token\n'
                   '\n'
                   'def split(s, comments=False, posix=True):\n'
                   '    """Split the string *s* using shell-like syntax."""\n'
                   '    if s is None:\n'
                   '        raise ValueError("s argument must not be None")\n'
                   '    lex = shlex(s, posix=posix)\n'
                   '    lex.whitespace_split = True\n'
                   '    if not comments:\n'
                   "        lex.commenters = ''\n"
                   '    return list(lex)\n'
                   '\n'
                   '\n'
                   'def join(split_command):\n'
                   '    """Return a shell-escaped string from *split_command*."""\n'
                   "    return ' '.join(quote(arg) for arg in split_command)\n"
                   '\n'
                   '\n'
                   'def quote(s):\n'
                   '    """Return a shell-escaped version of the string *s*."""\n'
                   '    if not s:\n'
                   '        return "\'\'"\n'
                   '\n'
                   '    if not isinstance(s, str):\n'
                   '        raise TypeError(f"expected string object, got {type(s).__name__!r}")\n'
                   '\n'
                   '    # Use bytes.translate() for performance\n'
                   "    safe_chars = (b'%+,-./0123456789:=@'\n"
                   "                  b'ABCDEFGHIJKLMNOPQRSTUVWXYZ_'\n"
                   "                  b'abcdefghijklmnopqrstuvwxyz')\n"
                   '    # No quoting is needed if `s` is an ASCII string consisting only of `safe_chars`\n'
                   '    if s.isascii() and not s.encode().translate(None, delete=safe_chars):\n'
                   '        return s\n'
                   '\n'
                   '    # use single quotes, and put single quotes into double quotes\n'
                   '    # the string $\'b is then quoted as \'$\'"\'"\'b\'\n'
                   '    return "\'" + s.replace("\'", "\'\\"\'\\"\'") + "\'"\n'
                   '\n'
                   '\n'
                   'def _print_tokens(lexer):\n'
                   '    while tt := lexer.get_token():\n'
                   '        print("Token: " + repr(tt))\n'
                   '\n'
                   "if __name__ == '__main__':\n"
                   '    if len(sys.argv) == 1:\n'
                   '        _print_tokens(shlex())\n'
                   '    else:\n'
                   '        fn = sys.argv[1]\n'
                   '        with open(fn) as f:\n'
                   '            _print_tokens(shlex(f, fn))\n'}}

CASES = [{'id': 'richards_super.Task.qpkt.1',
  'module': 'richards_super',
  'function': 'Task.qpkt',
  'expression': 'self.ident',
  'occurrence': 0,
  'expected_kind': 'attribute',
  'argument': 0,
  'consumer': 'direct field read selects original self.ident under inert-layout guard',
  'missing_fact': 'guarded field origin',
  'action': 'origin',
  'site': [5, 16, 5, 26, 'Attribute'],
  'context': 'Load',
  'original_line': 243,
  'expected_roots': [['argument', 0]],
  'expected_fields': ['ident'],
  'expected_scope': 'original function code'},
 {'id': 'richards_super.Task.qpkt.2',
  'module': 'richards_super',
  'function': 'Task.qpkt',
  'expression': 'pkt.link',
  'occurrence': 0,
  'expected_kind': 'attribute',
  'argument': 1,
  'consumer': 'direct store identifies original destination field',
  'missing_fact': 'guarded field location',
  'action': 'origin',
  'site': [4, 4, 4, 12, 'Attribute'],
  'context': 'Store',
  'original_line': 242,
  'expected_roots': [['argument', 1]],
  'expected_fields': ['link'],
  'expected_scope': 'original function code'},
 {'id': 'richards_super.Task.qpkt.3',
  'module': 'richards_super',
  'function': 'Task.qpkt',
  'expression': 't.addPacket(pkt, self)',
  'occurrence': 0,
  'expected_kind': None,
  'argument': None,
  'consumer': 'returned method object owner needs callee-to-caller transfer',
  'missing_fact': 'callee selected-return transfer',
  'action': 'callee',
  'site': [6, 11, 6, 33, 'Call'],
  'context': None,
  'original_line': 244,
  'expected_roots': [],
  'expected_fields': [],
  'expected_scope': 'original function code'},
 {'id': 'richards_super.Task.runTask.4',
  'module': 'richards_super',
  'function': 'Task.runTask',
  'expression': 'self.input',
  'occurrence': 0,
  'expected_kind': 'attribute',
  'argument': 0,
  'consumer': 'borrow original packet selected from self.input',
  'missing_fact': 'guarded field origin',
  'action': 'origin',
  'site': [3, 14, 3, 24, 'Attribute'],
  'context': 'Load',
  'original_line': 211,
  'expected_roots': [['argument', 0]],
  'expected_fields': ['input'],
  'expected_scope': 'original function code'},
 {'id': 'richards_super.Task.runTask.5',
  'module': 'richards_super',
  'function': 'Task.runTask',
  'expression': 'msg.link',
  'occurrence': 0,
  'expected_kind': 'attribute',
  'argument': 0,
  'consumer': 'selected packet successor remains rooted through self',
  'missing_fact': 'physical roots',
  'action': 'physical',
  'site': [4, 21, 4, 29, 'Attribute'],
  'context': 'Load',
  'original_line': 212,
  'expected_roots': [['argument', 0]],
  'expected_fields': ['input', 'link'],
  'expected_scope': 'original function code'},
 {'id': 'richards_super.Task.runTask.6',
  'module': 'richards_super',
  'function': 'Task.runTask',
  'expression': 'self.fn(msg, self.handle)',
  'occurrence': 0,
  'expected_kind': None,
  'argument': None,
  'consumer': 'resolve selected task returned by direct method call',
  'missing_fact': 'callee return transfer',
  'action': 'callee',
  'site': [12, 11, 12, 36, 'Call'],
  'context': None,
  'original_line': 220,
  'expected_roots': [],
  'expected_fields': [],
  'expected_scope': 'original function code'},
 {'id': 'richards_super.DeviceTask.fn.7',
  'module': 'richards_super',
  'function': 'DeviceTask.fn',
  'expression': 'r',
  'occurrence': 0,
  'expected_kind': 'argument',
  'argument': 2,
  'consumer': 'formal r aliases local d before pending-field reads',
  'missing_fact': 'nested __class__ closure',
  'action': 'origin',
  'site': [2, 8, 2, 9, 'Name'],
  'context': 'Load',
  'original_line': 262,
  'expected_roots': [['argument', 2]],
  'expected_fields': [],
  'expected_scope': 'original function code'},
 {'id': 'richards_super.DeviceTask.fn.8',
  'module': 'richards_super',
  'function': 'DeviceTask.fn',
  'expression': 'd.pending',
  'occurrence': 0,
  'expected_kind': 'attribute',
  'argument': 2,
  'consumer': 'load original pending packet through record argument',
  'missing_fact': 'nested __class__ closure',
  'action': 'origin',
  'site': [6, 14, 6, 23, 'Attribute'],
  'context': 'Load',
  'original_line': 266,
  'expected_roots': [['argument', 2]],
  'expected_fields': ['pending'],
  'expected_scope': 'original function code'},
 {'id': 'richards_super.DeviceTask.fn.9',
  'module': 'richards_super',
  'function': 'DeviceTask.fn',
  'expression': 'd.pending',
  'occurrence': 0,
  'expected_kind': 'attribute',
  'argument': 2,
  'consumer': 'retire old pending field only after publication is safe',
  'missing_fact': 'journal topology',
  'action': 'journal',
  'site': [10, 12, 10, 21, 'Attribute'],
  'context': 'Store',
  'original_line': 270,
  'expected_roots': [['argument', 2]],
  'expected_fields': ['pending'],
  'expected_scope': 'original function code'},
 {'id': 'richards_super.HandlerTask.fn.10',
  'module': 'richards_super',
  'function': 'HandlerTask.fn',
  'expression': 'h.work_in',
  'occurrence': 0,
  'expected_kind': 'attribute',
  'argument': 2,
  'consumer': 'borrow original work packet from argument record',
  'missing_fact': 'nested __class__ closure',
  'action': 'origin',
  'site': [10, 11, 10, 20, 'Attribute'],
  'context': 'Load',
  'original_line': 293,
  'expected_roots': [['argument', 2]],
  'expected_fields': ['work_in'],
  'expected_scope': 'original function code'},
 {'id': 'richards_super.HandlerTask.fn.11',
  'module': 'richards_super',
  'function': 'HandlerTask.fn',
  'expression': 'work.data[count]',
  'occurrence': 0,
  'expected_kind': 'element',
  'argument': 2,
  'consumer': 'preserve packet data element origin at managed transfer',
  'missing_fact': 'nested __class__ closure',
  'action': 'origin',
  'site': [23, 16, 23, 32, 'Subscript'],
  'context': 'Load',
  'original_line': 306,
  'expected_roots': [['argument', 2]],
  'expected_fields': ['work_in', 'data'],
  'expected_scope': 'original function code'},
 {'id': 'richards_super.HandlerTask.fn.12',
  'module': 'richards_super',
  'function': 'HandlerTask.fn',
  'expression': 'h.device_in',
  'occurrence': 0,
  'expected_kind': 'attribute',
  'argument': 2,
  'consumer': 'transfer changed device queue through R8 virtual field',
  'missing_fact': 'virtual-field transfer',
  'action': 'virtual',
  'site': [22, 4, 22, 15, 'Attribute'],
  'context': 'Store',
  'original_line': 305,
  'expected_roots': [['argument', 2]],
  'expected_fields': ['device_in'],
  'expected_scope': 'original function code'},
 {'id': 'richards_super.schedule.13',
  'module': 'richards_super',
  'function': 'schedule',
  'expression': 'taskWorkArea.taskList',
  'occurrence': 0,
  'expected_kind': 'attribute',
  'argument': None,
  'consumer': 'guard and pin global task-list owner',
  'missing_fact': 'global field origin',
  'action': 'origin',
  'site': [2, 8, 2, 29, 'Attribute'],
  'context': 'Load',
  'original_line': 370,
  'expected_roots': [['global', 'global', 'taskWorkArea']],
  'expected_fields': ['taskList'],
  'expected_scope': 'original function code'},
 {'id': 'richards_super.schedule.14',
  'module': 'richards_super',
  'function': 'schedule',
  'expression': 't.link',
  'occurrence': 0,
  'expected_kind': 'attribute',
  'argument': None,
  'consumer': 'loop-selected task field needs dynamic owner correlation',
  'missing_fact': 'loop-carried selected owner',
  'action': 'origin',
  'site': [8, 16, 8, 22, 'Attribute'],
  'context': 'Load',
  'original_line': 376,
  'expected_roots': [],
  'expected_fields': ['link'],
  'expected_scope': 'original function code'},
 {'id': 'richards_super.schedule.15',
  'module': 'richards_super',
  'function': 'schedule',
  'expression': 't',
  'occurrence': 0,
  'expected_kind': 'argument',
  'argument': None,
  'consumer': 'prove current loop task remains physically rooted across call',
  'missing_fact': 'physical roots',
  'action': 'physical',
  'site': [12, 16, 12, 17, 'Name'],
  'context': 'Load',
  'original_line': 380,
  'expected_roots': [],
  'expected_fields': [],
  'expected_scope': 'original function code'},
 {'id': 'hexiom.Hex.link_nodes.16',
  'module': 'hexiom',
  'function': 'Hex.link_nodes',
  'expression': 'node.pos',
  'occurrence': 0,
  'expected_kind': 'attribute',
  'argument': 0,
  'consumer': 'borrow position of each node from caller-owned nodes list',
  'missing_fact': 'borrowed iterable element',
  'action': 'origin',
  'site': [3, 17, 3, 25, 'Attribute'],
  'context': 'Load',
  'original_line': 206,
  'expected_roots': [['argument', 0]],
  'expected_fields': ['nodes_by_id', 'pos'],
  'expected_scope': 'original function code'},
 {'id': 'hexiom.Hex.link_nodes.17',
  'module': 'hexiom',
  'function': 'Hex.link_nodes',
  'expression': 'node.links',
  'occurrence': 0,
  'expected_kind': 'attribute',
  'argument': 0,
  'consumer': 'pin original links list across native append',
  'missing_fact': 'physical roots',
  'action': 'physical',
  'site': [8, 16, 8, 26, 'Attribute'],
  'context': 'Load',
  'original_line': 211,
  'expected_roots': [['argument', 0]],
  'expected_fields': ['nodes_by_id', 'links'],
  'expected_scope': 'original function code'},
 {'id': 'hexiom.Hex.link_nodes.18',
  'module': 'hexiom',
  'function': 'Hex.link_nodes',
  'expression': 'self.nodes_by_pos[nx, ny]',
  'occurrence': 0,
  'expected_kind': 'element',
  'argument': 0,
  'consumer': 'read caller dictionary element through original self',
  'missing_fact': 'guarded element origin',
  'action': 'origin',
  'site': [8, 34, 8, 61, 'Subscript'],
  'context': 'Load',
  'original_line': 211,
  'expected_roots': [['argument', 0]],
  'expected_fields': ['nodes_by_pos'],
  'expected_scope': 'original function code'},
 {'id': 'hexiom.Done.filter_tiles.19',
  'module': 'hexiom',
  'function': 'Done.filter_tiles',
  'expression': 'tiles[v]',
  'occurrence': 0,
  'expected_kind': 'element',
  'argument': 1,
  'consumer': 'read exact caller tiles element under integer-index guard',
  'missing_fact': 'guarded element origin',
  'action': 'origin',
  'site': [3, 11, 3, 19, 'Subscript'],
  'context': 'Load',
  'original_line': 87,
  'expected_roots': [['argument', 1]],
  'expected_fields': [],
  'expected_scope': 'original function code'},
 {'id': 'hexiom.Done.filter_tiles.20',
  'module': 'hexiom',
  'function': 'Done.filter_tiles',
  'expression': 'tiles',
  'occurrence': 0,
  'expected_kind': 'argument',
  'argument': 1,
  'consumer': 'pin tiles through remove_all callbacks',
  'missing_fact': 'physical roots',
  'action': 'physical',
  'site': [3, 11, 3, 16, 'Name'],
  'context': 'Load',
  'original_line': 87,
  'expected_roots': [['argument', 1]],
  'expected_fields': [],
  'expected_scope': 'original function code'},
 {'id': 'chaos.Chaosgame.transform_point.21',
  'module': 'chaos',
  'function': 'Chaosgame.transform_point',
  'expression': 'point.x',
  'occurrence': 0,
  'expected_kind': 'attribute',
  'argument': 1,
  'consumer': 'original point field feeds guarded numeric read',
  'missing_fact': 'guarded field origin',
  'action': 'origin',
  'site': [2, 9, 2, 16, 'Attribute'],
  'context': 'Load',
  'original_line': 179,
  'expected_roots': [['argument', 1]],
  'expected_fields': ['x'],
  'expected_scope': 'original function code'},
 {'id': 'chaos.Chaosgame.transform_point.22',
  'module': 'chaos',
  'function': 'Chaosgame.transform_point',
  'expression': 'self.splines[trafo[0]]',
  'occurrence': 0,
  'expected_kind': 'element',
  'argument': 0,
  'consumer': 'select borrowed spline from caller object',
  'missing_fact': 'guarded element origin',
  'action': 'origin',
  'site': [6, 17, 6, 39, 'Subscript'],
  'context': 'Load',
  'original_line': 183,
  'expected_roots': [['argument', 0]],
  'expected_fields': ['splines'],
  'expected_scope': 'original function code'},
 {'id': 'chaos.Chaosgame.transform_point.23',
  'module': 'chaos',
  'function': 'Chaosgame.transform_point',
  'expression': 'basepoint',
  'occurrence': 0,
  'expected_kind': None,
  'argument': None,
  'consumer': 'returned point from spline call needs dynamic allocation/owner tag',
  'missing_fact': 'callee allocation tags',
  'action': 'callee',
  'site': [25, 11, 25, 20, 'Name'],
  'context': 'Load',
  'original_line': 202,
  'expected_roots': [],
  'expected_fields': [],
  'expected_scope': 'original function code'},
 {'id': 'chaos.Spline.__call__.24',
  'module': 'chaos',
  'function': 'Spline.__call__',
  'expression': 'self.points[0]',
  'occurrence': 0,
  'expected_kind': 'element',
  'argument': 0,
  'consumer': 'endpoint returns exact original point instead of rebuilding it',
  'missing_fact': 'comprehension CFG',
  'action': 'origin',
  'site': [7, 15, 7, 29, 'Subscript'],
  'context': 'Load',
  'original_line': 95,
  'expected_roots': [['argument', 0]],
  'expected_fields': ['points'],
  'expected_scope': 'original function code'},
 {'id': 'chaos.Spline.__call__.25',
  'module': 'chaos',
  'function': 'Spline.__call__',
  'expression': '[self.points[I - self.degree + 1 + ii] for ii in range(self.degree + 1)]',
  'occurrence': 0,
  'expected_kind': 'allocation',
  'argument': None,
  'consumer': 'local comprehension list is fresh but contains borrowed point owners',
  'missing_fact': 'comprehension CFG',
  'action': 'aggregate',
  'required_members': 'initial comprehension members borrowed from self.points, before replacement loop',
  'site': [11, 8, 12, 42, 'ListComp'],
  'context': None,
  'original_line': 99,
  'expected_roots': [['argument', 0]],
  'expected_fields': ['points'],
  'expected_scope': 'original function code'},
 {'id': 'chaos.Spline.__call__.26',
  'module': 'chaos',
  'function': 'Spline.__call__',
  'expression': 'd[0]',
  'occurrence': 0,
  'expected_kind': None,
  'argument': None,
  'consumer': 'join endpoints and generated point with callee allocation tag',
  'missing_fact': 'callee allocation tags',
  'action': 'callee',
  'site': [22, 11, 22, 15, 'Subscript'],
  'context': 'Load',
  'original_line': 110,
  'expected_roots': [],
  'expected_fields': [],
  'expected_scope': 'original function code'},
 {'id': 'gc_collect.create_cycle.27',
  'module': 'gc_collect',
  'function': 'create_cycle',
  'expression': 'node',
  'occurrence': 0,
  'expected_kind': 'argument',
  'argument': 0,
  'consumer': 'original starting node passed into final link_next',
  'missing_fact': 'argument identity',
  'action': 'origin',
  'site': [13, 22, 13, 26, 'Name'],
  'context': 'Load',
  'original_line': 30,
  'expected_roots': [['argument', 0]],
  'expected_fields': [],
  'expected_scope': 'original function code'},
 {'id': 'gc_collect.create_cycle.28',
  'module': 'gc_collect',
  'function': 'create_cycle',
  'expression': 'Node()',
  'occurrence': 0,
  'expected_kind': None,
  'argument': None,
  'consumer': 'separate dynamic node allocations from repeated same source site',
  'missing_fact': 'callee allocation tags',
  'action': 'callee',
  'site': [9, 20, 9, 26, 'Call'],
  'context': None,
  'original_line': 26,
  'expected_roots': [],
  'expected_fields': [],
  'expected_scope': 'original function code'},
 {'id': 'gc_collect.create_cycle.29',
  'module': 'gc_collect',
  'function': 'create_cycle',
  'expression': 'current',
  'occurrence': 0,
  'expected_kind': None,
  'argument': None,
  'consumer': 'link updates preserve cycles and retire prior journal owners safely',
  'missing_fact': 'journal topology',
  'action': 'journal',
  'site': [13, 4, 13, 11, 'Name'],
  'context': 'Load',
  'original_line': 30,
  'expected_roots': [],
  'expected_fields': [],
  'expected_scope': 'original function code'},
 {'id': 'regex_effbot.gen_string_table.30',
  'module': 'regex_effbot',
  'function': 'gen_string_table',
  'expression': 'strings',
  'occurrence': 0,
  'expected_kind': 'allocation',
  'argument': None,
  'consumer': 'fresh local strings list escapes with every appended owner',
  'missing_fact': 'nested closure and fresh-list contents',
  'action': 'aggregate',
  'required_members': 'all 21 appended str/bytes owners, recursively escaped',
  'site': [35, 11, 35, 18, 'Name'],
  'context': 'Load',
  'original_line': 93,
  'expected_roots': [],
  'expected_fields': [],
  'expected_scope': 'original function code'},
 {'id': 'regex_effbot.gen_string_table.31',
  'module': 'regex_effbot',
  'function': 'gen_string_table',
  'expression': 'strings.append',
  'occurrence': 0,
  'expected_kind': 'attribute',
  'argument': None,
  'consumer': 'closure captures same list across eager append calls',
  'missing_fact': 'nested-scope closure-cell transfer',
  'action': 'origin',
  'required_parent': 'closure-cell:strings',
  'site': [13, 12, 13, 26, 'Attribute'],
  'context': 'Load',
  'original_line': 71,
  'expected_roots': [],
  'expected_fields': [],
  'expected_scope': 'original function code'},
 {'id': 'regex_effbot.gen_string_table.32',
  'module': 'regex_effbot',
  'function': 'gen_string_table',
  'expression': 's',
  'occurrence': 0,
  'expected_kind': 'argument',
  'argument': 0,
  'consumer': 'forward original string input through local helper before optional encode',
  'missing_fact': 'nested-scope formal substitution',
  'action': 'origin',
  'lexical_function': 'append',
  'site': [13, 27, 13, 28, 'Name'],
  'context': 'Load',
  'original_line': 71,
  'expected_roots': [['argument', 0]],
  'expected_fields': [],
  'expected_scope': 'nested append original code and caller actual substitution'},
 {'id': 'regex_dna.run_benchmarks.33',
  'module': 'regex_dna',
  'function': 'run_benchmarks',
  'expression': 'seq',
  'occurrence': 0,
  'expected_kind': 'argument',
  'argument': 0,
  'consumer': 'forward original bytes into first re.sub call',
  'missing_fact': 'argument identity',
  'action': 'origin',
  'site': [4, 35, 4, 38, 'Name'],
  'context': 'Load',
  'original_line': 174,
  'expected_roots': [['argument', 0]],
  'expected_fields': [],
  'expected_scope': 'original function code'},
 {'id': 'regex_dna.run_benchmarks.34',
  'module': 'regex_dna',
  'function': 'run_benchmarks',
  'expression': "re.sub(b'>.*\\n|\\n', b'', seq)",
  'occurrence': 0,
  'expected_kind': None,
  'argument': None,
  'consumer': 'result bytes need object call owner transfer',
  'missing_fact': 'callee return transfer',
  'action': 'callee',
  'site': [4, 10, 4, 39, 'Call'],
  'context': None,
  'original_line': 174,
  'expected_roots': [],
  'expected_fields': [],
  'expected_scope': 'original function code'},
 {'id': 'shlex.shlex.read_token.35',
  'module': 'shlex',
  'function': 'shlex.read_token',
  'expression': 'self.token',
  'occurrence': 0,
  'expected_kind': 'attribute',
  'argument': 0,
  'consumer': 'selected token field must keep original str owner on return',
  'missing_fact': 'unsupported CFG',
  'action': 'origin',
  'site': [24, 19, 24, 29, 'Attribute'],
  'context': 'Load',
  'original_line': 154,
  'expected_roots': [['argument', 0]],
  'expected_fields': [],
  'expected_scope': 'original function code'},
 {'id': 'shlex.shlex.read_token.36',
  'module': 'shlex',
  'function': 'shlex.read_token',
  'expression': 'self.instream.read(1)',
  'occurrence': 0,
  'expected_kind': 'operation',
  'argument': None,
  'consumer': 'character owner selected by stream read needs call transfer',
  'missing_fact': 'callee return transfer',
  'action': 'callee',
  'site': [8, 23, 8, 44, 'Call'],
  'context': None,
  'original_line': 138,
  'expected_roots': [],
  'expected_fields': [],
  'expected_scope': 'original function code'},
 {'id': 'base64.bench_b64_small.37',
  'module': 'base64',
  'function': 'bench_b64_small',
  'expression': 'base64.b64encode(DATA_TINY)',
  'occurrence': 0,
  'expected_kind': None,
  'argument': None,
  'consumer': 'borrow bytes input and materialize exact output owner',
  'missing_fact': 'callee return transfer',
  'action': 'callee',
  'site': [6, 12, 6, 39, 'Call'],
  'context': None,
  'original_line': 73,
  'expected_roots': [],
  'expected_fields': [],
  'expected_scope': 'original function code'},
 {'id': 'base64.bench_b64_small.38',
  'module': 'base64',
  'function': 'bench_b64_small',
  'expression': 'DATA_TINY',
  'occurrence': 0,
  'expected_kind': None,
  'argument': None,
  'consumer': 'global bytes owner remains live across encode/decode callback',
  'missing_fact': 'physical roots',
  'action': 'physical',
  'site': [6, 29, 6, 38, 'Name'],
  'context': 'Load',
  'original_line': 73,
  'expected_roots': [],
  'expected_fields': [],
  'expected_scope': 'original function code'}]

SUPPORT = {'path': 'wave14-capture\\capture\\inputs\\shim\\pyperf.py',
 'raw_sha256': '71ac509a7161b8ac664a0f4bb2bf84868e82642a600d4afa3996482bd1011ade',
 'text_sha256': '71ac509a7161b8ac664a0f4bb2bf84868e82642a600d4afa3996482bd1011ade',
 'text': '"""Stand-in for pyperf: run each benchmark body in this process so a profiler can see it."""\n'
         'import argparse\n'
         'import asyncio\n'
         'import sys\n'
         'import time\n'
         '\n'
         'perf_counter = time.perf_counter\n'
         'LOOPS = 2\n'
         '\n'
         '\n'
         'def python_implementation():\n'
         '    return sys.implementation.name\n'
         '\n'
         '\n'
         'def python_has_jit():\n'
         '    return False\n'
         '\n'
         '\n'
         'class Runner:\n'
         '    def __init__(self, *args, **kwargs):\n'
         '        self.metadata = {}\n'
         '        self.argparser = argparse.ArgumentParser()\n'
         '        self.args = None\n'
         '\n'
         '    def parse_args(self, args=None):\n'
         '        self.args, _ = self.argparser.parse_known_args(args)\n'
         '        return self.args\n'
         '\n'
         '    def bench_func(self, name, func, *args, **kwargs):\n'
         '        for _ in range(LOOPS):\n'
         '            func(*args)\n'
         '\n'
         '    def bench_time_func(self, name, func, *args, **kwargs):\n'
         '        func(LOOPS, *args)\n'
         '\n'
         '    def bench_async_func(self, name, func, *args, **kwargs):\n'
         '        for _ in range(LOOPS):\n'
         '            asyncio.run(func(*args))\n'
         '\n'
         '    def bench_command(self, *args, **kwargs):\n'
         '        pass\n'
         '\n'
         '    def timeit(self, *args, **kwargs):\n'
         '        pass\n'}

AUXILIARY = {'source': 'def borrowed(values):\n'
           '    def inner(a, b):\n'
           '        return a + a\n'
           '    return inner(values.pop(), values.pop())',
 'path': 'wave18-lift\\lift-evidence\\next-local-s49-tests.py',
 'sha256': '5a1f23d1f67e7e96a15aa69b604b987ff82819a2bb8114d39201ff877b5b0fac',
 'consumer': 'parked local-call borrowed-list pop preserves surviving caller list and argument evaluation '
             'order',
 'missing_fact': 'nested closure plus mutable element transfer'}
