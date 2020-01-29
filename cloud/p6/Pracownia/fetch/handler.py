import json
import logging
import os
import time
# import requests
# from botocore.vendored import requests
import urllib3

from datetime import datetime

import boto3
dynamodb = boto3.resource('dynamodb')

def fetch(event, context):

    http = urllib3.PoolManager()
    r = http.request('GET', 'https://api.coinpaprika.com/v1/tickers/btc-bitcoin')
    data = json.loads(r.data.decode('utf-8'))
    # r = requests.get('https://api.coinpaprika.com/v1/tickers/btc-bitcoin').json()
    logging.debug(data)

    price = data['quotes']['USD']['price']

    timestamp = int(datetime.utcnow().timestamp())

    table = dynamodb.Table('btc')

    item = {
        'price': int(price),
        'createdAt': timestamp
    }

    table.put_item(Item=item)

    # create a response
    response = {
        "statusCode": 200,
        "body": json.dumps(item)
    }


    return response
