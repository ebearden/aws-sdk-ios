//
// Copyright 2010-2019 Amazon.com, Inc. or its affiliates. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License").
// You may not use this file except in compliance with the License.
// A copy of the License is located at
//
// http://aws.amazon.com/apache2.0
//
// or in the "license" file accompanying this file. This file is distributed
// on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
// express or implied. See the License for the specific language governing
// permissions and limitations under the License.
//

#import "AWSFirehoseResources.h"
#import <AWSCore/AWSCocoaLumberjack.h>

@interface AWSFirehoseResources ()

@property (nonatomic, strong) NSDictionary *definitionDictionary;

@end

@implementation AWSFirehoseResources

+ (instancetype)sharedInstance {
    static AWSFirehoseResources *_sharedResources = nil;
    static dispatch_once_t once_token;

    dispatch_once(&once_token, ^{
        _sharedResources = [AWSFirehoseResources new];
    });

    return _sharedResources;
}

- (NSDictionary *)JSONObject {
    return self.definitionDictionary;
}

- (instancetype)init {
    if (self = [super init]) {
        //init method
        NSError *error = nil;
        _definitionDictionary = [NSJSONSerialization JSONObjectWithData:[[self definitionString] dataUsingEncoding:NSUTF8StringEncoding]
                                                                options:kNilOptions
                                                                  error:&error];
        if (_definitionDictionary == nil) {
            if (error) {
                AWSDDLogError(@"Failed to parse JSON service definition: %@",error);
            }
        }
    }
    return self;
}

- (NSString *)definitionString {
    return @"{\
  \"version\":\"2.0\",\
  \"metadata\":{\
    \"apiVersion\":\"2015-08-04\",\
    \"endpointPrefix\":\"firehose\",\
    \"jsonVersion\":\"1.1\",\
    \"protocol\":\"json\",\
    \"serviceAbbreviation\":\"Firehose\",\
    \"serviceFullName\":\"Amazon Kinesis Firehose\",\
    \"serviceId\":\"Firehose\",\
    \"signatureVersion\":\"v4\",\
    \"targetPrefix\":\"Firehose_20150804\",\
    \"uid\":\"firehose-2015-08-04\"\
  },\
  \"operations\":{\
    \"CreateDeliveryStream\":{\
      \"name\":\"CreateDeliveryStream\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"CreateDeliveryStreamInput\"},\
      \"output\":{\"shape\":\"CreateDeliveryStreamOutput\"},\
      \"errors\":[\
        {\"shape\":\"InvalidArgumentException\"},\
        {\"shape\":\"LimitExceededException\"},\
        {\"shape\":\"ResourceInUseException\"}\
      ],\
      \"documentation\":\"<p>Creates a Kinesis Data Firehose delivery stream.</p> <p>By default, you can create up to 50 delivery streams per AWS Region.</p> <p>This is an asynchronous operation that immediately returns. The initial status of the delivery stream is <code>CREATING</code>. After the delivery stream is created, its status is <code>ACTIVE</code> and it now accepts data. Attempts to send data to a delivery stream that is not in the <code>ACTIVE</code> state cause an exception. To check the state of a delivery stream, use <a>DescribeDeliveryStream</a>.</p> <p>A Kinesis Data Firehose delivery stream can be configured to receive records directly from providers using <a>PutRecord</a> or <a>PutRecordBatch</a>, or it can be configured to use an existing Kinesis stream as its source. To specify a Kinesis data stream as input, set the <code>DeliveryStreamType</code> parameter to <code>KinesisStreamAsSource</code>, and provide the Kinesis stream Amazon Resource Name (ARN) and role ARN in the <code>KinesisStreamSourceConfiguration</code> parameter.</p> <p>A delivery stream is configured with a single destination: Amazon S3, Amazon ES, Amazon Redshift, or Splunk. You must specify only one of the following destination configuration parameters: <code>ExtendedS3DestinationConfiguration</code>, <code>S3DestinationConfiguration</code>, <code>ElasticsearchDestinationConfiguration</code>, <code>RedshiftDestinationConfiguration</code>, or <code>SplunkDestinationConfiguration</code>.</p> <p>When you specify <code>S3DestinationConfiguration</code>, you can also provide the following optional values: BufferingHints, <code>EncryptionConfiguration</code>, and <code>CompressionFormat</code>. By default, if no <code>BufferingHints</code> value is provided, Kinesis Data Firehose buffers data up to 5 MB or for 5 minutes, whichever condition is satisfied first. <code>BufferingHints</code> is a hint, so there are some cases where the service cannot adhere to these conditions strictly. For example, record boundaries might be such that the size is a little over or under the configured buffering size. By default, no encryption is performed. We strongly recommend that you enable encryption to ensure secure data storage in Amazon S3.</p> <p>A few notes about Amazon Redshift as a destination:</p> <ul> <li> <p>An Amazon Redshift destination requires an S3 bucket as intermediate location. Kinesis Data Firehose first delivers data to Amazon S3 and then uses <code>COPY</code> syntax to load data into an Amazon Redshift table. This is specified in the <code>RedshiftDestinationConfiguration.S3Configuration</code> parameter.</p> </li> <li> <p>The compression formats <code>SNAPPY</code> or <code>ZIP</code> cannot be specified in <code>RedshiftDestinationConfiguration.S3Configuration</code> because the Amazon Redshift <code>COPY</code> operation that reads from the S3 bucket doesn't support these compression formats.</p> </li> <li> <p>We strongly recommend that you use the user name and password you provide exclusively with Kinesis Data Firehose, and that the permissions for the account are restricted for Amazon Redshift <code>INSERT</code> permissions.</p> </li> </ul> <p>Kinesis Data Firehose assumes the IAM role that is configured as part of the destination. The role should allow the Kinesis Data Firehose principal to assume the role, and the role should have permissions that allow the service to deliver the data. For more information, see <a href=\\\"https://docs.aws.amazon.com/firehose/latest/dev/controlling-access.html#using-iam-s3\\\">Grant Kinesis Data Firehose Access to an Amazon S3 Destination</a> in the <i>Amazon Kinesis Data Firehose Developer Guide</i>.</p>\"\
    },\
    \"DeleteDeliveryStream\":{\
      \"name\":\"DeleteDeliveryStream\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"DeleteDeliveryStreamInput\"},\
      \"output\":{\"shape\":\"DeleteDeliveryStreamOutput\"},\
      \"errors\":[\
        {\"shape\":\"ResourceInUseException\"},\
        {\"shape\":\"ResourceNotFoundException\"}\
      ],\
      \"documentation\":\"<p>Deletes a delivery stream and its data.</p> <p>You can delete a delivery stream only if it is in <code>ACTIVE</code> or <code>DELETING</code> state, and not in the <code>CREATING</code> state. While the deletion request is in process, the delivery stream is in the <code>DELETING</code> state.</p> <p>To check the state of a delivery stream, use <a>DescribeDeliveryStream</a>.</p> <p>While the delivery stream is <code>DELETING</code> state, the service might continue to accept the records, but it doesn't make any guarantees with respect to delivering the data. Therefore, as a best practice, you should first stop any applications that are sending records before deleting a delivery stream.</p>\"\
    },\
    \"DescribeDeliveryStream\":{\
      \"name\":\"DescribeDeliveryStream\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"DescribeDeliveryStreamInput\"},\
      \"output\":{\"shape\":\"DescribeDeliveryStreamOutput\"},\
      \"errors\":[\
        {\"shape\":\"ResourceNotFoundException\"}\
      ],\
      \"documentation\":\"<p>Describes the specified delivery stream and gets the status. For example, after your delivery stream is created, call <code>DescribeDeliveryStream</code> to see whether the delivery stream is <code>ACTIVE</code> and therefore ready for data to be sent to it.</p>\"\
    },\
    \"ListDeliveryStreams\":{\
      \"name\":\"ListDeliveryStreams\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"ListDeliveryStreamsInput\"},\
      \"output\":{\"shape\":\"ListDeliveryStreamsOutput\"},\
      \"documentation\":\"<p>Lists your delivery streams in alphabetical order of their names.</p> <p>The number of delivery streams might be too large to return using a single call to <code>ListDeliveryStreams</code>. You can limit the number of delivery streams returned, using the <code>Limit</code> parameter. To determine whether there are more delivery streams to list, check the value of <code>HasMoreDeliveryStreams</code> in the output. If there are more delivery streams to list, you can request them by calling this operation again and setting the <code>ExclusiveStartDeliveryStreamName</code> parameter to the name of the last delivery stream returned in the last call.</p>\"\
    },\
    \"ListTagsForDeliveryStream\":{\
      \"name\":\"ListTagsForDeliveryStream\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"ListTagsForDeliveryStreamInput\"},\
      \"output\":{\"shape\":\"ListTagsForDeliveryStreamOutput\"},\
      \"errors\":[\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"InvalidArgumentException\"},\
        {\"shape\":\"LimitExceededException\"}\
      ],\
      \"documentation\":\"<p>Lists the tags for the specified delivery stream. This operation has a limit of five transactions per second per account. </p>\"\
    },\
    \"PutRecord\":{\
      \"name\":\"PutRecord\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"PutRecordInput\"},\
      \"output\":{\"shape\":\"PutRecordOutput\"},\
      \"errors\":[\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"InvalidArgumentException\"},\
        {\"shape\":\"ServiceUnavailableException\"}\
      ],\
      \"documentation\":\"<p>Writes a single data record into an Amazon Kinesis Data Firehose delivery stream. To write multiple data records into a delivery stream, use <a>PutRecordBatch</a>. Applications using these operations are referred to as producers.</p> <p>By default, each delivery stream can take in up to 2,000 transactions per second, 5,000 records per second, or 5 MB per second. If you use <a>PutRecord</a> and <a>PutRecordBatch</a>, the limits are an aggregate across these two operations for each delivery stream. For more information about limits and how to request an increase, see <a href=\\\"https://docs.aws.amazon.com/firehose/latest/dev/limits.html\\\">Amazon Kinesis Data Firehose Limits</a>. </p> <p>You must specify the name of the delivery stream and the data record when using <a>PutRecord</a>. The data record consists of a data blob that can be up to 1,000 KB in size, and any kind of data. For example, it can be a segment from a log file, geographic location data, website clickstream data, and so on.</p> <p>Kinesis Data Firehose buffers records before delivering them to the destination. To disambiguate the data blobs at the destination, a common solution is to use delimiters in the data, such as a newline (<code>\\\\n</code>) or some other character unique within the data. This allows the consumer application to parse individual data items when reading the data from the destination.</p> <p>The <code>PutRecord</code> operation returns a <code>RecordId</code>, which is a unique string assigned to each record. Producer applications can use this ID for purposes such as auditability and investigation.</p> <p>If the <code>PutRecord</code> operation throws a <code>ServiceUnavailableException</code>, back off and retry. If the exception persists, it is possible that the throughput limits have been exceeded for the delivery stream. </p> <p>Data records sent to Kinesis Data Firehose are stored for 24 hours from the time they are added to a delivery stream as it tries to send the records to the destination. If the destination is unreachable for more than 24 hours, the data is no longer available.</p> <important> <p>Don't concatenate two or more base64 strings to form the data fields of your records. Instead, concatenate the raw data, then perform base64 encoding.</p> </important>\"\
    },\
    \"PutRecordBatch\":{\
      \"name\":\"PutRecordBatch\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"PutRecordBatchInput\"},\
      \"output\":{\"shape\":\"PutRecordBatchOutput\"},\
      \"errors\":[\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"InvalidArgumentException\"},\
        {\"shape\":\"ServiceUnavailableException\"}\
      ],\
      \"documentation\":\"<p>Writes multiple data records into a delivery stream in a single call, which can achieve higher throughput per producer than when writing single records. To write single data records into a delivery stream, use <a>PutRecord</a>. Applications using these operations are referred to as producers.</p> <p>By default, each delivery stream can take in up to 2,000 transactions per second, 5,000 records per second, or 5 MB per second. If you use <a>PutRecord</a> and <a>PutRecordBatch</a>, the limits are an aggregate across these two operations for each delivery stream. For more information about limits, see <a href=\\\"https://docs.aws.amazon.com/firehose/latest/dev/limits.html\\\">Amazon Kinesis Data Firehose Limits</a>.</p> <p>Each <a>PutRecordBatch</a> request supports up to 500 records. Each record in the request can be as large as 1,000 KB (before 64-bit encoding), up to a limit of 4 MB for the entire request. These limits cannot be changed.</p> <p>You must specify the name of the delivery stream and the data record when using <a>PutRecord</a>. The data record consists of a data blob that can be up to 1,000 KB in size, and any kind of data. For example, it could be a segment from a log file, geographic location data, website clickstream data, and so on.</p> <p>Kinesis Data Firehose buffers records before delivering them to the destination. To disambiguate the data blobs at the destination, a common solution is to use delimiters in the data, such as a newline (<code>\\\\n</code>) or some other character unique within the data. This allows the consumer application to parse individual data items when reading the data from the destination.</p> <p>The <a>PutRecordBatch</a> response includes a count of failed records, <code>FailedPutCount</code>, and an array of responses, <code>RequestResponses</code>. Even if the <a>PutRecordBatch</a> call succeeds, the value of <code>FailedPutCount</code> may be greater than 0, indicating that there are records for which the operation didn't succeed. Each entry in the <code>RequestResponses</code> array provides additional information about the processed record. It directly correlates with a record in the request array using the same ordering, from the top to the bottom. The response array always includes the same number of records as the request array. <code>RequestResponses</code> includes both successfully and unsuccessfully processed records. Kinesis Data Firehose tries to process all records in each <a>PutRecordBatch</a> request. A single record failure does not stop the processing of subsequent records. </p> <p>A successfully processed record includes a <code>RecordId</code> value, which is unique for the record. An unsuccessfully processed record includes <code>ErrorCode</code> and <code>ErrorMessage</code> values. <code>ErrorCode</code> reflects the type of error, and is one of the following values: <code>ServiceUnavailableException</code> or <code>InternalFailure</code>. <code>ErrorMessage</code> provides more detailed information about the error.</p> <p>If there is an internal server error or a timeout, the write might have completed or it might have failed. If <code>FailedPutCount</code> is greater than 0, retry the request, resending only those records that might have failed processing. This minimizes the possible duplicate records and also reduces the total bytes sent (and corresponding charges). We recommend that you handle any duplicates at the destination.</p> <p>If <a>PutRecordBatch</a> throws <code>ServiceUnavailableException</code>, back off and retry. If the exception persists, it is possible that the throughput limits have been exceeded for the delivery stream.</p> <p>Data records sent to Kinesis Data Firehose are stored for 24 hours from the time they are added to a delivery stream as it attempts to send the records to the destination. If the destination is unreachable for more than 24 hours, the data is no longer available.</p> <important> <p>Don't concatenate two or more base64 strings to form the data fields of your records. Instead, concatenate the raw data, then perform base64 encoding.</p> </important>\"\
    },\
    \"StartDeliveryStreamEncryption\":{\
      \"name\":\"StartDeliveryStreamEncryption\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"StartDeliveryStreamEncryptionInput\"},\
      \"output\":{\"shape\":\"StartDeliveryStreamEncryptionOutput\"},\
      \"errors\":[\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"ResourceInUseException\"},\
        {\"shape\":\"InvalidArgumentException\"},\
        {\"shape\":\"LimitExceededException\"}\
      ],\
      \"documentation\":\"<p>Enables server-side encryption (SSE) for the delivery stream. </p> <p>This operation is asynchronous. It returns immediately. When you invoke it, Kinesis Data Firehose first sets the status of the stream to <code>ENABLING</code>, and then to <code>ENABLED</code>. You can continue to read and write data to your stream while its status is <code>ENABLING</code>, but the data is not encrypted. It can take up to 5 seconds after the encryption status changes to <code>ENABLED</code> before all records written to the delivery stream are encrypted. To find out whether a record or a batch of records was encrypted, check the response elements <a>PutRecordOutput$Encrypted</a> and <a>PutRecordBatchOutput$Encrypted</a>, respectively.</p> <p>To check the encryption state of a delivery stream, use <a>DescribeDeliveryStream</a>.</p> <p>You can only enable SSE for a delivery stream that uses <code>DirectPut</code> as its source. </p> <p>The <code>StartDeliveryStreamEncryption</code> and <code>StopDeliveryStreamEncryption</code> operations have a combined limit of 25 calls per delivery stream per 24 hours. For example, you reach the limit if you call <code>StartDeliveryStreamEncryption</code> 13 times and <code>StopDeliveryStreamEncryption</code> 12 times for the same delivery stream in a 24-hour period.</p>\"\
    },\
    \"StopDeliveryStreamEncryption\":{\
      \"name\":\"StopDeliveryStreamEncryption\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"StopDeliveryStreamEncryptionInput\"},\
      \"output\":{\"shape\":\"StopDeliveryStreamEncryptionOutput\"},\
      \"errors\":[\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"ResourceInUseException\"},\
        {\"shape\":\"InvalidArgumentException\"},\
        {\"shape\":\"LimitExceededException\"}\
      ],\
      \"documentation\":\"<p>Disables server-side encryption (SSE) for the delivery stream. </p> <p>This operation is asynchronous. It returns immediately. When you invoke it, Kinesis Data Firehose first sets the status of the stream to <code>DISABLING</code>, and then to <code>DISABLED</code>. You can continue to read and write data to your stream while its status is <code>DISABLING</code>. It can take up to 5 seconds after the encryption status changes to <code>DISABLED</code> before all records written to the delivery stream are no longer subject to encryption. To find out whether a record or a batch of records was encrypted, check the response elements <a>PutRecordOutput$Encrypted</a> and <a>PutRecordBatchOutput$Encrypted</a>, respectively.</p> <p>To check the encryption state of a delivery stream, use <a>DescribeDeliveryStream</a>. </p> <p>The <code>StartDeliveryStreamEncryption</code> and <code>StopDeliveryStreamEncryption</code> operations have a combined limit of 25 calls per delivery stream per 24 hours. For example, you reach the limit if you call <code>StartDeliveryStreamEncryption</code> 13 times and <code>StopDeliveryStreamEncryption</code> 12 times for the same delivery stream in a 24-hour period.</p>\"\
    },\
    \"TagDeliveryStream\":{\
      \"name\":\"TagDeliveryStream\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"TagDeliveryStreamInput\"},\
      \"output\":{\"shape\":\"TagDeliveryStreamOutput\"},\
      \"errors\":[\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"ResourceInUseException\"},\
        {\"shape\":\"InvalidArgumentException\"},\
        {\"shape\":\"LimitExceededException\"}\
      ],\
      \"documentation\":\"<p>Adds or updates tags for the specified delivery stream. A tag is a key-value pair that you can define and assign to AWS resources. If you specify a tag that already exists, the tag value is replaced with the value that you specify in the request. Tags are metadata. For example, you can add friendly names and descriptions or other types of information that can help you distinguish the delivery stream. For more information about tags, see <a href=\\\"https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/cost-alloc-tags.html\\\">Using Cost Allocation Tags</a> in the <i>AWS Billing and Cost Management User Guide</i>. </p> <p>Each delivery stream can have up to 50 tags. </p> <p>This operation has a limit of five transactions per second per account. </p>\"\
    },\
    \"UntagDeliveryStream\":{\
      \"name\":\"UntagDeliveryStream\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"UntagDeliveryStreamInput\"},\
      \"output\":{\"shape\":\"UntagDeliveryStreamOutput\"},\
      \"errors\":[\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"ResourceInUseException\"},\
        {\"shape\":\"InvalidArgumentException\"},\
        {\"shape\":\"LimitExceededException\"}\
      ],\
      \"documentation\":\"<p>Removes tags from the specified delivery stream. Removed tags are deleted, and you can't recover them after this operation successfully completes.</p> <p>If you specify a tag that doesn't exist, the operation ignores it.</p> <p>This operation has a limit of five transactions per second per account. </p>\"\
    },\
    \"UpdateDestination\":{\
      \"name\":\"UpdateDestination\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"UpdateDestinationInput\"},\
      \"output\":{\"shape\":\"UpdateDestinationOutput\"},\
      \"errors\":[\
        {\"shape\":\"InvalidArgumentException\"},\
        {\"shape\":\"ResourceInUseException\"},\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"ConcurrentModificationException\"}\
      ],\
      \"documentation\":\"<p>Updates the specified destination of the specified delivery stream.</p> <p>Use this operation to change the destination type (for example, to replace the Amazon S3 destination with Amazon Redshift) or change the parameters associated with a destination (for example, to change the bucket name of the Amazon S3 destination). The update might not occur immediately. The target delivery stream remains active while the configurations are updated, so data writes to the delivery stream can continue during this process. The updated configurations are usually effective within a few minutes.</p> <p>Switching between Amazon ES and other services is not supported. For an Amazon ES destination, you can only update to another Amazon ES destination.</p> <p>If the destination type is the same, Kinesis Data Firehose merges the configuration parameters specified with the destination configuration that already exists on the delivery stream. If any of the parameters are not specified in the call, the existing values are retained. For example, in the Amazon S3 destination, if <a>EncryptionConfiguration</a> is not specified, then the existing <code>EncryptionConfiguration</code> is maintained on the destination.</p> <p>If the destination type is not the same, for example, changing the destination from Amazon S3 to Amazon Redshift, Kinesis Data Firehose does not merge any parameters. In this case, all parameters must be specified.</p> <p>Kinesis Data Firehose uses <code>CurrentDeliveryStreamVersionId</code> to avoid race conditions and conflicting merges. This is a required field, and the service updates the configuration only if the existing configuration has a version ID that matches. After the update is applied successfully, the version ID is updated, and can be retrieved using <a>DescribeDeliveryStream</a>. Use the new version ID to set <code>CurrentDeliveryStreamVersionId</code> in the next call.</p>\"\
    }\
  },\
  \"shapes\":{\
    \"AWSKMSKeyARN\":{\
      \"type\":\"string\",\
      \"max\":512,\
      \"min\":1,\
      \"pattern\":\"arn:.*\"\
    },\
    \"BlockSizeBytes\":{\
      \"type\":\"integer\",\
      \"min\":67108864\
    },\
    \"BooleanObject\":{\"type\":\"boolean\"},\
    \"BucketARN\":{\
      \"type\":\"string\",\
      \"max\":2048,\
      \"min\":1,\
      \"pattern\":\"arn:.*\"\
    },\
    \"BufferingHints\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"SizeInMBs\":{\
          \"shape\":\"SizeInMBs\",\
          \"documentation\":\"<p>Buffer incoming data to the specified size, in MiBs, before delivering it to the destination. The default value is 5. This parameter is optional but if you specify a value for it, you must also specify a value for <code>IntervalInSeconds</code>, and vice versa.</p> <p>We recommend setting this parameter to a value greater than the amount of data you typically ingest into the delivery stream in 10 seconds. For example, if you typically ingest data at 1 MiB/sec, the value should be 10 MiB or higher.</p>\"\
        },\
        \"IntervalInSeconds\":{\
          \"shape\":\"IntervalInSeconds\",\
          \"documentation\":\"<p>Buffer incoming data for the specified period of time, in seconds, before delivering it to the destination. The default value is 300. This parameter is optional but if you specify a value for it, you must also specify a value for <code>SizeInMBs</code>, and vice versa.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Describes hints for the buffering to perform before delivering data to the destination. These options are treated as hints, and therefore Kinesis Data Firehose might choose to use different values when it is optimal. The <code>SizeInMBs</code> and <code>IntervalInSeconds</code> parameters are optional. However, if specify a value for one of them, you must also provide a value for the other.</p>\"\
    },\
    \"CloudWatchLoggingOptions\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Enabled\":{\
          \"shape\":\"BooleanObject\",\
          \"documentation\":\"<p>Enables or disables CloudWatch logging.</p>\"\
        },\
        \"LogGroupName\":{\
          \"shape\":\"LogGroupName\",\
          \"documentation\":\"<p>The CloudWatch group name for logging. This value is required if CloudWatch logging is enabled.</p>\"\
        },\
        \"LogStreamName\":{\
          \"shape\":\"LogStreamName\",\
          \"documentation\":\"<p>The CloudWatch log stream name for logging. This value is required if CloudWatch logging is enabled.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Describes the Amazon CloudWatch logging options for your delivery stream.</p>\"\
    },\
    \"ClusterJDBCURL\":{\
      \"type\":\"string\",\
      \"min\":1,\
      \"pattern\":\"jdbc:(redshift|postgresql)://((?!-)[A-Za-z0-9-]{1,63}(?<!-)\\\\.)+redshift\\\\.([a-zA-Z0-9\\\\.]+):\\\\d{1,5}/[a-zA-Z0-9_$]+\"\
    },\
    \"ColumnToJsonKeyMappings\":{\
      \"type\":\"map\",\
      \"key\":{\"shape\":\"NonEmptyStringWithoutWhitespace\"},\
      \"value\":{\"shape\":\"NonEmptyString\"}\
    },\
    \"CompressionFormat\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"UNCOMPRESSED\",\
        \"GZIP\",\
        \"ZIP\",\
        \"Snappy\"\
      ]\
    },\
    \"ConcurrentModificationException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\
          \"shape\":\"ErrorMessage\",\
          \"documentation\":\"<p>A message that provides information about the error.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Another modification has already happened. Fetch <code>VersionId</code> again and use it to update the destination.</p>\",\
      \"exception\":true\
    },\
    \"CopyCommand\":{\
      \"type\":\"structure\",\
      \"required\":[\"DataTableName\"],\
      \"members\":{\
        \"DataTableName\":{\
          \"shape\":\"DataTableName\",\
          \"documentation\":\"<p>The name of the target table. The table must already exist in the database.</p>\"\
        },\
        \"DataTableColumns\":{\
          \"shape\":\"DataTableColumns\",\
          \"documentation\":\"<p>A comma-separated list of column names.</p>\"\
        },\
        \"CopyOptions\":{\
          \"shape\":\"CopyOptions\",\
          \"documentation\":\"<p>Optional parameters to use with the Amazon Redshift <code>COPY</code> command. For more information, see the \\\"Optional Parameters\\\" section of <a href=\\\"https://docs.aws.amazon.com/redshift/latest/dg/r_COPY.html\\\">Amazon Redshift COPY command</a>. Some possible examples that would apply to Kinesis Data Firehose are as follows:</p> <p> <code>delimiter '\\\\t' lzop;</code> - fields are delimited with \\\"\\\\t\\\" (TAB character) and compressed using lzop.</p> <p> <code>delimiter '|'</code> - fields are delimited with \\\"|\\\" (this is the default delimiter).</p> <p> <code>delimiter '|' escape</code> - the delimiter should be escaped.</p> <p> <code>fixedwidth 'venueid:3,venuename:25,venuecity:12,venuestate:2,venueseats:6'</code> - fields are fixed width in the source, with each width specified after every column in the table.</p> <p> <code>JSON 's3://mybucket/jsonpaths.txt'</code> - data is in JSON format, and the path specified is the format of the data.</p> <p>For more examples, see <a href=\\\"https://docs.aws.amazon.com/redshift/latest/dg/r_COPY_command_examples.html\\\">Amazon Redshift COPY command examples</a>.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Describes a <code>COPY</code> command for Amazon Redshift.</p>\"\
    },\
    \"CopyOptions\":{\"type\":\"string\"},\
    \"CreateDeliveryStreamInput\":{\
      \"type\":\"structure\",\
      \"required\":[\"DeliveryStreamName\"],\
      \"members\":{\
        \"DeliveryStreamName\":{\
          \"shape\":\"DeliveryStreamName\",\
          \"documentation\":\"<p>The name of the delivery stream. This name must be unique per AWS account in the same AWS Region. If the delivery streams are in different accounts or different Regions, you can have multiple delivery streams with the same name.</p>\"\
        },\
        \"DeliveryStreamType\":{\
          \"shape\":\"DeliveryStreamType\",\
          \"documentation\":\"<p>The delivery stream type. This parameter can be one of the following values:</p> <ul> <li> <p> <code>DirectPut</code>: Provider applications access the delivery stream directly.</p> </li> <li> <p> <code>KinesisStreamAsSource</code>: The delivery stream uses a Kinesis data stream as a source.</p> </li> </ul>\"\
        },\
        \"KinesisStreamSourceConfiguration\":{\
          \"shape\":\"KinesisStreamSourceConfiguration\",\
          \"documentation\":\"<p>When a Kinesis data stream is used as the source for the delivery stream, a <a>KinesisStreamSourceConfiguration</a> containing the Kinesis data stream Amazon Resource Name (ARN) and the role ARN for the source stream.</p>\"\
        },\
        \"S3DestinationConfiguration\":{\
          \"shape\":\"S3DestinationConfiguration\",\
          \"documentation\":\"<p>[Deprecated] The destination in Amazon S3. You can specify only one destination.</p>\",\
          \"deprecated\":true\
        },\
        \"ExtendedS3DestinationConfiguration\":{\
          \"shape\":\"ExtendedS3DestinationConfiguration\",\
          \"documentation\":\"<p>The destination in Amazon S3. You can specify only one destination.</p>\"\
        },\
        \"RedshiftDestinationConfiguration\":{\
          \"shape\":\"RedshiftDestinationConfiguration\",\
          \"documentation\":\"<p>The destination in Amazon Redshift. You can specify only one destination.</p>\"\
        },\
        \"ElasticsearchDestinationConfiguration\":{\
          \"shape\":\"ElasticsearchDestinationConfiguration\",\
          \"documentation\":\"<p>The destination in Amazon ES. You can specify only one destination.</p>\"\
        },\
        \"SplunkDestinationConfiguration\":{\
          \"shape\":\"SplunkDestinationConfiguration\",\
          \"documentation\":\"<p>The destination in Splunk. You can specify only one destination.</p>\"\
        },\
        \"Tags\":{\
          \"shape\":\"TagDeliveryStreamInputTagList\",\
          \"documentation\":\"<p>A set of tags to assign to the delivery stream. A tag is a key-value pair that you can define and assign to AWS resources. Tags are metadata. For example, you can add friendly names and descriptions or other types of information that can help you distinguish the delivery stream. For more information about tags, see <a href=\\\"https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/cost-alloc-tags.html\\\">Using Cost Allocation Tags</a> in the AWS Billing and Cost Management User Guide.</p> <p>You can specify up to 50 tags when creating a delivery stream.</p>\"\
        }\
      }\
    },\
    \"CreateDeliveryStreamOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"DeliveryStreamARN\":{\
          \"shape\":\"DeliveryStreamARN\",\
          \"documentation\":\"<p>The ARN of the delivery stream.</p>\"\
        }\
      }\
    },\
    \"Data\":{\
      \"type\":\"blob\",\
      \"max\":1024000,\
      \"min\":0\
    },\
    \"DataFormatConversionConfiguration\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"SchemaConfiguration\":{\
          \"shape\":\"SchemaConfiguration\",\
          \"documentation\":\"<p>Specifies the AWS Glue Data Catalog table that contains the column information.</p>\"\
        },\
        \"InputFormatConfiguration\":{\
          \"shape\":\"InputFormatConfiguration\",\
          \"documentation\":\"<p>Specifies the deserializer that you want Kinesis Data Firehose to use to convert the format of your data from JSON.</p>\"\
        },\
        \"OutputFormatConfiguration\":{\
          \"shape\":\"OutputFormatConfiguration\",\
          \"documentation\":\"<p>Specifies the serializer that you want Kinesis Data Firehose to use to convert the format of your data to the Parquet or ORC format.</p>\"\
        },\
        \"Enabled\":{\
          \"shape\":\"BooleanObject\",\
          \"documentation\":\"<p>Defaults to <code>true</code>. Set it to <code>false</code> if you want to disable format conversion while preserving the configuration details.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Specifies that you want Kinesis Data Firehose to convert data from the JSON format to the Parquet or ORC format before writing it to Amazon S3. Kinesis Data Firehose uses the serializer and deserializer that you specify, in addition to the column information from the AWS Glue table, to deserialize your input data from JSON and then serialize it to the Parquet or ORC format. For more information, see <a href=\\\"https://docs.aws.amazon.com/firehose/latest/dev/record-format-conversion.html\\\">Kinesis Data Firehose Record Format Conversion</a>.</p>\"\
    },\
    \"DataTableColumns\":{\"type\":\"string\"},\
    \"DataTableName\":{\
      \"type\":\"string\",\
      \"min\":1\
    },\
    \"DeleteDeliveryStreamInput\":{\
      \"type\":\"structure\",\
      \"required\":[\"DeliveryStreamName\"],\
      \"members\":{\
        \"DeliveryStreamName\":{\
          \"shape\":\"DeliveryStreamName\",\
          \"documentation\":\"<p>The name of the delivery stream.</p>\"\
        }\
      }\
    },\
    \"DeleteDeliveryStreamOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
      }\
    },\
    \"DeliveryStartTimestamp\":{\"type\":\"timestamp\"},\
    \"DeliveryStreamARN\":{\
      \"type\":\"string\",\
      \"max\":512,\
      \"min\":1,\
      \"pattern\":\"arn:.*\"\
    },\
    \"DeliveryStreamDescription\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"DeliveryStreamName\",\
        \"DeliveryStreamARN\",\
        \"DeliveryStreamStatus\",\
        \"DeliveryStreamType\",\
        \"VersionId\",\
        \"Destinations\",\
        \"HasMoreDestinations\"\
      ],\
      \"members\":{\
        \"DeliveryStreamName\":{\
          \"shape\":\"DeliveryStreamName\",\
          \"documentation\":\"<p>The name of the delivery stream.</p>\"\
        },\
        \"DeliveryStreamARN\":{\
          \"shape\":\"DeliveryStreamARN\",\
          \"documentation\":\"<p>The Amazon Resource Name (ARN) of the delivery stream. For more information, see <a href=\\\"https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html\\\">Amazon Resource Names (ARNs) and AWS Service Namespaces</a>.</p>\"\
        },\
        \"DeliveryStreamStatus\":{\
          \"shape\":\"DeliveryStreamStatus\",\
          \"documentation\":\"<p>The status of the delivery stream.</p>\"\
        },\
        \"DeliveryStreamEncryptionConfiguration\":{\
          \"shape\":\"DeliveryStreamEncryptionConfiguration\",\
          \"documentation\":\"<p>Indicates the server-side encryption (SSE) status for the delivery stream.</p>\"\
        },\
        \"DeliveryStreamType\":{\
          \"shape\":\"DeliveryStreamType\",\
          \"documentation\":\"<p>The delivery stream type. This can be one of the following values:</p> <ul> <li> <p> <code>DirectPut</code>: Provider applications access the delivery stream directly.</p> </li> <li> <p> <code>KinesisStreamAsSource</code>: The delivery stream uses a Kinesis data stream as a source.</p> </li> </ul>\"\
        },\
        \"VersionId\":{\
          \"shape\":\"DeliveryStreamVersionId\",\
          \"documentation\":\"<p>Each time the destination is updated for a delivery stream, the version ID is changed, and the current version ID is required when updating the destination. This is so that the service knows it is applying the changes to the correct version of the delivery stream.</p>\"\
        },\
        \"CreateTimestamp\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The date and time that the delivery stream was created.</p>\"\
        },\
        \"LastUpdateTimestamp\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The date and time that the delivery stream was last updated.</p>\"\
        },\
        \"Source\":{\
          \"shape\":\"SourceDescription\",\
          \"documentation\":\"<p>If the <code>DeliveryStreamType</code> parameter is <code>KinesisStreamAsSource</code>, a <a>SourceDescription</a> object describing the source Kinesis data stream.</p>\"\
        },\
        \"Destinations\":{\
          \"shape\":\"DestinationDescriptionList\",\
          \"documentation\":\"<p>The destinations.</p>\"\
        },\
        \"HasMoreDestinations\":{\
          \"shape\":\"BooleanObject\",\
          \"documentation\":\"<p>Indicates whether there are more destinations available to list.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Contains information about a delivery stream.</p>\"\
    },\
    \"DeliveryStreamEncryptionConfiguration\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Status\":{\
          \"shape\":\"DeliveryStreamEncryptionStatus\",\
          \"documentation\":\"<p>For a full description of the different values of this status, see <a>StartDeliveryStreamEncryption</a> and <a>StopDeliveryStreamEncryption</a>.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Indicates the server-side encryption (SSE) status for the delivery stream.</p>\"\
    },\
    \"DeliveryStreamEncryptionStatus\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"ENABLED\",\
        \"ENABLING\",\
        \"DISABLED\",\
        \"DISABLING\"\
      ]\
    },\
    \"DeliveryStreamName\":{\
      \"type\":\"string\",\
      \"max\":64,\
      \"min\":1,\
      \"pattern\":\"[a-zA-Z0-9_.-]+\"\
    },\
    \"DeliveryStreamNameList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"DeliveryStreamName\"}\
    },\
    \"DeliveryStreamStatus\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"CREATING\",\
        \"DELETING\",\
        \"ACTIVE\"\
      ]\
    },\
    \"DeliveryStreamType\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"DirectPut\",\
        \"KinesisStreamAsSource\"\
      ]\
    },\
    \"DeliveryStreamVersionId\":{\
      \"type\":\"string\",\
      \"max\":50,\
      \"min\":1,\
      \"pattern\":\"[0-9]+\"\
    },\
    \"DescribeDeliveryStreamInput\":{\
      \"type\":\"structure\",\
      \"required\":[\"DeliveryStreamName\"],\
      \"members\":{\
        \"DeliveryStreamName\":{\
          \"shape\":\"DeliveryStreamName\",\
          \"documentation\":\"<p>The name of the delivery stream.</p>\"\
        },\
        \"Limit\":{\
          \"shape\":\"DescribeDeliveryStreamInputLimit\",\
          \"documentation\":\"<p>The limit on the number of destinations to return. You can have one destination per delivery stream.</p>\"\
        },\
        \"ExclusiveStartDestinationId\":{\
          \"shape\":\"DestinationId\",\
          \"documentation\":\"<p>The ID of the destination to start returning the destination information. Kinesis Data Firehose supports one destination per delivery stream.</p>\"\
        }\
      }\
    },\
    \"DescribeDeliveryStreamInputLimit\":{\
      \"type\":\"integer\",\
      \"max\":10000,\
      \"min\":1\
    },\
    \"DescribeDeliveryStreamOutput\":{\
      \"type\":\"structure\",\
      \"required\":[\"DeliveryStreamDescription\"],\
      \"members\":{\
        \"DeliveryStreamDescription\":{\
          \"shape\":\"DeliveryStreamDescription\",\
          \"documentation\":\"<p>Information about the delivery stream.</p>\"\
        }\
      }\
    },\
    \"Deserializer\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"OpenXJsonSerDe\":{\
          \"shape\":\"OpenXJsonSerDe\",\
          \"documentation\":\"<p>The OpenX SerDe. Used by Kinesis Data Firehose for deserializing data, which means converting it from the JSON format in preparation for serializing it to the Parquet or ORC format. This is one of two deserializers you can choose, depending on which one offers the functionality you need. The other option is the native Hive / HCatalog JsonSerDe.</p>\"\
        },\
        \"HiveJsonSerDe\":{\
          \"shape\":\"HiveJsonSerDe\",\
          \"documentation\":\"<p>The native Hive / HCatalog JsonSerDe. Used by Kinesis Data Firehose for deserializing data, which means converting it from the JSON format in preparation for serializing it to the Parquet or ORC format. This is one of two deserializers you can choose, depending on which one offers the functionality you need. The other option is the OpenX SerDe.</p>\"\
        }\
      },\
      \"documentation\":\"<p>The deserializer you want Kinesis Data Firehose to use for converting the input data from JSON. Kinesis Data Firehose then serializes the data to its final format using the <a>Serializer</a>. Kinesis Data Firehose supports two types of deserializers: the <a href=\\\"https://cwiki.apache.org/confluence/display/Hive/LanguageManual+DDL#LanguageManualDDL-JSON\\\">Apache Hive JSON SerDe</a> and the <a href=\\\"https://github.com/rcongiu/Hive-JSON-Serde\\\">OpenX JSON SerDe</a>.</p>\"\
    },\
    \"DestinationDescription\":{\
      \"type\":\"structure\",\
      \"required\":[\"DestinationId\"],\
      \"members\":{\
        \"DestinationId\":{\
          \"shape\":\"DestinationId\",\
          \"documentation\":\"<p>The ID of the destination.</p>\"\
        },\
        \"S3DestinationDescription\":{\
          \"shape\":\"S3DestinationDescription\",\
          \"documentation\":\"<p>[Deprecated] The destination in Amazon S3.</p>\"\
        },\
        \"ExtendedS3DestinationDescription\":{\
          \"shape\":\"ExtendedS3DestinationDescription\",\
          \"documentation\":\"<p>The destination in Amazon S3.</p>\"\
        },\
        \"RedshiftDestinationDescription\":{\
          \"shape\":\"RedshiftDestinationDescription\",\
          \"documentation\":\"<p>The destination in Amazon Redshift.</p>\"\
        },\
        \"ElasticsearchDestinationDescription\":{\
          \"shape\":\"ElasticsearchDestinationDescription\",\
          \"documentation\":\"<p>The destination in Amazon ES.</p>\"\
        },\
        \"SplunkDestinationDescription\":{\
          \"shape\":\"SplunkDestinationDescription\",\
          \"documentation\":\"<p>The destination in Splunk.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Describes the destination for a delivery stream.</p>\"\
    },\
    \"DestinationDescriptionList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"DestinationDescription\"}\
    },\
    \"DestinationId\":{\
      \"type\":\"string\",\
      \"max\":100,\
      \"min\":1\
    },\
    \"ElasticsearchBufferingHints\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"IntervalInSeconds\":{\
          \"shape\":\"ElasticsearchBufferingIntervalInSeconds\",\
          \"documentation\":\"<p>Buffer incoming data for the specified period of time, in seconds, before delivering it to the destination. The default value is 300 (5 minutes).</p>\"\
        },\
        \"SizeInMBs\":{\
          \"shape\":\"ElasticsearchBufferingSizeInMBs\",\
          \"documentation\":\"<p>Buffer incoming data to the specified size, in MBs, before delivering it to the destination. The default value is 5.</p> <p>We recommend setting this parameter to a value greater than the amount of data you typically ingest into the delivery stream in 10 seconds. For example, if you typically ingest data at 1 MB/sec, the value should be 10 MB or higher.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Describes the buffering to perform before delivering data to the Amazon ES destination.</p>\"\
    },\
    \"ElasticsearchBufferingIntervalInSeconds\":{\
      \"type\":\"integer\",\
      \"max\":900,\
      \"min\":60\
    },\
    \"ElasticsearchBufferingSizeInMBs\":{\
      \"type\":\"integer\",\
      \"max\":100,\
      \"min\":1\
    },\
    \"ElasticsearchClusterEndpoint\":{\
      \"type\":\"string\",\
      \"max\":512,\
      \"min\":1,\
      \"pattern\":\"https:.*\"\
    },\
    \"ElasticsearchDestinationConfiguration\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"RoleARN\",\
        \"IndexName\",\
        \"S3Configuration\"\
      ],\
      \"members\":{\
        \"RoleARN\":{\
          \"shape\":\"RoleARN\",\
          \"documentation\":\"<p>The Amazon Resource Name (ARN) of the IAM role to be assumed by Kinesis Data Firehose for calling the Amazon ES Configuration API and for indexing documents. For more information, see <a href=\\\"https://docs.aws.amazon.com/firehose/latest/dev/controlling-access.html#using-iam-s3\\\">Grant Kinesis Data Firehose Access to an Amazon S3 Destination</a> and <a href=\\\"https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html\\\">Amazon Resource Names (ARNs) and AWS Service Namespaces</a>.</p>\"\
        },\
        \"DomainARN\":{\
          \"shape\":\"ElasticsearchDomainARN\",\
          \"documentation\":\"<p>The ARN of the Amazon ES domain. The IAM role must have permissions forÂ <code>DescribeElasticsearchDomain</code>, <code>DescribeElasticsearchDomains</code>, and <code>DescribeElasticsearchDomainConfig</code>Â after assuming the role specified in <b>RoleARN</b>. For more information, see <a href=\\\"https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html\\\">Amazon Resource Names (ARNs) and AWS Service Namespaces</a>.</p> <p>Specify either <code>ClusterEndpoint</code> or <code>DomainARN</code>.</p>\"\
        },\
        \"ClusterEndpoint\":{\
          \"shape\":\"ElasticsearchClusterEndpoint\",\
          \"documentation\":\"<p>The endpoint to use when communicating with the cluster. Specify either this <code>ClusterEndpoint</code> or the <code>DomainARN</code> field.</p>\"\
        },\
        \"IndexName\":{\
          \"shape\":\"ElasticsearchIndexName\",\
          \"documentation\":\"<p>The Elasticsearch index name.</p>\"\
        },\
        \"TypeName\":{\
          \"shape\":\"ElasticsearchTypeName\",\
          \"documentation\":\"<p>The Elasticsearch type name. For Elasticsearch 6.x, there can be only one type per index. If you try to specify a new type for an existing index that already has another type, Kinesis Data Firehose returns an error during run time.</p> <p>For Elasticsearch 7.x, don't specify a <code>TypeName</code>.</p>\"\
        },\
        \"IndexRotationPeriod\":{\
          \"shape\":\"ElasticsearchIndexRotationPeriod\",\
          \"documentation\":\"<p>The Elasticsearch index rotation period. Index rotation appends a timestamp to the <code>IndexName</code> to facilitate the expiration of old data. For more information, see <a href=\\\"https://docs.aws.amazon.com/firehose/latest/dev/basic-deliver.html#es-index-rotation\\\">Index Rotation for the Amazon ES Destination</a>. The default value isÂ <code>OneDay</code>.</p>\"\
        },\
        \"BufferingHints\":{\
          \"shape\":\"ElasticsearchBufferingHints\",\
          \"documentation\":\"<p>The buffering options. If no value is specified, the default values for <code>ElasticsearchBufferingHints</code> are used.</p>\"\
        },\
        \"RetryOptions\":{\
          \"shape\":\"ElasticsearchRetryOptions\",\
          \"documentation\":\"<p>The retry behavior in case Kinesis Data Firehose is unable to deliver documents to Amazon ES. The default value is 300 (5 minutes).</p>\"\
        },\
        \"S3BackupMode\":{\
          \"shape\":\"ElasticsearchS3BackupMode\",\
          \"documentation\":\"<p>Defines how documents should be delivered to Amazon S3. When it is set to <code>FailedDocumentsOnly</code>, Kinesis Data Firehose writes any documents that could not be indexed to the configured Amazon S3 destination, with <code>elasticsearch-failed/</code> appended to the key prefix. When set to <code>AllDocuments</code>, Kinesis Data Firehose delivers all incoming records to Amazon S3, and also writes failed documents with <code>elasticsearch-failed/</code> appended to the prefix. For more information, see <a href=\\\"https://docs.aws.amazon.com/firehose/latest/dev/basic-deliver.html#es-s3-backup\\\">Amazon S3 Backup for the Amazon ES Destination</a>. Default value is <code>FailedDocumentsOnly</code>.</p>\"\
        },\
        \"S3Configuration\":{\
          \"shape\":\"S3DestinationConfiguration\",\
          \"documentation\":\"<p>The configuration for the backup Amazon S3 location.</p>\"\
        },\
        \"ProcessingConfiguration\":{\
          \"shape\":\"ProcessingConfiguration\",\
          \"documentation\":\"<p>The data processing configuration.</p>\"\
        },\
        \"CloudWatchLoggingOptions\":{\
          \"shape\":\"CloudWatchLoggingOptions\",\
          \"documentation\":\"<p>The Amazon CloudWatch logging options for your delivery stream.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Describes the configuration of a destination in Amazon ES.</p>\"\
    },\
    \"ElasticsearchDestinationDescription\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"RoleARN\":{\
          \"shape\":\"RoleARN\",\
          \"documentation\":\"<p>The Amazon Resource Name (ARN) of the AWS credentials. For more information, see <a href=\\\"https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html\\\">Amazon Resource Names (ARNs) and AWS Service Namespaces</a>.</p>\"\
        },\
        \"DomainARN\":{\
          \"shape\":\"ElasticsearchDomainARN\",\
          \"documentation\":\"<p>The ARN of the Amazon ES domain. For more information, see <a href=\\\"https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html\\\">Amazon Resource Names (ARNs) and AWS Service Namespaces</a>.</p> <p>Kinesis Data Firehose uses either <code>ClusterEndpoint</code> or <code>DomainARN</code> to send data to Amazon ES.</p>\"\
        },\
        \"ClusterEndpoint\":{\
          \"shape\":\"ElasticsearchClusterEndpoint\",\
          \"documentation\":\"<p>The endpoint to use when communicating with the cluster. Kinesis Data Firehose uses either this <code>ClusterEndpoint</code> or the <code>DomainARN</code> field to send data to Amazon ES.</p>\"\
        },\
        \"IndexName\":{\
          \"shape\":\"ElasticsearchIndexName\",\
          \"documentation\":\"<p>The Elasticsearch index name.</p>\"\
        },\
        \"TypeName\":{\
          \"shape\":\"ElasticsearchTypeName\",\
          \"documentation\":\"<p>The Elasticsearch type name. This applies to Elasticsearch 6.x and lower versions. For Elasticsearch 7.x, there's no value for <code>TypeName</code>.</p>\"\
        },\
        \"IndexRotationPeriod\":{\
          \"shape\":\"ElasticsearchIndexRotationPeriod\",\
          \"documentation\":\"<p>The Elasticsearch index rotation period</p>\"\
        },\
        \"BufferingHints\":{\
          \"shape\":\"ElasticsearchBufferingHints\",\
          \"documentation\":\"<p>The buffering options.</p>\"\
        },\
        \"RetryOptions\":{\
          \"shape\":\"ElasticsearchRetryOptions\",\
          \"documentation\":\"<p>The Amazon ES retry options.</p>\"\
        },\
        \"S3BackupMode\":{\
          \"shape\":\"ElasticsearchS3BackupMode\",\
          \"documentation\":\"<p>The Amazon S3 backup mode.</p>\"\
        },\
        \"S3DestinationDescription\":{\
          \"shape\":\"S3DestinationDescription\",\
          \"documentation\":\"<p>The Amazon S3 destination.</p>\"\
        },\
        \"ProcessingConfiguration\":{\
          \"shape\":\"ProcessingConfiguration\",\
          \"documentation\":\"<p>The data processing configuration.</p>\"\
        },\
        \"CloudWatchLoggingOptions\":{\
          \"shape\":\"CloudWatchLoggingOptions\",\
          \"documentation\":\"<p>The Amazon CloudWatch logging options.</p>\"\
        }\
      },\
      \"documentation\":\"<p>The destination description in Amazon ES.</p>\"\
    },\
    \"ElasticsearchDestinationUpdate\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"RoleARN\":{\
          \"shape\":\"RoleARN\",\
          \"documentation\":\"<p>The Amazon Resource Name (ARN) of the IAM role to be assumed by Kinesis Data Firehose for calling the Amazon ES Configuration API and for indexing documents. For more information, see <a href=\\\"https://docs.aws.amazon.com/firehose/latest/dev/controlling-access.html#using-iam-s3\\\">Grant Kinesis Data Firehose Access to an Amazon S3 Destination</a> and <a href=\\\"https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html\\\">Amazon Resource Names (ARNs) and AWS Service Namespaces</a>.</p>\"\
        },\
        \"DomainARN\":{\
          \"shape\":\"ElasticsearchDomainARN\",\
          \"documentation\":\"<p>The ARN of the Amazon ES domain. The IAM role must have permissions forÂ <code>DescribeElasticsearchDomain</code>, <code>DescribeElasticsearchDomains</code>, and <code>DescribeElasticsearchDomainConfig</code>Â after assuming the IAM role specified in <code>RoleARN</code>. For more information, see <a href=\\\"https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html\\\">Amazon Resource Names (ARNs) and AWS Service Namespaces</a>.</p> <p>Specify either <code>ClusterEndpoint</code> or <code>DomainARN</code>.</p>\"\
        },\
        \"ClusterEndpoint\":{\
          \"shape\":\"ElasticsearchClusterEndpoint\",\
          \"documentation\":\"<p>The endpoint to use when communicating with the cluster. Specify either this <code>ClusterEndpoint</code> or the <code>DomainARN</code> field.</p>\"\
        },\
        \"IndexName\":{\
          \"shape\":\"ElasticsearchIndexName\",\
          \"documentation\":\"<p>The Elasticsearch index name.</p>\"\
        },\
        \"TypeName\":{\
          \"shape\":\"ElasticsearchTypeName\",\
          \"documentation\":\"<p>The Elasticsearch type name. For Elasticsearch 6.x, there can be only one type per index. If you try to specify a new type for an existing index that already has another type, Kinesis Data Firehose returns an error during runtime.</p> <p>If you upgrade Elasticsearch from 6.x to 7.x and donât update your delivery stream, Kinesis Data Firehose still delivers data to Elasticsearch with the old index name and type name. If you want to update your delivery stream with a new index name, provide an empty string for <code>TypeName</code>. </p>\"\
        },\
        \"IndexRotationPeriod\":{\
          \"shape\":\"ElasticsearchIndexRotationPeriod\",\
          \"documentation\":\"<p>The Elasticsearch index rotation period. Index rotation appends a timestamp to <code>IndexName</code> to facilitate the expiration of old data. For more information, see <a href=\\\"https://docs.aws.amazon.com/firehose/latest/dev/basic-deliver.html#es-index-rotation\\\">Index Rotation for the Amazon ES Destination</a>. Default value isÂ <code>OneDay</code>.</p>\"\
        },\
        \"BufferingHints\":{\
          \"shape\":\"ElasticsearchBufferingHints\",\
          \"documentation\":\"<p>The buffering options. If no value is specified, <code>ElasticsearchBufferingHints</code> object default values are used. </p>\"\
        },\
        \"RetryOptions\":{\
          \"shape\":\"ElasticsearchRetryOptions\",\
          \"documentation\":\"<p>The retry behavior in case Kinesis Data Firehose is unable to deliver documents to Amazon ES. The default value is 300 (5 minutes).</p>\"\
        },\
        \"S3Update\":{\
          \"shape\":\"S3DestinationUpdate\",\
          \"documentation\":\"<p>The Amazon S3 destination.</p>\"\
        },\
        \"ProcessingConfiguration\":{\
          \"shape\":\"ProcessingConfiguration\",\
          \"documentation\":\"<p>The data processing configuration.</p>\"\
        },\
        \"CloudWatchLoggingOptions\":{\
          \"shape\":\"CloudWatchLoggingOptions\",\
          \"documentation\":\"<p>The CloudWatch logging options for your delivery stream.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Describes an update for a destination in Amazon ES.</p>\"\
    },\
    \"ElasticsearchDomainARN\":{\
      \"type\":\"string\",\
      \"max\":512,\
      \"min\":1,\
      \"pattern\":\"arn:.*\"\
    },\
    \"ElasticsearchIndexName\":{\
      \"type\":\"string\",\
      \"max\":80,\
      \"min\":1\
    },\
    \"ElasticsearchIndexRotationPeriod\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"NoRotation\",\
        \"OneHour\",\
        \"OneDay\",\
        \"OneWeek\",\
        \"OneMonth\"\
      ]\
    },\
    \"ElasticsearchRetryDurationInSeconds\":{\
      \"type\":\"integer\",\
      \"max\":7200,\
      \"min\":0\
    },\
    \"ElasticsearchRetryOptions\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"DurationInSeconds\":{\
          \"shape\":\"ElasticsearchRetryDurationInSeconds\",\
          \"documentation\":\"<p>After an initial failure to deliver to Amazon ES, the total amount of time during which Kinesis Data Firehose retries delivery (including the first attempt). After this time has elapsed, the failed documents are written to Amazon S3. Default value is 300 seconds (5 minutes). A value of 0 (zero) results in no retries.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Configures retry behavior in case Kinesis Data Firehose is unable to deliver documents to Amazon ES.</p>\"\
    },\
    \"ElasticsearchS3BackupMode\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"FailedDocumentsOnly\",\
        \"AllDocuments\"\
      ]\
    },\
    \"ElasticsearchTypeName\":{\
      \"type\":\"string\",\
      \"max\":100,\
      \"min\":0\
    },\
    \"EncryptionConfiguration\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"NoEncryptionConfig\":{\
          \"shape\":\"NoEncryptionConfig\",\
          \"documentation\":\"<p>Specifically override existing encryption information to ensure that no encryption is used.</p>\"\
        },\
        \"KMSEncryptionConfig\":{\
          \"shape\":\"KMSEncryptionConfig\",\
          \"documentation\":\"<p>The encryption key.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Describes the encryption for a destination in Amazon S3.</p>\"\
    },\
    \"ErrorCode\":{\"type\":\"string\"},\
    \"ErrorMessage\":{\"type\":\"string\"},\
    \"ErrorOutputPrefix\":{\"type\":\"string\"},\
    \"ExtendedS3DestinationConfiguration\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"RoleARN\",\
        \"BucketARN\"\
      ],\
      \"members\":{\
        \"RoleARN\":{\
          \"shape\":\"RoleARN\",\
          \"documentation\":\"<p>The Amazon Resource Name (ARN) of the AWS credentials. For more information, see <a href=\\\"https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html\\\">Amazon Resource Names (ARNs) and AWS Service Namespaces</a>.</p>\"\
        },\
        \"BucketARN\":{\
          \"shape\":\"BucketARN\",\
          \"documentation\":\"<p>The ARN of the S3 bucket. For more information, see <a href=\\\"https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html\\\">Amazon Resource Names (ARNs) and AWS Service Namespaces</a>.</p>\"\
        },\
        \"Prefix\":{\
          \"shape\":\"Prefix\",\
          \"documentation\":\"<p>The \\\"YYYY/MM/DD/HH\\\" time format prefix is automatically used for delivered Amazon S3 files. You can also specify a custom prefix, as described in <a href=\\\"https://docs.aws.amazon.com/firehose/latest/dev/s3-prefixes.html\\\">Custom Prefixes for Amazon S3 Objects</a>.</p>\"\
        },\
        \"ErrorOutputPrefix\":{\
          \"shape\":\"ErrorOutputPrefix\",\
          \"documentation\":\"<p>A prefix that Kinesis Data Firehose evaluates and adds to failed records before writing them to S3. This prefix appears immediately following the bucket name. For information about how to specify this prefix, see <a href=\\\"https://docs.aws.amazon.com/firehose/latest/dev/s3-prefixes.html\\\">Custom Prefixes for Amazon S3 Objects</a>.</p>\"\
        },\
        \"BufferingHints\":{\
          \"shape\":\"BufferingHints\",\
          \"documentation\":\"<p>The buffering option.</p>\"\
        },\
        \"CompressionFormat\":{\
          \"shape\":\"CompressionFormat\",\
          \"documentation\":\"<p>The compression format. If no value is specified, the default is UNCOMPRESSED.</p>\"\
        },\
        \"EncryptionConfiguration\":{\
          \"shape\":\"EncryptionConfiguration\",\
          \"documentation\":\"<p>The encryption configuration. If no value is specified, the default is no encryption.</p>\"\
        },\
        \"CloudWatchLoggingOptions\":{\
          \"shape\":\"CloudWatchLoggingOptions\",\
          \"documentation\":\"<p>The Amazon CloudWatch logging options for your delivery stream.</p>\"\
        },\
        \"ProcessingConfiguration\":{\
          \"shape\":\"ProcessingConfiguration\",\
          \"documentation\":\"<p>The data processing configuration.</p>\"\
        },\
        \"S3BackupMode\":{\
          \"shape\":\"S3BackupMode\",\
          \"documentation\":\"<p>The Amazon S3 backup mode.</p>\"\
        },\
        \"S3BackupConfiguration\":{\
          \"shape\":\"S3DestinationConfiguration\",\
          \"documentation\":\"<p>The configuration for backup in Amazon S3.</p>\"\
        },\
        \"DataFormatConversionConfiguration\":{\
          \"shape\":\"DataFormatConversionConfiguration\",\
          \"documentation\":\"<p>The serializer, deserializer, and schema for converting data from the JSON format to the Parquet or ORC format before writing it to Amazon S3.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Describes the configuration of a destination in Amazon S3.</p>\"\
    },\
    \"ExtendedS3DestinationDescription\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"RoleARN\",\
        \"BucketARN\",\
        \"BufferingHints\",\
        \"CompressionFormat\",\
        \"EncryptionConfiguration\"\
      ],\
      \"members\":{\
        \"RoleARN\":{\
          \"shape\":\"RoleARN\",\
          \"documentation\":\"<p>The Amazon Resource Name (ARN) of the AWS credentials. For more information, see <a href=\\\"https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html\\\">Amazon Resource Names (ARNs) and AWS Service Namespaces</a>.</p>\"\
        },\
        \"BucketARN\":{\
          \"shape\":\"BucketARN\",\
          \"documentation\":\"<p>The ARN of the S3 bucket. For more information, see <a href=\\\"https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html\\\">Amazon Resource Names (ARNs) and AWS Service Namespaces</a>.</p>\"\
        },\
        \"Prefix\":{\
          \"shape\":\"Prefix\",\
          \"documentation\":\"<p>The \\\"YYYY/MM/DD/HH\\\" time format prefix is automatically used for delivered Amazon S3 files. You can also specify a custom prefix, as described in <a href=\\\"https://docs.aws.amazon.com/firehose/latest/dev/s3-prefixes.html\\\">Custom Prefixes for Amazon S3 Objects</a>.</p>\"\
        },\
        \"ErrorOutputPrefix\":{\
          \"shape\":\"ErrorOutputPrefix\",\
          \"documentation\":\"<p>A prefix that Kinesis Data Firehose evaluates and adds to failed records before writing them to S3. This prefix appears immediately following the bucket name. For information about how to specify this prefix, see <a href=\\\"https://docs.aws.amazon.com/firehose/latest/dev/s3-prefixes.html\\\">Custom Prefixes for Amazon S3 Objects</a>.</p>\"\
        },\
        \"BufferingHints\":{\
          \"shape\":\"BufferingHints\",\
          \"documentation\":\"<p>The buffering option.</p>\"\
        },\
        \"CompressionFormat\":{\
          \"shape\":\"CompressionFormat\",\
          \"documentation\":\"<p>The compression format. If no value is specified, the default is <code>UNCOMPRESSED</code>.</p>\"\
        },\
        \"EncryptionConfiguration\":{\
          \"shape\":\"EncryptionConfiguration\",\
          \"documentation\":\"<p>The encryption configuration. If no value is specified, the default is no encryption.</p>\"\
        },\
        \"CloudWatchLoggingOptions\":{\
          \"shape\":\"CloudWatchLoggingOptions\",\
          \"documentation\":\"<p>The Amazon CloudWatch logging options for your delivery stream.</p>\"\
        },\
        \"ProcessingConfiguration\":{\
          \"shape\":\"ProcessingConfiguration\",\
          \"documentation\":\"<p>The data processing configuration.</p>\"\
        },\
        \"S3BackupMode\":{\
          \"shape\":\"S3BackupMode\",\
          \"documentation\":\"<p>The Amazon S3 backup mode.</p>\"\
        },\
        \"S3BackupDescription\":{\
          \"shape\":\"S3DestinationDescription\",\
          \"documentation\":\"<p>The configuration for backup in Amazon S3.</p>\"\
        },\
        \"DataFormatConversionConfiguration\":{\
          \"shape\":\"DataFormatConversionConfiguration\",\
          \"documentation\":\"<p>The serializer, deserializer, and schema for converting data from the JSON format to the Parquet or ORC format before writing it to Amazon S3.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Describes a destination in Amazon S3.</p>\"\
    },\
    \"ExtendedS3DestinationUpdate\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"RoleARN\":{\
          \"shape\":\"RoleARN\",\
          \"documentation\":\"<p>The Amazon Resource Name (ARN) of the AWS credentials. For more information, see <a href=\\\"https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html\\\">Amazon Resource Names (ARNs) and AWS Service Namespaces</a>.</p>\"\
        },\
        \"BucketARN\":{\
          \"shape\":\"BucketARN\",\
          \"documentation\":\"<p>The ARN of the S3 bucket. For more information, see <a href=\\\"https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html\\\">Amazon Resource Names (ARNs) and AWS Service Namespaces</a>.</p>\"\
        },\
        \"Prefix\":{\
          \"shape\":\"Prefix\",\
          \"documentation\":\"<p>The \\\"YYYY/MM/DD/HH\\\" time format prefix is automatically used for delivered Amazon S3 files. You can also specify a custom prefix, as described in <a href=\\\"https://docs.aws.amazon.com/firehose/latest/dev/s3-prefixes.html\\\">Custom Prefixes for Amazon S3 Objects</a>.</p>\"\
        },\
        \"ErrorOutputPrefix\":{\
          \"shape\":\"ErrorOutputPrefix\",\
          \"documentation\":\"<p>A prefix that Kinesis Data Firehose evaluates and adds to failed records before writing them to S3. This prefix appears immediately following the bucket name. For information about how to specify this prefix, see <a href=\\\"https://docs.aws.amazon.com/firehose/latest/dev/s3-prefixes.html\\\">Custom Prefixes for Amazon S3 Objects</a>.</p>\"\
        },\
        \"BufferingHints\":{\
          \"shape\":\"BufferingHints\",\
          \"documentation\":\"<p>The buffering option.</p>\"\
        },\
        \"CompressionFormat\":{\
          \"shape\":\"CompressionFormat\",\
          \"documentation\":\"<p>The compression format. If no value is specified, the default is <code>UNCOMPRESSED</code>. </p>\"\
        },\
        \"EncryptionConfiguration\":{\
          \"shape\":\"EncryptionConfiguration\",\
          \"documentation\":\"<p>The encryption configuration. If no value is specified, the default is no encryption.</p>\"\
        },\
        \"CloudWatchLoggingOptions\":{\
          \"shape\":\"CloudWatchLoggingOptions\",\
          \"documentation\":\"<p>The Amazon CloudWatch logging options for your delivery stream.</p>\"\
        },\
        \"ProcessingConfiguration\":{\
          \"shape\":\"ProcessingConfiguration\",\
          \"documentation\":\"<p>The data processing configuration.</p>\"\
        },\
        \"S3BackupMode\":{\
          \"shape\":\"S3BackupMode\",\
          \"documentation\":\"<p>Enables or disables Amazon S3 backup mode.</p>\"\
        },\
        \"S3BackupUpdate\":{\
          \"shape\":\"S3DestinationUpdate\",\
          \"documentation\":\"<p>The Amazon S3 destination for backup.</p>\"\
        },\
        \"DataFormatConversionConfiguration\":{\
          \"shape\":\"DataFormatConversionConfiguration\",\
          \"documentation\":\"<p>The serializer, deserializer, and schema for converting data from the JSON format to the Parquet or ORC format before writing it to Amazon S3.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Describes an update for a destination in Amazon S3.</p>\"\
    },\
    \"HECAcknowledgmentTimeoutInSeconds\":{\
      \"type\":\"integer\",\
      \"max\":600,\
      \"min\":180\
    },\
    \"HECEndpoint\":{\"type\":\"string\"},\
    \"HECEndpointType\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"Raw\",\
        \"Event\"\
      ]\
    },\
    \"HECToken\":{\"type\":\"string\"},\
    \"HiveJsonSerDe\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"TimestampFormats\":{\
          \"shape\":\"ListOfNonEmptyStrings\",\
          \"documentation\":\"<p>Indicates how you want Kinesis Data Firehose to parse the date and timestamps that may be present in your input data JSON. To specify these format strings, follow the pattern syntax of JodaTime's DateTimeFormat format strings. For more information, see <a href=\\\"https://www.joda.org/joda-time/apidocs/org/joda/time/format/DateTimeFormat.html\\\">Class DateTimeFormat</a>. You can also use the special value <code>millis</code> to parse timestamps in epoch milliseconds. If you don't specify a format, Kinesis Data Firehose uses <code>java.sql.Timestamp::valueOf</code> by default.</p>\"\
        }\
      },\
      \"documentation\":\"<p>The native Hive / HCatalog JsonSerDe. Used by Kinesis Data Firehose for deserializing data, which means converting it from the JSON format in preparation for serializing it to the Parquet or ORC format. This is one of two deserializers you can choose, depending on which one offers the functionality you need. The other option is the OpenX SerDe.</p>\"\
    },\
    \"InputFormatConfiguration\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Deserializer\":{\
          \"shape\":\"Deserializer\",\
          \"documentation\":\"<p>Specifies which deserializer to use. You can choose either the Apache Hive JSON SerDe or the OpenX JSON SerDe. If both are non-null, the server rejects the request.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Specifies the deserializer you want to use to convert the format of the input data.</p>\"\
    },\
    \"IntervalInSeconds\":{\
      \"type\":\"integer\",\
      \"max\":900,\
      \"min\":60\
    },\
    \"InvalidArgumentException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\
          \"shape\":\"ErrorMessage\",\
          \"documentation\":\"<p>A message that provides information about the error.</p>\"\
        }\
      },\
      \"documentation\":\"<p>The specified input parameter has a value that is not valid.</p>\",\
      \"exception\":true\
    },\
    \"KMSEncryptionConfig\":{\
      \"type\":\"structure\",\
      \"required\":[\"AWSKMSKeyARN\"],\
      \"members\":{\
        \"AWSKMSKeyARN\":{\
          \"shape\":\"AWSKMSKeyARN\",\
          \"documentation\":\"<p>The Amazon Resource Name (ARN) of the encryption key. Must belong to the same AWS Region as the destination Amazon S3 bucket. For more information, see <a href=\\\"https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html\\\">Amazon Resource Names (ARNs) and AWS Service Namespaces</a>.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Describes an encryption key for a destination in Amazon S3.</p>\"\
    },\
    \"KinesisStreamARN\":{\
      \"type\":\"string\",\
      \"max\":512,\
      \"min\":1,\
      \"pattern\":\"arn:.*\"\
    },\
    \"KinesisStreamSourceConfiguration\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"KinesisStreamARN\",\
        \"RoleARN\"\
      ],\
      \"members\":{\
        \"KinesisStreamARN\":{\
          \"shape\":\"KinesisStreamARN\",\
          \"documentation\":\"<p>The ARN of the source Kinesis data stream. For more information, see <a href=\\\"https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html#arn-syntax-kinesis-streams\\\">Amazon Kinesis Data Streams ARN Format</a>.</p>\"\
        },\
        \"RoleARN\":{\
          \"shape\":\"RoleARN\",\
          \"documentation\":\"<p>The ARN of the role that provides access to the source Kinesis data stream. For more information, see <a href=\\\"https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html#arn-syntax-iam\\\">AWS Identity and Access Management (IAM) ARN Format</a>.</p>\"\
        }\
      },\
      \"documentation\":\"<p>The stream and role Amazon Resource Names (ARNs) for a Kinesis data stream used as the source for a delivery stream.</p>\"\
    },\
    \"KinesisStreamSourceDescription\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"KinesisStreamARN\":{\
          \"shape\":\"KinesisStreamARN\",\
          \"documentation\":\"<p>The Amazon Resource Name (ARN) of the source Kinesis data stream. For more information, see <a href=\\\"https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html#arn-syntax-kinesis-streams\\\">Amazon Kinesis Data Streams ARN Format</a>.</p>\"\
        },\
        \"RoleARN\":{\
          \"shape\":\"RoleARN\",\
          \"documentation\":\"<p>The ARN of the role used by the source Kinesis data stream. For more information, see <a href=\\\"https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html#arn-syntax-iam\\\">AWS Identity and Access Management (IAM) ARN Format</a>.</p>\"\
        },\
        \"DeliveryStartTimestamp\":{\
          \"shape\":\"DeliveryStartTimestamp\",\
          \"documentation\":\"<p>Kinesis Data Firehose starts retrieving records from the Kinesis data stream starting with this timestamp.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Details about a Kinesis data stream used as the source for a Kinesis Data Firehose delivery stream.</p>\"\
    },\
    \"LimitExceededException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\
          \"shape\":\"ErrorMessage\",\
          \"documentation\":\"<p>A message that provides information about the error.</p>\"\
        }\
      },\
      \"documentation\":\"<p>You have already reached the limit for a requested resource.</p>\",\
      \"exception\":true\
    },\
    \"ListDeliveryStreamsInput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Limit\":{\
          \"shape\":\"ListDeliveryStreamsInputLimit\",\
          \"documentation\":\"<p>The maximum number of delivery streams to list. The default value is 10.</p>\"\
        },\
        \"DeliveryStreamType\":{\
          \"shape\":\"DeliveryStreamType\",\
          \"documentation\":\"<p>The delivery stream type. This can be one of the following values:</p> <ul> <li> <p> <code>DirectPut</code>: Provider applications access the delivery stream directly.</p> </li> <li> <p> <code>KinesisStreamAsSource</code>: The delivery stream uses a Kinesis data stream as a source.</p> </li> </ul> <p>This parameter is optional. If this parameter is omitted, delivery streams of all types are returned.</p>\"\
        },\
        \"ExclusiveStartDeliveryStreamName\":{\
          \"shape\":\"DeliveryStreamName\",\
          \"documentation\":\"<p>The list of delivery streams returned by this call to <code>ListDeliveryStreams</code> will start with the delivery stream whose name comes alphabetically immediately after the name you specify in <code>ExclusiveStartDeliveryStreamName</code>.</p>\"\
        }\
      }\
    },\
    \"ListDeliveryStreamsInputLimit\":{\
      \"type\":\"integer\",\
      \"max\":10000,\
      \"min\":1\
    },\
    \"ListDeliveryStreamsOutput\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"DeliveryStreamNames\",\
        \"HasMoreDeliveryStreams\"\
      ],\
      \"members\":{\
        \"DeliveryStreamNames\":{\
          \"shape\":\"DeliveryStreamNameList\",\
          \"documentation\":\"<p>The names of the delivery streams.</p>\"\
        },\
        \"HasMoreDeliveryStreams\":{\
          \"shape\":\"BooleanObject\",\
          \"documentation\":\"<p>Indicates whether there are more delivery streams available to list.</p>\"\
        }\
      }\
    },\
    \"ListOfNonEmptyStrings\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"NonEmptyString\"}\
    },\
    \"ListOfNonEmptyStringsWithoutWhitespace\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"NonEmptyStringWithoutWhitespace\"}\
    },\
    \"ListTagsForDeliveryStreamInput\":{\
      \"type\":\"structure\",\
      \"required\":[\"DeliveryStreamName\"],\
      \"members\":{\
        \"DeliveryStreamName\":{\
          \"shape\":\"DeliveryStreamName\",\
          \"documentation\":\"<p>The name of the delivery stream whose tags you want to list.</p>\"\
        },\
        \"ExclusiveStartTagKey\":{\
          \"shape\":\"TagKey\",\
          \"documentation\":\"<p>The key to use as the starting point for the list of tags. If you set this parameter, <code>ListTagsForDeliveryStream</code> gets all tags that occur after <code>ExclusiveStartTagKey</code>.</p>\"\
        },\
        \"Limit\":{\
          \"shape\":\"ListTagsForDeliveryStreamInputLimit\",\
          \"documentation\":\"<p>The number of tags to return. If this number is less than the total number of tags associated with the delivery stream, <code>HasMoreTags</code> is set to <code>true</code> in the response. To list additional tags, set <code>ExclusiveStartTagKey</code> to the last key in the response. </p>\"\
        }\
      }\
    },\
    \"ListTagsForDeliveryStreamInputLimit\":{\
      \"type\":\"integer\",\
      \"max\":50,\
      \"min\":1\
    },\
    \"ListTagsForDeliveryStreamOutput\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Tags\",\
        \"HasMoreTags\"\
      ],\
      \"members\":{\
        \"Tags\":{\
          \"shape\":\"ListTagsForDeliveryStreamOutputTagList\",\
          \"documentation\":\"<p>A list of tags associated with <code>DeliveryStreamName</code>, starting with the first tag after <code>ExclusiveStartTagKey</code> and up to the specified <code>Limit</code>.</p>\"\
        },\
        \"HasMoreTags\":{\
          \"shape\":\"BooleanObject\",\
          \"documentation\":\"<p>If this is <code>true</code> in the response, more tags are available. To list the remaining tags, set <code>ExclusiveStartTagKey</code> to the key of the last tag returned and call <code>ListTagsForDeliveryStream</code> again.</p>\"\
        }\
      }\
    },\
    \"ListTagsForDeliveryStreamOutputTagList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"Tag\"},\
      \"max\":50,\
      \"min\":0\
    },\
    \"LogGroupName\":{\"type\":\"string\"},\
    \"LogStreamName\":{\"type\":\"string\"},\
    \"NoEncryptionConfig\":{\
      \"type\":\"string\",\
      \"enum\":[\"NoEncryption\"]\
    },\
    \"NonEmptyString\":{\
      \"type\":\"string\",\
      \"pattern\":\"^(?!\\\\s*$).+\"\
    },\
    \"NonEmptyStringWithoutWhitespace\":{\
      \"type\":\"string\",\
      \"pattern\":\"^\\\\S+$\"\
    },\
    \"NonNegativeIntegerObject\":{\
      \"type\":\"integer\",\
      \"min\":0\
    },\
    \"OpenXJsonSerDe\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"ConvertDotsInJsonKeysToUnderscores\":{\
          \"shape\":\"BooleanObject\",\
          \"documentation\":\"<p>When set to <code>true</code>, specifies that the names of the keys include dots and that you want Kinesis Data Firehose to replace them with underscores. This is useful because Apache Hive does not allow dots in column names. For example, if the JSON contains a key whose name is \\\"a.b\\\", you can define the column name to be \\\"a_b\\\" when using this option.</p> <p>The default is <code>false</code>.</p>\"\
        },\
        \"CaseInsensitive\":{\
          \"shape\":\"BooleanObject\",\
          \"documentation\":\"<p>When set to <code>true</code>, which is the default, Kinesis Data Firehose converts JSON keys to lowercase before deserializing them.</p>\"\
        },\
        \"ColumnToJsonKeyMappings\":{\
          \"shape\":\"ColumnToJsonKeyMappings\",\
          \"documentation\":\"<p>Maps column names to JSON keys that aren't identical to the column names. This is useful when the JSON contains keys that are Hive keywords. For example, <code>timestamp</code> is a Hive keyword. If you have a JSON key named <code>timestamp</code>, set this parameter to <code>{\\\"ts\\\": \\\"timestamp\\\"}</code> to map this key to a column named <code>ts</code>.</p>\"\
        }\
      },\
      \"documentation\":\"<p>The OpenX SerDe. Used by Kinesis Data Firehose for deserializing data, which means converting it from the JSON format in preparation for serializing it to the Parquet or ORC format. This is one of two deserializers you can choose, depending on which one offers the functionality you need. The other option is the native Hive / HCatalog JsonSerDe.</p>\"\
    },\
    \"OrcCompression\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"NONE\",\
        \"ZLIB\",\
        \"SNAPPY\"\
      ]\
    },\
    \"OrcFormatVersion\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"V0_11\",\
        \"V0_12\"\
      ]\
    },\
    \"OrcRowIndexStride\":{\
      \"type\":\"integer\",\
      \"min\":1000\
    },\
    \"OrcSerDe\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"StripeSizeBytes\":{\
          \"shape\":\"OrcStripeSizeBytes\",\
          \"documentation\":\"<p>The number of bytes in each stripe. The default is 64 MiB and the minimum is 8 MiB.</p>\"\
        },\
        \"BlockSizeBytes\":{\
          \"shape\":\"BlockSizeBytes\",\
          \"documentation\":\"<p>The Hadoop Distributed File System (HDFS) block size. This is useful if you intend to copy the data from Amazon S3 to HDFS before querying. The default is 256 MiB and the minimum is 64 MiB. Kinesis Data Firehose uses this value for padding calculations.</p>\"\
        },\
        \"RowIndexStride\":{\
          \"shape\":\"OrcRowIndexStride\",\
          \"documentation\":\"<p>The number of rows between index entries. The default is 10,000 and the minimum is 1,000.</p>\"\
        },\
        \"EnablePadding\":{\
          \"shape\":\"BooleanObject\",\
          \"documentation\":\"<p>Set this to <code>true</code> to indicate that you want stripes to be padded to the HDFS block boundaries. This is useful if you intend to copy the data from Amazon S3 to HDFS before querying. The default is <code>false</code>.</p>\"\
        },\
        \"PaddingTolerance\":{\
          \"shape\":\"Proportion\",\
          \"documentation\":\"<p>A number between 0 and 1 that defines the tolerance for block padding as a decimal fraction of stripe size. The default value is 0.05, which means 5 percent of stripe size.</p> <p>For the default values of 64 MiB ORC stripes and 256 MiB HDFS blocks, the default block padding tolerance of 5 percent reserves a maximum of 3.2 MiB for padding within the 256 MiB block. In such a case, if the available size within the block is more than 3.2 MiB, a new, smaller stripe is inserted to fit within that space. This ensures that no stripe crosses block boundaries and causes remote reads within a node-local task.</p> <p>Kinesis Data Firehose ignores this parameter when <a>OrcSerDe$EnablePadding</a> is <code>false</code>.</p>\"\
        },\
        \"Compression\":{\
          \"shape\":\"OrcCompression\",\
          \"documentation\":\"<p>The compression code to use over data blocks. The default is <code>SNAPPY</code>.</p>\"\
        },\
        \"BloomFilterColumns\":{\
          \"shape\":\"ListOfNonEmptyStringsWithoutWhitespace\",\
          \"documentation\":\"<p>The column names for which you want Kinesis Data Firehose to create bloom filters. The default is <code>null</code>.</p>\"\
        },\
        \"BloomFilterFalsePositiveProbability\":{\
          \"shape\":\"Proportion\",\
          \"documentation\":\"<p>The Bloom filter false positive probability (FPP). The lower the FPP, the bigger the Bloom filter. The default value is 0.05, the minimum is 0, and the maximum is 1.</p>\"\
        },\
        \"DictionaryKeyThreshold\":{\
          \"shape\":\"Proportion\",\
          \"documentation\":\"<p>Represents the fraction of the total number of non-null rows. To turn off dictionary encoding, set this fraction to a number that is less than the number of distinct keys in a dictionary. To always use dictionary encoding, set this threshold to 1.</p>\"\
        },\
        \"FormatVersion\":{\
          \"shape\":\"OrcFormatVersion\",\
          \"documentation\":\"<p>The version of the file to write. The possible values are <code>V0_11</code> and <code>V0_12</code>. The default is <code>V0_12</code>.</p>\"\
        }\
      },\
      \"documentation\":\"<p>A serializer to use for converting data to the ORC format before storing it in Amazon S3. For more information, see <a href=\\\"https://orc.apache.org/docs/\\\">Apache ORC</a>.</p>\"\
    },\
    \"OrcStripeSizeBytes\":{\
      \"type\":\"integer\",\
      \"min\":8388608\
    },\
    \"OutputFormatConfiguration\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Serializer\":{\
          \"shape\":\"Serializer\",\
          \"documentation\":\"<p>Specifies which serializer to use. You can choose either the ORC SerDe or the Parquet SerDe. If both are non-null, the server rejects the request.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Specifies the serializer that you want Kinesis Data Firehose to use to convert the format of your data before it writes it to Amazon S3.</p>\"\
    },\
    \"ParquetCompression\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"UNCOMPRESSED\",\
        \"GZIP\",\
        \"SNAPPY\"\
      ]\
    },\
    \"ParquetPageSizeBytes\":{\
      \"type\":\"integer\",\
      \"min\":65536\
    },\
    \"ParquetSerDe\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"BlockSizeBytes\":{\
          \"shape\":\"BlockSizeBytes\",\
          \"documentation\":\"<p>The Hadoop Distributed File System (HDFS) block size. This is useful if you intend to copy the data from Amazon S3 to HDFS before querying. The default is 256 MiB and the minimum is 64 MiB. Kinesis Data Firehose uses this value for padding calculations.</p>\"\
        },\
        \"PageSizeBytes\":{\
          \"shape\":\"ParquetPageSizeBytes\",\
          \"documentation\":\"<p>The Parquet page size. Column chunks are divided into pages. A page is conceptually an indivisible unit (in terms of compression and encoding). The minimum value is 64 KiB and the default is 1 MiB.</p>\"\
        },\
        \"Compression\":{\
          \"shape\":\"ParquetCompression\",\
          \"documentation\":\"<p>The compression code to use over data blocks. The possible values are <code>UNCOMPRESSED</code>, <code>SNAPPY</code>, and <code>GZIP</code>, with the default being <code>SNAPPY</code>. Use <code>SNAPPY</code> for higher decompression speed. Use <code>GZIP</code> if the compression ration is more important than speed.</p>\"\
        },\
        \"EnableDictionaryCompression\":{\
          \"shape\":\"BooleanObject\",\
          \"documentation\":\"<p>Indicates whether to enable dictionary compression.</p>\"\
        },\
        \"MaxPaddingBytes\":{\
          \"shape\":\"NonNegativeIntegerObject\",\
          \"documentation\":\"<p>The maximum amount of padding to apply. This is useful if you intend to copy the data from Amazon S3 to HDFS before querying. The default is 0.</p>\"\
        },\
        \"WriterVersion\":{\
          \"shape\":\"ParquetWriterVersion\",\
          \"documentation\":\"<p>Indicates the version of row format to output. The possible values are <code>V1</code> and <code>V2</code>. The default is <code>V1</code>.</p>\"\
        }\
      },\
      \"documentation\":\"<p>A serializer to use for converting data to the Parquet format before storing it in Amazon S3. For more information, see <a href=\\\"https://parquet.apache.org/documentation/latest/\\\">Apache Parquet</a>.</p>\"\
    },\
    \"ParquetWriterVersion\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"V1\",\
        \"V2\"\
      ]\
    },\
    \"Password\":{\
      \"type\":\"string\",\
      \"min\":6,\
      \"sensitive\":true\
    },\
    \"Prefix\":{\"type\":\"string\"},\
    \"ProcessingConfiguration\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Enabled\":{\
          \"shape\":\"BooleanObject\",\
          \"documentation\":\"<p>Enables or disables data processing.</p>\"\
        },\
        \"Processors\":{\
          \"shape\":\"ProcessorList\",\
          \"documentation\":\"<p>The data processors.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Describes a data processing configuration.</p>\"\
    },\
    \"Processor\":{\
      \"type\":\"structure\",\
      \"required\":[\"Type\"],\
      \"members\":{\
        \"Type\":{\
          \"shape\":\"ProcessorType\",\
          \"documentation\":\"<p>The type of processor.</p>\"\
        },\
        \"Parameters\":{\
          \"shape\":\"ProcessorParameterList\",\
          \"documentation\":\"<p>The processor parameters.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Describes a data processor.</p>\"\
    },\
    \"ProcessorList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"Processor\"}\
    },\
    \"ProcessorParameter\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"ParameterName\",\
        \"ParameterValue\"\
      ],\
      \"members\":{\
        \"ParameterName\":{\
          \"shape\":\"ProcessorParameterName\",\
          \"documentation\":\"<p>The name of the parameter.</p>\"\
        },\
        \"ParameterValue\":{\
          \"shape\":\"ProcessorParameterValue\",\
          \"documentation\":\"<p>The parameter value.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Describes the processor parameter.</p>\"\
    },\
    \"ProcessorParameterList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"ProcessorParameter\"}\
    },\
    \"ProcessorParameterName\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"LambdaArn\",\
        \"NumberOfRetries\",\
        \"RoleArn\",\
        \"BufferSizeInMBs\",\
        \"BufferIntervalInSeconds\"\
      ]\
    },\
    \"ProcessorParameterValue\":{\
      \"type\":\"string\",\
      \"max\":512,\
      \"min\":1\
    },\
    \"ProcessorType\":{\
      \"type\":\"string\",\
      \"enum\":[\"Lambda\"]\
    },\
    \"Proportion\":{\
      \"type\":\"double\",\
      \"max\":1,\
      \"min\":0\
    },\
    \"PutRecordBatchInput\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"DeliveryStreamName\",\
        \"Records\"\
      ],\
      \"members\":{\
        \"DeliveryStreamName\":{\
          \"shape\":\"DeliveryStreamName\",\
          \"documentation\":\"<p>The name of the delivery stream.</p>\"\
        },\
        \"Records\":{\
          \"shape\":\"PutRecordBatchRequestEntryList\",\
          \"documentation\":\"<p>One or more records.</p>\"\
        }\
      }\
    },\
    \"PutRecordBatchOutput\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"FailedPutCount\",\
        \"RequestResponses\"\
      ],\
      \"members\":{\
        \"FailedPutCount\":{\
          \"shape\":\"NonNegativeIntegerObject\",\
          \"documentation\":\"<p>The number of records that might have failed processing. This number might be greater than 0 even if the <a>PutRecordBatch</a> call succeeds. Check <code>FailedPutCount</code> to determine whether there are records that you need to resend.</p>\"\
        },\
        \"Encrypted\":{\
          \"shape\":\"BooleanObject\",\
          \"documentation\":\"<p>Indicates whether server-side encryption (SSE) was enabled during this operation.</p>\"\
        },\
        \"RequestResponses\":{\
          \"shape\":\"PutRecordBatchResponseEntryList\",\
          \"documentation\":\"<p>The results array. For each record, the index of the response element is the same as the index used in the request array.</p>\"\
        }\
      }\
    },\
    \"PutRecordBatchRequestEntryList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"Record\"},\
      \"max\":500,\
      \"min\":1\
    },\
    \"PutRecordBatchResponseEntry\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"RecordId\":{\
          \"shape\":\"PutResponseRecordId\",\
          \"documentation\":\"<p>The ID of the record.</p>\"\
        },\
        \"ErrorCode\":{\
          \"shape\":\"ErrorCode\",\
          \"documentation\":\"<p>The error code for an individual record result.</p>\"\
        },\
        \"ErrorMessage\":{\
          \"shape\":\"ErrorMessage\",\
          \"documentation\":\"<p>The error message for an individual record result.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Contains the result for an individual record from a <a>PutRecordBatch</a> request. If the record is successfully added to your delivery stream, it receives a record ID. If the record fails to be added to your delivery stream, the result includes an error code and an error message.</p>\"\
    },\
    \"PutRecordBatchResponseEntryList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"PutRecordBatchResponseEntry\"},\
      \"max\":500,\
      \"min\":1\
    },\
    \"PutRecordInput\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"DeliveryStreamName\",\
        \"Record\"\
      ],\
      \"members\":{\
        \"DeliveryStreamName\":{\
          \"shape\":\"DeliveryStreamName\",\
          \"documentation\":\"<p>The name of the delivery stream.</p>\"\
        },\
        \"Record\":{\
          \"shape\":\"Record\",\
          \"documentation\":\"<p>The record.</p>\"\
        }\
      }\
    },\
    \"PutRecordOutput\":{\
      \"type\":\"structure\",\
      \"required\":[\"RecordId\"],\
      \"members\":{\
        \"RecordId\":{\
          \"shape\":\"PutResponseRecordId\",\
          \"documentation\":\"<p>The ID of the record.</p>\"\
        },\
        \"Encrypted\":{\
          \"shape\":\"BooleanObject\",\
          \"documentation\":\"<p>Indicates whether server-side encryption (SSE) was enabled during this operation.</p>\"\
        }\
      }\
    },\
    \"PutResponseRecordId\":{\
      \"type\":\"string\",\
      \"min\":1\
    },\
    \"Record\":{\
      \"type\":\"structure\",\
      \"required\":[\"Data\"],\
      \"members\":{\
        \"Data\":{\
          \"shape\":\"Data\",\
          \"documentation\":\"<p>The data blob, which is base64-encoded when the blob is serialized. The maximum size of the data blob, before base64-encoding, is 1,000 KiB.</p>\"\
        }\
      },\
      \"documentation\":\"<p>The unit of data in a delivery stream.</p>\"\
    },\
    \"RedshiftDestinationConfiguration\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"RoleARN\",\
        \"ClusterJDBCURL\",\
        \"CopyCommand\",\
        \"Username\",\
        \"Password\",\
        \"S3Configuration\"\
      ],\
      \"members\":{\
        \"RoleARN\":{\
          \"shape\":\"RoleARN\",\
          \"documentation\":\"<p>The Amazon Resource Name (ARN) of the AWS credentials. For more information, see <a href=\\\"https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html\\\">Amazon Resource Names (ARNs) and AWS Service Namespaces</a>.</p>\"\
        },\
        \"ClusterJDBCURL\":{\
          \"shape\":\"ClusterJDBCURL\",\
          \"documentation\":\"<p>The database connection string.</p>\"\
        },\
        \"CopyCommand\":{\
          \"shape\":\"CopyCommand\",\
          \"documentation\":\"<p>The <code>COPY</code> command.</p>\"\
        },\
        \"Username\":{\
          \"shape\":\"Username\",\
          \"documentation\":\"<p>The name of the user.</p>\"\
        },\
        \"Password\":{\
          \"shape\":\"Password\",\
          \"documentation\":\"<p>The user password.</p>\"\
        },\
        \"RetryOptions\":{\
          \"shape\":\"RedshiftRetryOptions\",\
          \"documentation\":\"<p>The retry behavior in case Kinesis Data Firehose is unable to deliver documents to Amazon Redshift. Default value is 3600 (60 minutes).</p>\"\
        },\
        \"S3Configuration\":{\
          \"shape\":\"S3DestinationConfiguration\",\
          \"documentation\":\"<p>The configuration for the intermediate Amazon S3 location from which Amazon Redshift obtains data. Restrictions are described in the topic for <a>CreateDeliveryStream</a>.</p> <p>The compression formats <code>SNAPPY</code> or <code>ZIP</code> cannot be specified in <code>RedshiftDestinationConfiguration.S3Configuration</code> because the Amazon Redshift <code>COPY</code> operation that reads from the S3 bucket doesn't support these compression formats.</p>\"\
        },\
        \"ProcessingConfiguration\":{\
          \"shape\":\"ProcessingConfiguration\",\
          \"documentation\":\"<p>The data processing configuration.</p>\"\
        },\
        \"S3BackupMode\":{\
          \"shape\":\"RedshiftS3BackupMode\",\
          \"documentation\":\"<p>The Amazon S3 backup mode.</p>\"\
        },\
        \"S3BackupConfiguration\":{\
          \"shape\":\"S3DestinationConfiguration\",\
          \"documentation\":\"<p>The configuration for backup in Amazon S3.</p>\"\
        },\
        \"CloudWatchLoggingOptions\":{\
          \"shape\":\"CloudWatchLoggingOptions\",\
          \"documentation\":\"<p>The CloudWatch logging options for your delivery stream.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Describes the configuration of a destination in Amazon Redshift.</p>\"\
    },\
    \"RedshiftDestinationDescription\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"RoleARN\",\
        \"ClusterJDBCURL\",\
        \"CopyCommand\",\
        \"Username\",\
        \"S3DestinationDescription\"\
      ],\
      \"members\":{\
        \"RoleARN\":{\
          \"shape\":\"RoleARN\",\
          \"documentation\":\"<p>The Amazon Resource Name (ARN) of the AWS credentials. For more information, see <a href=\\\"https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html\\\">Amazon Resource Names (ARNs) and AWS Service Namespaces</a>.</p>\"\
        },\
        \"ClusterJDBCURL\":{\
          \"shape\":\"ClusterJDBCURL\",\
          \"documentation\":\"<p>The database connection string.</p>\"\
        },\
        \"CopyCommand\":{\
          \"shape\":\"CopyCommand\",\
          \"documentation\":\"<p>The <code>COPY</code> command.</p>\"\
        },\
        \"Username\":{\
          \"shape\":\"Username\",\
          \"documentation\":\"<p>The name of the user.</p>\"\
        },\
        \"RetryOptions\":{\
          \"shape\":\"RedshiftRetryOptions\",\
          \"documentation\":\"<p>The retry behavior in case Kinesis Data Firehose is unable to deliver documents to Amazon Redshift. Default value is 3600 (60 minutes).</p>\"\
        },\
        \"S3DestinationDescription\":{\
          \"shape\":\"S3DestinationDescription\",\
          \"documentation\":\"<p>The Amazon S3 destination.</p>\"\
        },\
        \"ProcessingConfiguration\":{\
          \"shape\":\"ProcessingConfiguration\",\
          \"documentation\":\"<p>The data processing configuration.</p>\"\
        },\
        \"S3BackupMode\":{\
          \"shape\":\"RedshiftS3BackupMode\",\
          \"documentation\":\"<p>The Amazon S3 backup mode.</p>\"\
        },\
        \"S3BackupDescription\":{\
          \"shape\":\"S3DestinationDescription\",\
          \"documentation\":\"<p>The configuration for backup in Amazon S3.</p>\"\
        },\
        \"CloudWatchLoggingOptions\":{\
          \"shape\":\"CloudWatchLoggingOptions\",\
          \"documentation\":\"<p>The Amazon CloudWatch logging options for your delivery stream.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Describes a destination in Amazon Redshift.</p>\"\
    },\
    \"RedshiftDestinationUpdate\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"RoleARN\":{\
          \"shape\":\"RoleARN\",\
          \"documentation\":\"<p>The Amazon Resource Name (ARN) of the AWS credentials. For more information, see <a href=\\\"https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html\\\">Amazon Resource Names (ARNs) and AWS Service Namespaces</a>.</p>\"\
        },\
        \"ClusterJDBCURL\":{\
          \"shape\":\"ClusterJDBCURL\",\
          \"documentation\":\"<p>The database connection string.</p>\"\
        },\
        \"CopyCommand\":{\
          \"shape\":\"CopyCommand\",\
          \"documentation\":\"<p>The <code>COPY</code> command.</p>\"\
        },\
        \"Username\":{\
          \"shape\":\"Username\",\
          \"documentation\":\"<p>The name of the user.</p>\"\
        },\
        \"Password\":{\
          \"shape\":\"Password\",\
          \"documentation\":\"<p>The user password.</p>\"\
        },\
        \"RetryOptions\":{\
          \"shape\":\"RedshiftRetryOptions\",\
          \"documentation\":\"<p>The retry behavior in case Kinesis Data Firehose is unable to deliver documents to Amazon Redshift. Default value is 3600 (60 minutes).</p>\"\
        },\
        \"S3Update\":{\
          \"shape\":\"S3DestinationUpdate\",\
          \"documentation\":\"<p>The Amazon S3 destination.</p> <p>The compression formats <code>SNAPPY</code> or <code>ZIP</code> cannot be specified in <code>RedshiftDestinationUpdate.S3Update</code> because the Amazon Redshift <code>COPY</code> operation that reads from the S3 bucket doesn't support these compression formats.</p>\"\
        },\
        \"ProcessingConfiguration\":{\
          \"shape\":\"ProcessingConfiguration\",\
          \"documentation\":\"<p>The data processing configuration.</p>\"\
        },\
        \"S3BackupMode\":{\
          \"shape\":\"RedshiftS3BackupMode\",\
          \"documentation\":\"<p>The Amazon S3 backup mode.</p>\"\
        },\
        \"S3BackupUpdate\":{\
          \"shape\":\"S3DestinationUpdate\",\
          \"documentation\":\"<p>The Amazon S3 destination for backup.</p>\"\
        },\
        \"CloudWatchLoggingOptions\":{\
          \"shape\":\"CloudWatchLoggingOptions\",\
          \"documentation\":\"<p>The Amazon CloudWatch logging options for your delivery stream.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Describes an update for a destination in Amazon Redshift.</p>\"\
    },\
    \"RedshiftRetryDurationInSeconds\":{\
      \"type\":\"integer\",\
      \"max\":7200,\
      \"min\":0\
    },\
    \"RedshiftRetryOptions\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"DurationInSeconds\":{\
          \"shape\":\"RedshiftRetryDurationInSeconds\",\
          \"documentation\":\"<p>The length of time during which Kinesis Data Firehose retries delivery after a failure, starting from the initial request and including the first attempt. The default value is 3600 seconds (60 minutes). Kinesis Data Firehose does not retry if the value of <code>DurationInSeconds</code> is 0 (zero) or if the first delivery attempt takes longer than the current value.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Configures retry behavior in case Kinesis Data Firehose is unable to deliver documents to Amazon Redshift.</p>\"\
    },\
    \"RedshiftS3BackupMode\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"Disabled\",\
        \"Enabled\"\
      ]\
    },\
    \"ResourceInUseException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\
          \"shape\":\"ErrorMessage\",\
          \"documentation\":\"<p>A message that provides information about the error.</p>\"\
        }\
      },\
      \"documentation\":\"<p>The resource is already in use and not available for this operation.</p>\",\
      \"exception\":true\
    },\
    \"ResourceNotFoundException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\
          \"shape\":\"ErrorMessage\",\
          \"documentation\":\"<p>A message that provides information about the error.</p>\"\
        }\
      },\
      \"documentation\":\"<p>The specified resource could not be found.</p>\",\
      \"exception\":true\
    },\
    \"RoleARN\":{\
      \"type\":\"string\",\
      \"max\":512,\
      \"min\":1,\
      \"pattern\":\"arn:.*\"\
    },\
    \"S3BackupMode\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"Disabled\",\
        \"Enabled\"\
      ]\
    },\
    \"S3DestinationConfiguration\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"RoleARN\",\
        \"BucketARN\"\
      ],\
      \"members\":{\
        \"RoleARN\":{\
          \"shape\":\"RoleARN\",\
          \"documentation\":\"<p>The Amazon Resource Name (ARN) of the AWS credentials. For more information, see <a href=\\\"https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html\\\">Amazon Resource Names (ARNs) and AWS Service Namespaces</a>.</p>\"\
        },\
        \"BucketARN\":{\
          \"shape\":\"BucketARN\",\
          \"documentation\":\"<p>The ARN of the S3 bucket. For more information, see <a href=\\\"https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html\\\">Amazon Resource Names (ARNs) and AWS Service Namespaces</a>.</p>\"\
        },\
        \"Prefix\":{\
          \"shape\":\"Prefix\",\
          \"documentation\":\"<p>The \\\"YYYY/MM/DD/HH\\\" time format prefix is automatically used for delivered Amazon S3 files. You can also specify a custom prefix, as described in <a href=\\\"https://docs.aws.amazon.com/firehose/latest/dev/s3-prefixes.html\\\">Custom Prefixes for Amazon S3 Objects</a>.</p>\"\
        },\
        \"ErrorOutputPrefix\":{\
          \"shape\":\"ErrorOutputPrefix\",\
          \"documentation\":\"<p>A prefix that Kinesis Data Firehose evaluates and adds to failed records before writing them to S3. This prefix appears immediately following the bucket name. For information about how to specify this prefix, see <a href=\\\"https://docs.aws.amazon.com/firehose/latest/dev/s3-prefixes.html\\\">Custom Prefixes for Amazon S3 Objects</a>.</p>\"\
        },\
        \"BufferingHints\":{\
          \"shape\":\"BufferingHints\",\
          \"documentation\":\"<p>The buffering option. If no value is specified, <code>BufferingHints</code> object default values are used.</p>\"\
        },\
        \"CompressionFormat\":{\
          \"shape\":\"CompressionFormat\",\
          \"documentation\":\"<p>The compression format. If no value is specified, the default is <code>UNCOMPRESSED</code>.</p> <p>The compression formats <code>SNAPPY</code> or <code>ZIP</code> cannot be specified for Amazon Redshift destinations because they are not supported by the Amazon Redshift <code>COPY</code> operation that reads from the S3 bucket.</p>\"\
        },\
        \"EncryptionConfiguration\":{\
          \"shape\":\"EncryptionConfiguration\",\
          \"documentation\":\"<p>The encryption configuration. If no value is specified, the default is no encryption.</p>\"\
        },\
        \"CloudWatchLoggingOptions\":{\
          \"shape\":\"CloudWatchLoggingOptions\",\
          \"documentation\":\"<p>The CloudWatch logging options for your delivery stream.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Describes the configuration of a destination in Amazon S3.</p>\"\
    },\
    \"S3DestinationDescription\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"RoleARN\",\
        \"BucketARN\",\
        \"BufferingHints\",\
        \"CompressionFormat\",\
        \"EncryptionConfiguration\"\
      ],\
      \"members\":{\
        \"RoleARN\":{\
          \"shape\":\"RoleARN\",\
          \"documentation\":\"<p>The Amazon Resource Name (ARN) of the AWS credentials. For more information, see <a href=\\\"https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html\\\">Amazon Resource Names (ARNs) and AWS Service Namespaces</a>.</p>\"\
        },\
        \"BucketARN\":{\
          \"shape\":\"BucketARN\",\
          \"documentation\":\"<p>The ARN of the S3 bucket. For more information, see <a href=\\\"https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html\\\">Amazon Resource Names (ARNs) and AWS Service Namespaces</a>.</p>\"\
        },\
        \"Prefix\":{\
          \"shape\":\"Prefix\",\
          \"documentation\":\"<p>The \\\"YYYY/MM/DD/HH\\\" time format prefix is automatically used for delivered Amazon S3 files. You can also specify a custom prefix, as described in <a href=\\\"https://docs.aws.amazon.com/firehose/latest/dev/s3-prefixes.html\\\">Custom Prefixes for Amazon S3 Objects</a>.</p>\"\
        },\
        \"ErrorOutputPrefix\":{\
          \"shape\":\"ErrorOutputPrefix\",\
          \"documentation\":\"<p>A prefix that Kinesis Data Firehose evaluates and adds to failed records before writing them to S3. This prefix appears immediately following the bucket name. For information about how to specify this prefix, see <a href=\\\"https://docs.aws.amazon.com/firehose/latest/dev/s3-prefixes.html\\\">Custom Prefixes for Amazon S3 Objects</a>.</p>\"\
        },\
        \"BufferingHints\":{\
          \"shape\":\"BufferingHints\",\
          \"documentation\":\"<p>The buffering option. If no value is specified, <code>BufferingHints</code> object default values are used.</p>\"\
        },\
        \"CompressionFormat\":{\
          \"shape\":\"CompressionFormat\",\
          \"documentation\":\"<p>The compression format. If no value is specified, the default is <code>UNCOMPRESSED</code>.</p>\"\
        },\
        \"EncryptionConfiguration\":{\
          \"shape\":\"EncryptionConfiguration\",\
          \"documentation\":\"<p>The encryption configuration. If no value is specified, the default is no encryption.</p>\"\
        },\
        \"CloudWatchLoggingOptions\":{\
          \"shape\":\"CloudWatchLoggingOptions\",\
          \"documentation\":\"<p>The Amazon CloudWatch logging options for your delivery stream.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Describes a destination in Amazon S3.</p>\"\
    },\
    \"S3DestinationUpdate\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"RoleARN\":{\
          \"shape\":\"RoleARN\",\
          \"documentation\":\"<p>The Amazon Resource Name (ARN) of the AWS credentials. For more information, see <a href=\\\"https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html\\\">Amazon Resource Names (ARNs) and AWS Service Namespaces</a>.</p>\"\
        },\
        \"BucketARN\":{\
          \"shape\":\"BucketARN\",\
          \"documentation\":\"<p>The ARN of the S3 bucket. For more information, see <a href=\\\"https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html\\\">Amazon Resource Names (ARNs) and AWS Service Namespaces</a>.</p>\"\
        },\
        \"Prefix\":{\
          \"shape\":\"Prefix\",\
          \"documentation\":\"<p>The \\\"YYYY/MM/DD/HH\\\" time format prefix is automatically used for delivered Amazon S3 files. You can also specify a custom prefix, as described in <a href=\\\"https://docs.aws.amazon.com/firehose/latest/dev/s3-prefixes.html\\\">Custom Prefixes for Amazon S3 Objects</a>.</p>\"\
        },\
        \"ErrorOutputPrefix\":{\
          \"shape\":\"ErrorOutputPrefix\",\
          \"documentation\":\"<p>A prefix that Kinesis Data Firehose evaluates and adds to failed records before writing them to S3. This prefix appears immediately following the bucket name. For information about how to specify this prefix, see <a href=\\\"https://docs.aws.amazon.com/firehose/latest/dev/s3-prefixes.html\\\">Custom Prefixes for Amazon S3 Objects</a>.</p>\"\
        },\
        \"BufferingHints\":{\
          \"shape\":\"BufferingHints\",\
          \"documentation\":\"<p>The buffering option. If no value is specified, <code>BufferingHints</code> object default values are used.</p>\"\
        },\
        \"CompressionFormat\":{\
          \"shape\":\"CompressionFormat\",\
          \"documentation\":\"<p>The compression format. If no value is specified, the default is <code>UNCOMPRESSED</code>.</p> <p>The compression formats <code>SNAPPY</code> or <code>ZIP</code> cannot be specified for Amazon Redshift destinations because they are not supported by the Amazon Redshift <code>COPY</code> operation that reads from the S3 bucket.</p>\"\
        },\
        \"EncryptionConfiguration\":{\
          \"shape\":\"EncryptionConfiguration\",\
          \"documentation\":\"<p>The encryption configuration. If no value is specified, the default is no encryption.</p>\"\
        },\
        \"CloudWatchLoggingOptions\":{\
          \"shape\":\"CloudWatchLoggingOptions\",\
          \"documentation\":\"<p>The CloudWatch logging options for your delivery stream.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Describes an update for a destination in Amazon S3.</p>\"\
    },\
    \"SchemaConfiguration\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"RoleARN\":{\
          \"shape\":\"NonEmptyStringWithoutWhitespace\",\
          \"documentation\":\"<p>The role that Kinesis Data Firehose can use to access AWS Glue. This role must be in the same account you use for Kinesis Data Firehose. Cross-account roles aren't allowed.</p>\"\
        },\
        \"CatalogId\":{\
          \"shape\":\"NonEmptyStringWithoutWhitespace\",\
          \"documentation\":\"<p>The ID of the AWS Glue Data Catalog. If you don't supply this, the AWS account ID is used by default.</p>\"\
        },\
        \"DatabaseName\":{\
          \"shape\":\"NonEmptyStringWithoutWhitespace\",\
          \"documentation\":\"<p>Specifies the name of the AWS Glue database that contains the schema for the output data.</p>\"\
        },\
        \"TableName\":{\
          \"shape\":\"NonEmptyStringWithoutWhitespace\",\
          \"documentation\":\"<p>Specifies the AWS Glue table that contains the column information that constitutes your data schema.</p>\"\
        },\
        \"Region\":{\
          \"shape\":\"NonEmptyStringWithoutWhitespace\",\
          \"documentation\":\"<p>If you don't specify an AWS Region, the default is the current Region.</p>\"\
        },\
        \"VersionId\":{\
          \"shape\":\"NonEmptyStringWithoutWhitespace\",\
          \"documentation\":\"<p>Specifies the table version for the output data schema. If you don't specify this version ID, or if you set it to <code>LATEST</code>, Kinesis Data Firehose uses the most recent version. This means that any updates to the table are automatically picked up.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Specifies the schema to which you want Kinesis Data Firehose to configure your data before it writes it to Amazon S3.</p>\"\
    },\
    \"Serializer\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"ParquetSerDe\":{\
          \"shape\":\"ParquetSerDe\",\
          \"documentation\":\"<p>A serializer to use for converting data to the Parquet format before storing it in Amazon S3. For more information, see <a href=\\\"https://parquet.apache.org/documentation/latest/\\\">Apache Parquet</a>.</p>\"\
        },\
        \"OrcSerDe\":{\
          \"shape\":\"OrcSerDe\",\
          \"documentation\":\"<p>A serializer to use for converting data to the ORC format before storing it in Amazon S3. For more information, see <a href=\\\"https://orc.apache.org/docs/\\\">Apache ORC</a>.</p>\"\
        }\
      },\
      \"documentation\":\"<p>The serializer that you want Kinesis Data Firehose to use to convert data to the target format before writing it to Amazon S3. Kinesis Data Firehose supports two types of serializers: the <a href=\\\"https://hive.apache.org/javadocs/r1.2.2/api/org/apache/hadoop/hive/ql/io/orc/OrcSerde.html\\\">ORC SerDe</a> and the <a href=\\\"https://hive.apache.org/javadocs/r1.2.2/api/org/apache/hadoop/hive/ql/io/parquet/serde/ParquetHiveSerDe.html\\\">Parquet SerDe</a>.</p>\"\
    },\
    \"ServiceUnavailableException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\
          \"shape\":\"ErrorMessage\",\
          \"documentation\":\"<p>A message that provides information about the error.</p>\"\
        }\
      },\
      \"documentation\":\"<p>The service is unavailable. Back off and retry the operation. If you continue to see the exception, throughput limits for the delivery stream may have been exceeded. For more information about limits and how to request an increase, see <a href=\\\"https://docs.aws.amazon.com/firehose/latest/dev/limits.html\\\">Amazon Kinesis Data Firehose Limits</a>.</p>\",\
      \"exception\":true,\
      \"fault\":true\
    },\
    \"SizeInMBs\":{\
      \"type\":\"integer\",\
      \"max\":128,\
      \"min\":1\
    },\
    \"SourceDescription\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"KinesisStreamSourceDescription\":{\
          \"shape\":\"KinesisStreamSourceDescription\",\
          \"documentation\":\"<p>The <a>KinesisStreamSourceDescription</a> value for the source Kinesis data stream.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Details about a Kinesis data stream used as the source for a Kinesis Data Firehose delivery stream.</p>\"\
    },\
    \"SplunkDestinationConfiguration\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"HECEndpoint\",\
        \"HECEndpointType\",\
        \"HECToken\",\
        \"S3Configuration\"\
      ],\
      \"members\":{\
        \"HECEndpoint\":{\
          \"shape\":\"HECEndpoint\",\
          \"documentation\":\"<p>The HTTP Event Collector (HEC) endpoint to which Kinesis Data Firehose sends your data.</p>\"\
        },\
        \"HECEndpointType\":{\
          \"shape\":\"HECEndpointType\",\
          \"documentation\":\"<p>This type can be either \\\"Raw\\\" or \\\"Event.\\\"</p>\"\
        },\
        \"HECToken\":{\
          \"shape\":\"HECToken\",\
          \"documentation\":\"<p>This is a GUID that you obtain from your Splunk cluster when you create a new HEC endpoint.</p>\"\
        },\
        \"HECAcknowledgmentTimeoutInSeconds\":{\
          \"shape\":\"HECAcknowledgmentTimeoutInSeconds\",\
          \"documentation\":\"<p>The amount of time that Kinesis Data Firehose waits to receive an acknowledgment from Splunk after it sends it data. At the end of the timeout period, Kinesis Data Firehose either tries to send the data again or considers it an error, based on your retry settings.</p>\"\
        },\
        \"RetryOptions\":{\
          \"shape\":\"SplunkRetryOptions\",\
          \"documentation\":\"<p>The retry behavior in case Kinesis Data Firehose is unable to deliver data to Splunk, or if it doesn't receive an acknowledgment of receipt from Splunk.</p>\"\
        },\
        \"S3BackupMode\":{\
          \"shape\":\"SplunkS3BackupMode\",\
          \"documentation\":\"<p>Defines how documents should be delivered to Amazon S3. When set to <code>FailedDocumentsOnly</code>, Kinesis Data Firehose writes any data that could not be indexed to the configured Amazon S3 destination. When set to <code>AllDocuments</code>, Kinesis Data Firehose delivers all incoming records to Amazon S3, and also writes failed documents to Amazon S3. Default value is <code>FailedDocumentsOnly</code>. </p>\"\
        },\
        \"S3Configuration\":{\
          \"shape\":\"S3DestinationConfiguration\",\
          \"documentation\":\"<p>The configuration for the backup Amazon S3 location.</p>\"\
        },\
        \"ProcessingConfiguration\":{\
          \"shape\":\"ProcessingConfiguration\",\
          \"documentation\":\"<p>The data processing configuration.</p>\"\
        },\
        \"CloudWatchLoggingOptions\":{\
          \"shape\":\"CloudWatchLoggingOptions\",\
          \"documentation\":\"<p>The Amazon CloudWatch logging options for your delivery stream.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Describes the configuration of a destination in Splunk.</p>\"\
    },\
    \"SplunkDestinationDescription\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"HECEndpoint\":{\
          \"shape\":\"HECEndpoint\",\
          \"documentation\":\"<p>The HTTP Event Collector (HEC) endpoint to which Kinesis Data Firehose sends your data.</p>\"\
        },\
        \"HECEndpointType\":{\
          \"shape\":\"HECEndpointType\",\
          \"documentation\":\"<p>This type can be either \\\"Raw\\\" or \\\"Event.\\\"</p>\"\
        },\
        \"HECToken\":{\
          \"shape\":\"HECToken\",\
          \"documentation\":\"<p>A GUID you obtain from your Splunk cluster when you create a new HEC endpoint.</p>\"\
        },\
        \"HECAcknowledgmentTimeoutInSeconds\":{\
          \"shape\":\"HECAcknowledgmentTimeoutInSeconds\",\
          \"documentation\":\"<p>The amount of time that Kinesis Data Firehose waits to receive an acknowledgment from Splunk after it sends it data. At the end of the timeout period, Kinesis Data Firehose either tries to send the data again or considers it an error, based on your retry settings.</p>\"\
        },\
        \"RetryOptions\":{\
          \"shape\":\"SplunkRetryOptions\",\
          \"documentation\":\"<p>The retry behavior in case Kinesis Data Firehose is unable to deliver data to Splunk or if it doesn't receive an acknowledgment of receipt from Splunk.</p>\"\
        },\
        \"S3BackupMode\":{\
          \"shape\":\"SplunkS3BackupMode\",\
          \"documentation\":\"<p>Defines how documents should be delivered to Amazon S3. When set to <code>FailedDocumentsOnly</code>, Kinesis Data Firehose writes any data that could not be indexed to the configured Amazon S3 destination. When set to <code>AllDocuments</code>, Kinesis Data Firehose delivers all incoming records to Amazon S3, and also writes failed documents to Amazon S3. Default value is <code>FailedDocumentsOnly</code>. </p>\"\
        },\
        \"S3DestinationDescription\":{\
          \"shape\":\"S3DestinationDescription\",\
          \"documentation\":\"<p>The Amazon S3 destination.&gt;</p>\"\
        },\
        \"ProcessingConfiguration\":{\
          \"shape\":\"ProcessingConfiguration\",\
          \"documentation\":\"<p>The data processing configuration.</p>\"\
        },\
        \"CloudWatchLoggingOptions\":{\
          \"shape\":\"CloudWatchLoggingOptions\",\
          \"documentation\":\"<p>The Amazon CloudWatch logging options for your delivery stream.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Describes a destination in Splunk.</p>\"\
    },\
    \"SplunkDestinationUpdate\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"HECEndpoint\":{\
          \"shape\":\"HECEndpoint\",\
          \"documentation\":\"<p>The HTTP Event Collector (HEC) endpoint to which Kinesis Data Firehose sends your data.</p>\"\
        },\
        \"HECEndpointType\":{\
          \"shape\":\"HECEndpointType\",\
          \"documentation\":\"<p>This type can be either \\\"Raw\\\" or \\\"Event.\\\"</p>\"\
        },\
        \"HECToken\":{\
          \"shape\":\"HECToken\",\
          \"documentation\":\"<p>A GUID that you obtain from your Splunk cluster when you create a new HEC endpoint.</p>\"\
        },\
        \"HECAcknowledgmentTimeoutInSeconds\":{\
          \"shape\":\"HECAcknowledgmentTimeoutInSeconds\",\
          \"documentation\":\"<p>The amount of time that Kinesis Data Firehose waits to receive an acknowledgment from Splunk after it sends data. At the end of the timeout period, Kinesis Data Firehose either tries to send the data again or considers it an error, based on your retry settings.</p>\"\
        },\
        \"RetryOptions\":{\
          \"shape\":\"SplunkRetryOptions\",\
          \"documentation\":\"<p>The retry behavior in case Kinesis Data Firehose is unable to deliver data to Splunk or if it doesn't receive an acknowledgment of receipt from Splunk.</p>\"\
        },\
        \"S3BackupMode\":{\
          \"shape\":\"SplunkS3BackupMode\",\
          \"documentation\":\"<p>Defines how documents should be delivered to Amazon S3. When set to <code>FailedDocumentsOnly</code>, Kinesis Data Firehose writes any data that could not be indexed to the configured Amazon S3 destination. When set to <code>AllDocuments</code>, Kinesis Data Firehose delivers all incoming records to Amazon S3, and also writes failed documents to Amazon S3. Default value is <code>FailedDocumentsOnly</code>. </p>\"\
        },\
        \"S3Update\":{\
          \"shape\":\"S3DestinationUpdate\",\
          \"documentation\":\"<p>Your update to the configuration of the backup Amazon S3 location.</p>\"\
        },\
        \"ProcessingConfiguration\":{\
          \"shape\":\"ProcessingConfiguration\",\
          \"documentation\":\"<p>The data processing configuration.</p>\"\
        },\
        \"CloudWatchLoggingOptions\":{\
          \"shape\":\"CloudWatchLoggingOptions\",\
          \"documentation\":\"<p>The Amazon CloudWatch logging options for your delivery stream.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Describes an update for a destination in Splunk.</p>\"\
    },\
    \"SplunkRetryDurationInSeconds\":{\
      \"type\":\"integer\",\
      \"max\":7200,\
      \"min\":0\
    },\
    \"SplunkRetryOptions\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"DurationInSeconds\":{\
          \"shape\":\"SplunkRetryDurationInSeconds\",\
          \"documentation\":\"<p>The total amount of time that Kinesis Data Firehose spends on retries. This duration starts after the initial attempt to send data to Splunk fails. It doesn't include the periods during which Kinesis Data Firehose waits for acknowledgment from Splunk after each attempt.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Configures retry behavior in case Kinesis Data Firehose is unable to deliver documents to Splunk, or if it doesn't receive an acknowledgment from Splunk.</p>\"\
    },\
    \"SplunkS3BackupMode\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"FailedEventsOnly\",\
        \"AllEvents\"\
      ]\
    },\
    \"StartDeliveryStreamEncryptionInput\":{\
      \"type\":\"structure\",\
      \"required\":[\"DeliveryStreamName\"],\
      \"members\":{\
        \"DeliveryStreamName\":{\
          \"shape\":\"DeliveryStreamName\",\
          \"documentation\":\"<p>The name of the delivery stream for which you want to enable server-side encryption (SSE).</p>\"\
        }\
      }\
    },\
    \"StartDeliveryStreamEncryptionOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
      }\
    },\
    \"StopDeliveryStreamEncryptionInput\":{\
      \"type\":\"structure\",\
      \"required\":[\"DeliveryStreamName\"],\
      \"members\":{\
        \"DeliveryStreamName\":{\
          \"shape\":\"DeliveryStreamName\",\
          \"documentation\":\"<p>The name of the delivery stream for which you want to disable server-side encryption (SSE).</p>\"\
        }\
      }\
    },\
    \"StopDeliveryStreamEncryptionOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
      }\
    },\
    \"Tag\":{\
      \"type\":\"structure\",\
      \"required\":[\"Key\"],\
      \"members\":{\
        \"Key\":{\
          \"shape\":\"TagKey\",\
          \"documentation\":\"<p>A unique identifier for the tag. Maximum length: 128 characters. Valid characters: Unicode letters, digits, white space, _ . / = + - % @</p>\"\
        },\
        \"Value\":{\
          \"shape\":\"TagValue\",\
          \"documentation\":\"<p>An optional string, which you can use to describe or define the tag. Maximum length: 256 characters. Valid characters: Unicode letters, digits, white space, _ . / = + - % @</p>\"\
        }\
      },\
      \"documentation\":\"<p>Metadata that you can assign to a delivery stream, consisting of a key-value pair.</p>\"\
    },\
    \"TagDeliveryStreamInput\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"DeliveryStreamName\",\
        \"Tags\"\
      ],\
      \"members\":{\
        \"DeliveryStreamName\":{\
          \"shape\":\"DeliveryStreamName\",\
          \"documentation\":\"<p>The name of the delivery stream to which you want to add the tags.</p>\"\
        },\
        \"Tags\":{\
          \"shape\":\"TagDeliveryStreamInputTagList\",\
          \"documentation\":\"<p>A set of key-value pairs to use to create the tags.</p>\"\
        }\
      }\
    },\
    \"TagDeliveryStreamInputTagList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"Tag\"},\
      \"max\":50,\
      \"min\":1\
    },\
    \"TagDeliveryStreamOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
      }\
    },\
    \"TagKey\":{\
      \"type\":\"string\",\
      \"max\":128,\
      \"min\":1\
    },\
    \"TagKeyList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"TagKey\"},\
      \"max\":50,\
      \"min\":1\
    },\
    \"TagValue\":{\
      \"type\":\"string\",\
      \"max\":256,\
      \"min\":0\
    },\
    \"Timestamp\":{\"type\":\"timestamp\"},\
    \"UntagDeliveryStreamInput\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"DeliveryStreamName\",\
        \"TagKeys\"\
      ],\
      \"members\":{\
        \"DeliveryStreamName\":{\
          \"shape\":\"DeliveryStreamName\",\
          \"documentation\":\"<p>The name of the delivery stream.</p>\"\
        },\
        \"TagKeys\":{\
          \"shape\":\"TagKeyList\",\
          \"documentation\":\"<p>A list of tag keys. Each corresponding tag is removed from the delivery stream.</p>\"\
        }\
      }\
    },\
    \"UntagDeliveryStreamOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
      }\
    },\
    \"UpdateDestinationInput\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"DeliveryStreamName\",\
        \"CurrentDeliveryStreamVersionId\",\
        \"DestinationId\"\
      ],\
      \"members\":{\
        \"DeliveryStreamName\":{\
          \"shape\":\"DeliveryStreamName\",\
          \"documentation\":\"<p>The name of the delivery stream.</p>\"\
        },\
        \"CurrentDeliveryStreamVersionId\":{\
          \"shape\":\"DeliveryStreamVersionId\",\
          \"documentation\":\"<p>Obtain this value from the <code>VersionId</code> result of <a>DeliveryStreamDescription</a>. This value is required, and helps the service perform conditional operations. For example, if there is an interleaving update and this value is null, then the update destination fails. After the update is successful, the <code>VersionId</code> value is updated. The service then performs a merge of the old configuration with the new configuration.</p>\"\
        },\
        \"DestinationId\":{\
          \"shape\":\"DestinationId\",\
          \"documentation\":\"<p>The ID of the destination.</p>\"\
        },\
        \"S3DestinationUpdate\":{\
          \"shape\":\"S3DestinationUpdate\",\
          \"documentation\":\"<p>[Deprecated] Describes an update for a destination in Amazon S3.</p>\",\
          \"deprecated\":true\
        },\
        \"ExtendedS3DestinationUpdate\":{\
          \"shape\":\"ExtendedS3DestinationUpdate\",\
          \"documentation\":\"<p>Describes an update for a destination in Amazon S3.</p>\"\
        },\
        \"RedshiftDestinationUpdate\":{\
          \"shape\":\"RedshiftDestinationUpdate\",\
          \"documentation\":\"<p>Describes an update for a destination in Amazon Redshift.</p>\"\
        },\
        \"ElasticsearchDestinationUpdate\":{\
          \"shape\":\"ElasticsearchDestinationUpdate\",\
          \"documentation\":\"<p>Describes an update for a destination in Amazon ES.</p>\"\
        },\
        \"SplunkDestinationUpdate\":{\
          \"shape\":\"SplunkDestinationUpdate\",\
          \"documentation\":\"<p>Describes an update for a destination in Splunk.</p>\"\
        }\
      }\
    },\
    \"UpdateDestinationOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
      }\
    },\
    \"Username\":{\
      \"type\":\"string\",\
      \"min\":1,\
      \"sensitive\":true\
    }\
  },\
  \"documentation\":\"<fullname>Amazon Kinesis Data Firehose API Reference</fullname> <p>Amazon Kinesis Data Firehose is a fully managed service that delivers real-time streaming data to destinations such as Amazon Simple Storage Service (Amazon S3), Amazon Elasticsearch Service (Amazon ES), Amazon Redshift, and Splunk.</p>\"\
}\
";
}

@end
