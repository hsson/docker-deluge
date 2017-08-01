import json
import urllib

URL = 'https://www.ovpn.com/v1/api/client/ptr'

def is_connected():
    response = urllib.urlopen(URL)
    data = json.loads(response.read())
    return data['status']

if __name__ == '__main__':
    status = is_connected()
    print status
    exit(0) if status else exit(1)
