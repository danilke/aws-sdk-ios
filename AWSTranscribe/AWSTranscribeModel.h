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

#import <Foundation/Foundation.h>
#import <AWSCore/AWSNetworking.h>
#import <AWSCore/AWSModel.h>

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSString *const AWSTranscribeErrorDomain;

@class AWSTranscribeGetTranscriptionJobRequest;
@class AWSTranscribeGetTranscriptionJobOutput;
@class AWSTranscribeListTranscriptionJobsRequest;
@class AWSTranscribeListTranscriptionJobsOutput;
@class AWSTranscribeStartTranscriptionJobRequest;
@class AWSTranscribeStartTranscriptionJobOutput;
@class AWSTranscribeJobSummaries;
@class AWSTranscribeMedia;
@class AWSTranscribeTranscript;
@class AWSTranscribeJob;

/**
 The status of AWS Transcribe jobs.
 */
typedef NS_ENUM(NSInteger, AWSTranscribeJobStatus) {
	/**
	 The job has completed successfully.
	 */
	AWSTranscribeJobStatusCompleted,
	/**
	 The jobs has completed but failed.
	 */
	AWSTranscribeJobStatusFailed,
	/**
	 The job is still be processed by AWS Transcribe.
	 */
	AWSTranscribeJobStatusInProgress,
};

/**
 The language codes for the input speech supported by AWSTranscribe.
 */
typedef NS_ENUM(NSInteger, AWSTranscribeLanguageCode) {
	AWSTranscribeLanguageCodeEn_US,
	AWSTranscribeLanguageCodeEs_US,
};

/**
 The formats of the input media files supported by AWSTranscribe.
 */
typedef NS_ENUM(NSInteger, AWSTranscribeMediaFormat) {
	AWSTranscribeMediaFormatFlac,
	AWSTranscribeMediaFormatMP3,
	AWSTranscribeMediaFormatMP4,
	AWSTranscribeMediaFormatWav,
};

/**
 Errors returned by AWSTrnascribe endpoints
 */
typedef NS_ENUM(NSInteger, AWSTranscribeError) {
	/**
	 There is a problem with one of the input fields. Check the S3 bucket name,
	 make sure that the job name is not a duplicate, and confirm that you are
	 using the correct file format. Then resend your request.

	 HTTP Status Code: 400
	 */
	AWSTranscribeErrorBadRequestException,

	/**
	 The `jobName` field is a duplicate of a previously entered job name.
	 Resend your request with a different name.

	 HTTP Status Code: 400
	 */
	AWSTranscribeConflictException,

	/**
	 There was an internal error. Check the error message and try your request again.

	 HTTP Status Code: 500
	 */
	AWSTranscribeErrorInternalFailureException,

	/**
	 Either you have sent too many requests or your input file is longer than 2
	 hours. Wait before you resend your request, or use a smaller file and resend
	 the request.

	 HTTP Status Code: 400
	 */
	AWSTranscribeErrorLimitExceededException,

	/**
	 We can't find the requested job. Check the job name and try your request again.

	 HTTP Status Code: 400
	 */
	AWSTranscribeErrorNotFoundException,

	/**
	 Unknown error condition with the AWS Transcribe service
	 */
	AWSTranscribeErrorUnknown,
};

/**
 Describes an asynchronous request to return information about a transcription job.

 Returns a `AWSTranscribeGetTranscriptionJobOutput` object.

 @see AWSTranscribeGetTranscriptionJobOutput
 */
@interface AWSTranscribeGetTranscriptionJobRequest : AWSRequest

/**
 The name of the job.

 @attention This field is required.

 @requires Minimum length of 1. Maximum length of 200.

 @requires Pattern: ^[0-9a-zA-Z._-]+
 */
@property (nonatomic, strong) NSString* _Nullable jobName;

@end

/**
 Response returned with a successful `GetTranscriptionJob` request.

 The response contains the information about a transcription job. To see the
 status of the job, check the jobStatus field. If the status is Completed, the
 job is finished and you can find the results at the location specified in the
 media fileUri field.

 @see AWSTranscribeGetTranscriptionJobRequest

 @see AWSTranscribeJob
 */
@interface AWSTranscribeGetTranscriptionJobOutput : AWSModel

/**
 An object that contains the results of the transcription job.
 */
@property (nonatomic, strong) AWSTranscribeJob* _Nullable job;

@end

/**
 Describes an asynchronous request to list transcription jobs with the specified
 status.

 Returns a `AWSTranscribeListTranscriptionJobsOutput` object.

 @see AWSTranscribeListTranscriptionJobsOutput
 */
@interface AWSTranscribeListTranscriptionJobsRequest : AWSRequest

/**
 The maximum number of jobs to return in the response.

 @requires Valid Range: Minimum value of 1. Maximum value of 100.
 */
@property (nonatomic, strong) NSNumber* _Nullable maxResults;

/**
 If the result of the previous request to `ListTranscriptionJobs` request
 was truncated, include the `nextToken` to fetch the next set of jobs.

 @requires Length Constraints: Maximum length of 8192.
 */
@property (nonatomic, strong) NSString* _Nullable nextToken;

/**
 Returns only transcription jobs with the specified status.

 @attention This field is required.

 @see AWSTranscribeJobStatus
 */
@property (nonatomic, assign) AWSTranscribeJobStatus status;

@end

/**
 Response returned with a successful `ListTranscriptionJobsRequest`.

 The response contains the information about all transcription jobs matching
 the status in the request. To see the status of the jobs, check the jobStatus
 field. If the status is Completed, the job is finished and you can find the
 results at the location specified in the media fileUri field.

 @see AWSTranscribeListTranscriptionJobsRequest
 */
@interface AWSTranscribeListTranscriptionJobsOutput : AWSModel

/**
 An array of `AWSTranscribeJobSummaries` objects containing
 summary information for a transcription job.

 @see AWSTranscribeJobSummaries
 */
@property (nonatomic, strong) NSArray* _Nullable jobSummaries;

/**
 If the result of the previous request to `AWSTranscribeListTranscriptionJobsRequest`
 was truncated, include the `nextToken` to fetch the next set of jobs.

 @requires Length Constraints: Maximum length of 8192.
 */
@property (nonatomic, strong) NSString* _Nullable nextToken;

/**
 When specified, returns only transcription jobs with the specified status.

 @see AWSTranscribeJobStatus
 */
@property (nonatomic, assign) AWSTranscribeJobStatus status;

@end

/**
 Describes an asynchronous job to transcribe speech to text.

 Returns a `AWSTranscribeStartTranscriptionJobOutput` object.

 @see AWSTranscribeStartTranscriptionJobOutput
 */
@interface AWSTranscribeStartTranscriptionJobRequest : AWSRequest

/**
 The name of the job.

 @attention Required field.

 @requires Minimum length of 1. Maximum length of 200.

 @requires Pattern: ^[0-9a-zA-Z._-]+
 */
@property (nonatomic, strong) NSString* _Nullable jobName;

/**
 The language code for the input speech.

 @attention Required field.

 @see AWSTranscribeLanguageCode
 */
@property (nonatomic, assign) AWSTranscribeLanguageCode languageCode;

/**
 An object that describes the input media for a transcription job.

 @attention Required field.

 @see AWSTranscribeMedia
 */
@property (nonatomic, strong) AWSTranscribeMedia* _Nullable media;

/**
 The format of the input media file.

 @see AWSTranscribeMediaFormat
 */
@property (nonatomic, assign) AWSTranscribeMediaFormat mediaFormat;

/**
 The sample rate, in Hertz, of the audio track in the input media file.

 @requires Valid Range: Minimum value of 8000. Maximum value of 48000.
 */
@property (nonatomic, strong) NSNumber* _Nullable mediaSampleRateHertz;

@end

/**
 Response returned with a successful `StartTranscriptionJob` request.

 The response contains the information about the transcription job.

 @see AWSTranscribeStartTranscriptionJobRequest

 @see AWSTranscribeJob

 */
@interface AWSTranscribeStartTranscriptionJobOutput : AWSModel

/**
 An object that contains the results of the transcription job.
 */
@property (nonatomic, strong) AWSTranscribeJob* _Nullable job;

@end

/**
 Provides a summary of information about a transcription job.
 */
@interface AWSTranscribeJobSummaries : AWSModel

@property (nonatomic, strong) AWSTranscribeJobSummaries* _Nullable transcriptionJobSummaries;

/**
 Timestamp of the date and time that the job completed.
 */
@property (nonatomic, strong) NSDate* _Nullable completionTime;

/**
 Timestamp of the date and time that the job was created.
 */
@property (nonatomic, strong) NSDate* _Nullable creationTime;

/**
 If the `jobStatus` field is FAILED, this field contains information about why
 the job failed.
 */
@property (nonatomic, strong) NSString* _Nullable failureReason;

/**
 The name of the job.

 @requires Minimum length of 1. Maximum length of 200.

 @requires Pattern: ^[0-9a-zA-Z._-]+
 */
@property (nonatomic, strong) NSString* _Nullable jobName;

/**
 The status of the transcription job.
 */
@property (nonatomic, assign) AWSTranscribeJobStatus jobStatus;

/**
 The language code for the input speech.

 @see AWSTranscribeLanguageCode
 */
@property (nonatomic, assign) AWSTranscribeLanguageCode languageCode;

@end

/**
 Describes an asynchronous transcription job that was created with the
 `AWSTranscribeStartTranscriptionJobRequest` operation.

 @see AWSTranscribeStartTranscriptionJobRequest
 */
@interface AWSTranscribeJob : AWSTranscribeJobSummaries

/**
 An object that describes the input media for a transcription job.

 @see AWSTranscribeMedia
 */
@property (nonatomic, strong) AWSTranscribeMedia* _Nullable media;

/**
 The format of the input media file.

 @see AWSTranscribeMediaFormat
 */
@property (nonatomic, assign) AWSTranscribeMediaFormat mediaFormat;

/**
 The sample rate, in Hertz, of the audio track in the input media file.

 @requires Valid Range: Minimum value of 8000. Maximum value of 48000.
 */
@property (nonatomic, strong) NSNumber* _Nullable mediaSampleRateHertz;

/**
 An object that describes the output of the transcription job.

 @see AWSTranscribeTranscript
 */
@property (nonatomic, strong) AWSTranscribeTranscript* _Nullable transcript;

@end

/**
 Describes the input media file in a transcription request.
 */
@interface AWSTranscribeMedia : AWSModel

/**
 The S3 location of the input media file. The URI must be in the same region as
 the API endpoint that you are calling. The general form is:

 https://<aws-region>.amazonaws.com/<bucket-name>/<keyprefix>/<objectkey>

 @example Some example URIs
 * https://s3-us-east-1.amazonaws.com/examplebucket/example.mp4
 * https://s3-us-east-1.amazonaws.com/examplebucket/mediadocs/example.mp4

 @requires Length Constraints: Minimum length of 1. Maximum length of 2000.
 */
@property (nonatomic, strong) NSString* _Nullable fileUri;

@end

/**
 Describes the output of a transcription job.
 */
@interface AWSTranscribeTranscript : AWSModel

/**
 The S3 location where the transcription result is stored. Use this URI to access
 the results of the transcription job.

 @requires Length Constraints: Minimum length of 1. Maximum length of 2000.
 */
@property (nonatomic, strong) NSString* _Nullable fileUri;

@end

NS_ASSUME_NONNULL_END
