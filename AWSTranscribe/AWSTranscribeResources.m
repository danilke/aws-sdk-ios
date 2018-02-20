//
// Copyright 2010-2018 Amazon.com, Inc. or its affiliates. All Rights Reserved.
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

#import "AWSTranscribeResources.h"
#import <AWSCore/AWSCocoaLumberjack.h>

@interface AWSTranscribeResources ()

@property (nonatomic, strong) NSDictionary *definitionDictionary;

@end

@implementation AWSTranscribeResources

+ (instancetype)sharedInstance {
	static AWSTranscribeResources *_sharedResources = nil;
	static dispatch_once_t once_token;

	dispatch_once(&once_token, ^{
		_sharedResources = [AWSTranscribeResources new];
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
		\"apiVersion\":\"2006-03-01\",\
		\"checksumFormat\":\"md5\",\
		\"endpointPrefix\":\"transcribe\",\
		\"globalEndpoint\":\"transcribe.amazonaws.com\",\
		\"protocol\":\"rest-xml\",\
		\"serviceAbbreviation\":\"Amazon Transcribe\",\
		\"serviceFullName\":\"Amazon Transcribe\",\
		\"signatureVersion\":\"transcribe\",\
		\"timestampFormat\":\"rfc822\",\
		\"uid\":\"transcribe-2018-02-18\"\
	},\
	\"operations\":{\
		\"ListBucketMetricsConfigurations\":{\
			\"name\":\"ListBucketMetricsConfigurations\",\
			\"http\":{\
			\"method\":\"GET\",\
			\"requestUri\":\"/{Bucket}?metrics\"\
			},\
			\"input\":{\"shape\":\"ListBucketMetricsConfigurationsRequest\"},\
			\"output\":{\"shape\":\"ListBucketMetricsConfigurationsOutput\"},\
			\"documentation\":\"Lists the metrics configurations for the bucket.\"\
		},\
		\"ListBuckets\":{\
			\"name\":\"ListBuckets\",\
			\"http\":{\
			\"method\":\"GET\",\
			\"requestUri\":\"/\"\
			},\
			\"output\":{\"shape\":\"ListBucketsOutput\"},\
			\"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/RESTServiceGET.html\",\
			\"documentation\":\"Returns a list of all buckets owned by the authenticated sender of the request.\",\
			\"alias\":\"GetService\"\
		},\
	},\
	\"shapes\":{\
		\"ListBucketsOutput\":{\
			\"type\":\"structure\",\
			\"members\":{\
			\"Buckets\":{\"shape\":\"Buckets\"},\
			\"Owner\":{\"shape\":\"Owner\"}\
		}\
	},\
	}\
";
}

@end

