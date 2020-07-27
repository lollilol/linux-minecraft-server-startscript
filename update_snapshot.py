#!/usr/bin/python3

import urllib.request
import json

data = None
with urllib.request.urlopen("https://launchermeta.mojang.com/mc/game/version_manifest.json") as url:
    data = json.loads(url.read().decode())

new_url = ((data["versions"])[0])["url"]

with urllib.request.urlopen(new_url) as url:
    data = json.loads(url.read().decode())

download_url = ((data["downloads"])["server"])["url"]
urllib.request.urlretrieve(download_url, "./server.jar")
