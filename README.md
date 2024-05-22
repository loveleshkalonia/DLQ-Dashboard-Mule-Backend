# DLQ-Dashboard-Mule-Backend

This Mule API is used by the DLQ-Dashboard-Frontend React App or the User to perform basic SQS operations. This code is designed to work with FIFO SQS Queues strictly because reading messages from a Standard SQS Queue is trouble (Learn more [here](https://help.salesforce.com/s/articleView?id=001119110&type=1)).

One can easily import the code into AnypointStudio and run it directly. All dependencies are publicly available, i.e., no private repositories are referred to in this project. Instead of using an APIKit Router with a RAML specification, this code contains multiple HTTP Listeners.\
Before you run, you must either edit the "/src/main/resources/properties/dev.yaml" property file or use VM arguments to override some properties.

VM arguments example:

-Daws.role.arn=arn:aws:iam::XXXXXXXXXXX:role/dlq-mule-backend-iam-role\
-Daws.access.key=XXXXXXXXXXXXXXXXXXXX\
-Daws.secret.key=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX\
-Daws.region=us-east-1\
-Dmule.env=dev

If you need help setting up an AWS IAM Role to run this code locally, click [here](https://www.loveleshkalonia.com/2023/08/role-based-aws-setup-for-mulesoft-s3-connectors-on-new-object-component.html#:~:text=and%20Private%20Space.-,Local%20Run%20Setup,-As%20previously%20mentioned).

You can find sample API Requests collection to test here: "/hoppscotch-collection/DLQ-Dashboard-Mule-Backend.json".

Available endpoints:

## GET: /Queue/Active

Fetch all active SQS queues whose name contains the "-dlq" string.

## GET: /Queue/{queueName}

Read first 10 (Maximum) messages from the specified {queueName} SQS queue. Example URI parameter: "ghost-dlq.fifo".

## POST: /Queue/{queueName}

Push messages to the specified {queueName} SQS queue. Example URI parameter: "ghost-dlq.fifo".\
The body for this request is a JSON Array of messages. It is validated against the "/src/main/resources/schemas/post-queue-msg.json" JSON schema.\
You can find an example payload in the Hoppscotch collection.

## GET: /Queue/Purge/{queueName}

Purge messages from the specified {queueName} SQS queue. Example URI parameter: "ghost-dlq.fifo".

## POST: /Queue/Delete/{queueName}

Delete (From the first 10) messages (Maximum 10) from the specified {queueName} SQS queue. Example URI parameter: "ghost-dlq.fifo".\
The body for this request is an Array of Strings which represensts message "id" of an SQS message. It is validated against the "/src/main/resources/schemas/delete-queue-msg.json" JSON schema.\
You can find an example payload in the Hoppscotch collection.

## POST: /Queue/Transfer

Transfers (From the first 10) messages (Maximum 10) from the specified "srcQueue" (Query Parameter) SQS queue to specified "destQueue" (Query Parameter) SQS queue. Under the hood, it deletes the messages from "srcQueue" SQS queue and sends them to the "destQueue" SQS queue.\
The body for this request is an Array of Strings which represensts message "id" of an SQS message. It is validated against the "/src/main/resources/schemas/transfer-queue-msg.json" JSON schema.\
You can find an example payload in the Hoppscotch collection.

### Important Note:

I would recommend setting the Visibility Timeout to approximately 3-5 seconds. The reason for this is to account for the operation of the 'POST: /Queue/Delete/{queueName}' endpoint. This also implies that consecutive requests made to fetch the approximate number of messages in the queue or to read the messages from the queue should also be made with a gap of 3-5 seconds.