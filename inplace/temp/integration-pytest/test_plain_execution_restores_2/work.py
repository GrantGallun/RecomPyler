import json, sys
print(json.dumps([__name__, __file__, sys.argv, sys.path[0], sys.modules['__main__'].__file__]))
sys.argv.append('changed')
sys.path.append('changed')
raise SystemExit(0)
