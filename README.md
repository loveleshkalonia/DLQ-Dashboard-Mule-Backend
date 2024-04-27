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

You can find sample API Requests collection to test here: "/hoppscotch-collection/DLQ-Dashboard-Mule-Backend.json"

Available endpoints:

## GET: /Queue/Active

Fetch all active SQS queues whose name contains the "-dlq" string.

## GET: /Queue/{queueName}

Read first 10 messages from the specified {queueName} sqs queue. Example URI parameter: "ghost-dlq.fifo"

## POST: /Queue/{queueName}

Push messages to the specified {queueName} sqs queue. Example URI parameter: "ghost-dlq.fifo"
The body for this request is validated against the "/src/main/resources/schemas/post-queue-msg.json" JSON schema. You can also find an example payload in the Hoppscotch collection.
