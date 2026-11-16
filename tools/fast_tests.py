"""Compatibility entry for the shared warm fast gate (up to four workers)."""
import argparse
from full_suite import main as run


def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--workers',type=int,default=4)
    parser.add_argument('--label',default='fast')
    args=parser.parse_args()
    return run([args.label,'--workers',str(args.workers)])

if __name__=='__main__':raise SystemExit(main())
