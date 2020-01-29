import json
import logging
import os
import time
from datetime import datetime, timedelta

import boto3
from boto3.dynamodb.conditions import Key, Attr

dynamodb = boto3.resource('dynamodb')


def avg_handler(event, context):

    table = dynamodb.Table('btc')

    now = int(datetime.timestamp(datetime.now()))
    delta = int(event['pathParameters']['timestamp'])
    fe = Key('createdAt').between(delta,now);
    
    response = table.scan(
                    FilterExpression=fe
                )
    items = response['Items']
    max_price = sum(map(lambda x: int(x['price']), items)) / len(items)


    data = { 'avg_price': max_price}

    print(max_price)
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
