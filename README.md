# DLQ-Dashboard-Mule-Backend

This Mule API is used by the [DLQ-Dashboard-Frontend](https://github.com/loveleshkalonia/DLQ-Dashboard-Frontend) React App or the User to perform basic SQS operations. This code is designed to work with FIFO SQS Queues strictly because reading messages from a Standard SQS Queue is trouble. (Learn more [here](https://help.salesforce.com/s/articleView?id=001119110&type=1)).

One can easily import the code into AnypointStudio and run it directly. All dependencies are publicly available, i.e., no private repositories are referred to in this project. Instead of using an APIKit Router with a RAML specification, this code contains multiple HTTP Listeners.\
Before you run, you must either edit the "/src/main/resources/properties/dev.yaml" property file or use VM arguments to override some properties.

VM arguments example:

-Daws.role.arn=arn:aws:iam::XXXXXXXXXXX:role/dlq-mule-backend-iam-role\
-Daws.access.key=XXXXXXXXXXXXXXXXXXXX\
-Daws.secret.key=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX\
-Daws.region=us-east-1\
-Dmule.env=dev

If you need help setting up an AWS IAM Role to run this code locally, click [here](https://www.loveleshkalonia.com/2023/08/role-based-aws-setup-for-mulesoft-s3-connectors-on-new-object-component.html#:~:text=and%20Private%20Space.-,Local%20Run%20Setup,-As%20previously%20mentioned).

You can find Sample API Requests collection exported from [Hoppscotch](https://hoppscotch.io/) here: "/hoppscotch-collection/DLQ-Dashboard-Mule-Backend.json".

All endpoints featuring the POST method can also be used with the OPTIONS method. This is done because of the way [Axios](https://axios-http.com/docs/intro) Client makes API Calls in the [DLQ-Dashboard-Frontend](https://github.com/loveleshkalonia/DLQ-Dashboard-Frontend) React App code. In short, Axios sends an OPTIONS Request before making a POST Request.

Learn more about the available endpoints below:

## GET: /Queue/Active

Fetch all active SQS queues whose name contains the "-dlq" string.

## GET: /Queue/{queueName}

Read the first 10 (Maximum) messages from the specified {queueName} SQS queue.

Example URI Parameter:

```
ghost-dlq.fifo
```

## POST: /Queue/{queueName}

Push messages to the specified {queueName} SQS queue. The body of this request is an Array of JSON Objects (Messages). It is validated against the "/src/main/resources/schemas/post-queue-msg.json" JSON schema.

Example URI Parameter:

```
ghost-dlq.fifo
```

Example Body:

```
[
  {
    "body": {
      "orderId": "12345",
      "customerName": "John Doe Top",
      "shippingAddress": "123 Main St, City, Country",
      "items": [
        {
          "itemId": "item1",
          "itemName": "T-shirt",
          "quantity": 2,
          "unitPrice": 15.99
        }
      ],
      "totalAmount": 61.97
    },
    "messageAttributes": {
      "retryCount": {
        "dataType": "Number",
        "stringValue": "3"
      },
      "errorCode": {
        "dataType": "String",
        "stringValue": "404"
      },
      "errorMessage": {
        "dataType": "String",
        "stringValue": "Order not found"
      },
      "msgRetriable": {
        "dataType": "String",
        "stringValue": "false"
      }
    }
  }
]
```

You can find a bigger example payload in the Hoppscotch collection or you can use ChatGPT to generate one.

## GET: /Queue/Purge/{queueName}

Purge messages from the specified {queueName} SQS queue.

Example URI Parameter:

```
ghost-dlq.fifo
```

## POST: /Queue/Delete/{queueName}

Delete (From the first 10) messages (Maximum 10) from the specified {queueName} SQS queue. The body of this request is an Array of Strings which represents the message "id" of an SQS message. It is validated against the "/src/main/resources/schemas/delete-queue-msg.json" JSON schema.

Example URI Parameter:

```
ghost-dlq.fifo
```

Example Body:

```
[
  "7dd850b4-67fa-4941-a669-965ebe3e350a",
  "baf50e51-d09d-4ffc-9b73-6f7b5ca60018",
  "15f2521f-d4d8-4411-a23d-ad8b8941dd28"
]
```

## POST: /Queue/Transfer

Transfers (From the first 10) messages (Maximum 10) from the specified "srcQueue" (Query Parameter) SQS queue to the specified "destQueue" (Query Parameter) SQS queue. Under the hood, it deletes the messages from the source SQS queue and sends them to the destination SQS queue. The body of this request is an Array of Strings, which represents the message "id" of an SQS message. It is validated against the "/src/main/resources/schemas/transfer-queue-msg.json" JSON schema.

Example Query Parameters:

```
srcQueue: ghost-dlq.fifo
destQueue: graveyard-dlq.fifo
```

Example Body:

```
[
  "7dd850b4-67fa-4941-a669-965ebe3e350a",
  "baf50e51-d09d-4ffc-9b73-6f7b5ca60018",
  "15f2521f-d4d8-4411-a23d-ad8b8941dd28"
]
```

___

### Important Note:

I would recommend setting the Visibility Timeout of the SQS Queues to approximately 3-5 seconds in AWS Console. The reason for this is to account for the operation of the 'POST: /Queue/Delete/{queueName}' and 'POST: /Queue/Transfer' endpoints.\
This also implies that consecutive requests made to fetch the approximate number of messages in the queue or to read the messages from the queue should also be made with a gap of 3-5 seconds.

___

### Supporting links:

[Blog Article](https://www.loveleshkalonia.com/2024/06/dlq-dashboard-using-react-js-and-mulesoft.html)

[Demo Video](https://www.youtube.com/watch?v=4r01T9vfdx8)
