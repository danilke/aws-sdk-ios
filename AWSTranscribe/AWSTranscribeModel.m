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

#import "AWSTranscribeModel.h"

NSString *const AWSTranscribeErrorDomain = @"com.amazonaws.AWSTranscribeErrorDomain";

//------------------------------------------------------------------------------

@implementation AWSModel(AWSTransaction)

+ (NSArray*)jobStatusStrings {
	return @[@"COMPLETED", @"FAILED", @"IN_PROGRESS"];
}

+ (NSArray*)languageCodeStrings {
	return @[@"en-US", @"es-US"];
}

+ (NSArray *)mediaFormatStrings {
	return @[@"flac", @"mp3", @"mp4", @"wav"];
}

+ (NSValueTransformer *)transformDate {
	return [AWSMTLValueTransformer reversibleTransformerWithForwardBlock:^id(NSNumber *number) {
		return [NSDate dateWithTimeIntervalSince1970:[number doubleValue]];
	} reverseBlock:^id(NSDate *date) {
		return [NSString stringWithFormat:@"%f", [date timeIntervalSince1970]];
	}];
}

+ (NSValueTransformer*)transformWith:(NSArray*)strings {
	return [AWSMTLValueTransformer reversibleTransformerWithForwardBlock:^NSNumber *(NSString *value) {
		NSUInteger index = [strings indexOfObject:value];
		if (index != NSNotFound) {
			return @(index);
		}
		return @(strings.count);
	} reverseBlock:^NSString *(NSNumber *value) {
		if (value.unsignedIntegerValue < strings.count) {
			return strings[value.unsignedIntegerValue];
		}
		return nil;
	}];
}

@end

//------------------------------------------------------------------------------
#pragma mark GetTranscriptionJobRequest
//------------------------------------------------------------------------------

@implementation AWSTranscribeGetTranscriptionJobRequest

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
	return @{
		@"jobName" : @"TranscriptionJobName",
	};
}

@end

//------------------------------------------------------------------------------

@implementation AWSTranscribeGetTranscriptionJobOutput

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
	return @{
		 @"job" : @"TranscriptionJob",
	};
}

+ (NSValueTransformer *)jobTransformer {
	return [NSValueTransformer awsmtl_JSONDictionaryTransformerWithModelClass:[AWSTranscribeJob class]];
}

@end

//------------------------------------------------------------------------------
#pragma mark ListTranscriptionJobsRequest
//------------------------------------------------------------------------------

@implementation AWSTranscribeListTranscriptionJobsRequest

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
	return @{
		@"status" : @"Status",
		@"maxResults" : @"MaxResults",
		@"nextToken" : @"NextToken",
	};
}

+ (NSValueTransformer *)statusJSONTransformer {
	return [AWSModel transformWith:[AWSModel jobStatusStrings]];
}

@end

//------------------------------------------------------------------------------

@implementation AWSTranscribeListTranscriptionJobsOutput

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
	return @{
		@"jobSummaries" : @"TranscriptionJobSummaries",
		@"nextToken" : @"NextToken",
		@"status" : @"Status",
	};
}

+ (NSValueTransformer *)jobSummariesJSONTransformer {
	return [NSValueTransformer awsmtl_JSONArrayTransformerWithModelClass:[AWSTranscribeJobSummaries class]];
}

+ (NSValueTransformer *)statusJSONTransformer {
	return [AWSModel transformWith:[AWSModel jobStatusStrings]];
}

@end

//------------------------------------------------------------------------------
#pragma mark StartTranscriptionJobRequest
//------------------------------------------------------------------------------

@implementation AWSTranscribeStartTranscriptionJobRequest

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
	return @{
		@"jobName" : @"TranscriptionJobName",
		@"languageCode" : @"LanguageCode",
		@"media" : @"Media",
		@"mediaFormat" : @"MediaFormat",
		@"mediaSampleRateHertz" : @"MediaSampleRateHertz",
	};
}

+ (NSValueTransformer *)languageCodeJSONTransformer {
	return [AWSModel transformWith:[AWSModel languageCodeStrings]];
}

+ (NSValueTransformer *)mediaJSONTransformer {
	return [NSValueTransformer awsmtl_JSONDictionaryTransformerWithModelClass:[AWSTranscribeMedia class]];
}

+ (NSValueTransformer *)mediaFormatJSONTransformer {
	return [AWSModel transformWith:[AWSModel mediaFormatStrings]];
}

@end

//------------------------------------------------------------------------------

@implementation AWSTranscribeStartTranscriptionJobOutput

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
	return @{
		@"job" : @"TranscriptionJob",
	};
}

+ (NSValueTransformer *)jobTransformer {
	return [NSValueTransformer awsmtl_JSONDictionaryTransformerWithModelClass:[AWSTranscribeJob class]];
}

@end

//------------------------------------------------------------------------------
#pragma mark Utility Models
//------------------------------------------------------------------------------

@implementation AWSTranscribeJobSummaries

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
	return @{
		@"completionTime" : @"CompletionTime",
		@"creationTime" : @"CreationTime",
		@"failureReason" : @"FailureReason",
		@"jobName" : @"TranscriptionJobName",
		@"jobStatus" : @"TranscriptionJobStatus",
		@"languageCode" : @"LanguageCode",
	 };
}

+ (NSValueTransformer *)completionTimeJSONTransformer {
	return [AWSModel transformDate];
}

+ (NSValueTransformer *)creationTimeJSONTransformer {
	return [AWSModel transformDate];
}

+ (NSValueTransformer *)jobStatusJSONTransformer {
	return [AWSModel transformWith:[AWSModel jobStatusStrings]];
}

+ (NSValueTransformer *)languageCodeJSONTransformer {
	return [AWSModel transformWith:[AWSModel languageCodeStrings]];
}

@end

//------------------------------------------------------------------------------

@implementation AWSTranscribeJob

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
	NSMutableDictionary* retVal = [NSMutableDictionary dictionaryWithDictionary:[super JSONKeyPathsByPropertyKey]];
	NSDictionary* local = @{
		@"media" : @"Media",
		@"mediaFormat" : @"MediaFormat",
		@"mediaSampleRateHertz" : @"MediaSampleRateHertz",
		@"transcript" : @"Transcript",
	};

	[retVal addEntriesFromDictionary:local];
	return retVal;
}

+ (NSValueTransformer *)mediaJSONTransformer {
	return [NSValueTransformer awsmtl_JSONDictionaryTransformerWithModelClass:[AWSTranscribeMedia class]];
}

+ (NSValueTransformer *)mediaFormatJSONTransformer {
	return [AWSModel transformWith:[AWSModel mediaFormatStrings]];
}

+ (NSValueTransformer *)transcriptJSONTransformer {
	return [NSValueTransformer awsmtl_JSONDictionaryTransformerWithModelClass:[AWSTranscribeTranscript class]];
}

@end

//------------------------------------------------------------------------------

@implementation AWSTranscribeMedia

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
	return @{
			 @"fileUri" : @"MediaFileUri",
			 };
}

@end

//------------------------------------------------------------------------------

@implementation AWSTranscribeTranscript

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
	return @{
		@"fileUri" : @"TranscriptFileUri",
	};
}

@end


