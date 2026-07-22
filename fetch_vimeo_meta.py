import urllib.request
import json

vimeo_ids = ['257499542', '409777499', '1076621501', '632764718']

for vid in vimeo_ids:
    url = f"https://vimeo.com/api/oembed.json?url=https://vimeo.com/{vid}"
    req = urllib.request.Request(url, headers={'User-Agent': 'Mozilla/5.0'})
    try:
        with urllib.request.urlopen(req) as response:
            data = json.loads(response.read().decode('utf-8'))
            print(f"ID: {vid} | Title: {data.get('title')} | Author: {data.get('author_name')}")
    except Exception as e:
        print(f"ID: {vid} | Error: {e}")
