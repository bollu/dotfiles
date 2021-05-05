import weasyprint
import requests
import sys
import selenium
import pdfkit
import os


# [{'id': 1290, <- DOES NOT EXIST
#   'name': 'Codeforces Round #616 (Div. 1)',
#   'type': 'CF',
#   'phase': 'BEFORE',
#   'frozen': False,
#   'durationSeconds': 9000,
#   'startTimeSeconds': 1580652300,
#   'relativeTimeSeconds': -175751}]
#
# In [22]: [c for c in contests['result'] if c['id'] == 1289]
# Out[22]: []
#
# In [23]: [c for c in contests['result'] if c['id'] == 1288]
# Out[23]:
# [{'id': 1288,
#   'name': 'Educational Codeforces Round 80 (Rated for Div. 2)',
#   'type': 'ICPC',
#   'phase': 'FINISHED',
#   'frozen': False,
#   'durationSeconds': 7200,
#   'startTimeSeconds': 1579012500,
#   'relativeTimeSeconds': 1464049}]



resp = requests.get('https://codeforces.com/api/contest.list', {'gym':'false'})
if resp.status_code != 200:
  print("unable to access the codeforces website")
  sys.exit(1)
contests = resp.json()['result']
contestids = [c['id'] for c in contests if c['relativeTimeSeconds'] > 0]
contestids.sort()


startix = 0
try:
  with open("progress.txt", "r") as f:
    startix = int(f.read())
except Exception as e:
  print("tried to load progress. failed: |%s|" % e)


print("scraping from index: %s" % startix)
for (ix, cid) in list(enumerate(contestids[::-1]))[startix:]:
  url = 'http://codeforces.com/contest/%s/problems' % (cid, )
  filename = 'forces%s.pdf' % (cid, )
  print ("scraping: |%s|" % url)
  pdfkit.from_url(url, filename)
  print("wrote: |%s|" % filename)
  with open('progress.txt', 'w') as f: f.write(str(ix)); f.flush()
