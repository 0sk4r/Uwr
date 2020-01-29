import json
import logging
import os
import time
from datetime import datetime, timedelta

import boto3
from boto3.dynamodb.conditions import Key, Attr

dynamodb = boto3.resource('dynamodb')

class DecimalEncoder(json.JSONEncoder):
    def default(self, obj):
        if isinstance(obj, D):
            return float(obj)
        return json.JSONEncoder.default(self, obj)

def minmax_handler(event, context):

    table = dynamodb.Table('btc')

    now = int(datetime.timestamp(datetime.now()))
    delta = int(event['pathParameters']['timestamp'])
    fe = Key('createdAt').between(delta,now);

    response = table.scan(
                    FilterExpression=fe
                )
    items = response['Items']
    max_price = max(items, key = lambda x: int(x['price']))
    min_price = min(items, key = lambda x: int(x['price']))

    data = { 'max_price': 
                {
                    'price': int(max_price['price']),
                    'date': int(max_price['createdAt'])
                },
            'min_price': 
            {
                'price': int(min_price['price']), 
                'date': int(min_price['createdAt'])
            }
    }

    response = {
        "statusCode": 200,
        "body": json.dumps(data),
        "headers": {
            'Access-Control-Allow-Origin': '*', 
            'Access-Control-Allow-Credentials': "true",
            'Content-Type': "application/json"
        }
    }


    return response
