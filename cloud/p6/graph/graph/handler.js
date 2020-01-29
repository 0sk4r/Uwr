"use strict";
const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient();

module.exports.hello = async event => {
  let timestamp1 = new Date();
  let timestamp2 = new Date();
  let dateOffset = 24 * 60 * 60 * 1000 * 1; //5 days
  timestamp1.setTime(timestamp1.getTime() - dateOffset);

  let dat = "";
  const params = {
    TableName: "btc",
    KeyConditionExpression: `createdAt between :date1 and :date2`,
    ExpressionAttributeValues: {
      ":date1": timestamp1.getTime() / 1000,
      ":date2": timestamp2.getTime() / 1000
    }
  };

  console.warn("WARN");
  console.log("TEST");
  console.error("ERROR");
  docClient.scan(params, function(err, data) {
    console.log("Querry\n");
    if (err) {
      console.error(
        "Unable to read item. Error JSON:",
        JSON.stringify(err, null, 2)
      );
    } else {
      console.log(data)
      return {
        dataType: "text/html",
        statusCode: 200,
        body: JSON.stringify(data.Item)
      };
    }
  });

  // Use this code if you don't use the http event with the LAMBDA-PROXY integration
  // return { message: 'Go Serverless v1.0! Your function executed successfully!', event };
};
