#!/usr/bin/env python3.6
#https://www.datamuse.com/api/
from datamuse import datamuse
import sys

api = datamuse.Datamuse()
if len(sys.argv) == 1:
    w = input("word to rhyme. ? for random>")
else:
    w = " ".join(sys.argv[1:])

response = api.words(rel_rhy=w, max=1000, md="df")
# response = [r for r in response if "defs" not in r or ("defs" in r and len(r["defs"]) > 0)]
response.sort(key=lambda r: float(r['tags'][0].strip("f:")))
response = response[::-1]
l = 0
for r in response:
    if l + len(r['word']) >= 80:
        l = 0
        print('\n', end='')
    l += len(r['word'])
    print(r['word'].strip(), end=' | ')
    # defns = "\n\t-" + "\n\t-".join(r['defs']) if 'defs' in r  else "" 
    # defns = ""
    # print("%s" % (r['word'], defns))
