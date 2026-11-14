"""Self-contained workload for the heads-up poker bot: one duplicate match of the
adaptive strategy against the equity sparring bot, played in-process."""
import os
import sys
from pathlib import Path

BOT = Path(os.environ.get("POKER_BOT", r"D:\Code\Datathon\heads-up-bot"))
sys.path.insert(0, str(BOT))
os.chdir(BOT)

from benchmark import play_pair  # noqa: E402

if __name__ == "__main__":
    deals = int(sys.argv[1]) if len(sys.argv) > 1 else 40
    opponent = sys.argv[2] if len(sys.argv) > 2 else "equity"
    result = play_pair("adaptive", opponent, deals, "recompyler-workload")
    print(f"adaptive vs {opponent}: {result.mean_bb:+.3f} bb/deal over {deals} deals")
