//
// Copyright 2010-2017 Amazon.com, Inc. or its affiliates. All Rights Reserved.
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

#import "AWSTranscribeService.h"
#import <AWSCore/AWSNetworking.h>
#import <AWSCore/AWSCategory.h>
#import <AWSCore/AWSNetworking.h>
#import <AWSCore/AWSSignature.h>
#import <AWSCore/AWSService.h>
#import <AWSCore/AWSURLRequestSerialization.h>
#import <AWSCore/AWSURLResponseSerialization.h>
#import <AWSCore/AWSURLRequestRetryHandler.h>
#import <AWSCore/AWSSynchronizedMutableDictionary.h>
#import "AWSTranscribeRequestRetryHandler.h"
#import "AWSTranscribeSerializer.h"
#import "AWSTranscribeResources.h"

static NSString *const AWSInfoTranscribe = @"Transcribe";
static NSString *const AWSTranscribeSDKVersion = @"2.6.12";

@interface AWSRequest()

@property (nonatomic, strong) AWSNetworkingRequest *internalRequest;

@end

@interface AWSTranscribe()

@property (nonatomic, strong) AWSNetworking *networking;
@property (nonatomic, strong) AWSServiceConfiguration *configuration;

@end

@interface AWSServiceConfiguration()

@property (nonatomic, strong) AWSEndpoint *endpoint;

@end

@interface AWSEndpoint()

- (void) setRegion:(AWSRegionType)regionType service:(AWSServiceType)serviceType;

@end

@implementation AWSTranscribe

+ (void)initialize {
	[super initialize];

	if (![AWSiOSSDKVersion isEqualToString:AWSTranscribeSDKVersion]) {
		@throw [NSException exceptionWithName:NSInternalInconsistencyException
									   reason:[NSString stringWithFormat:@"AWSCore and AWSTranscribe versions need to match. Check your SDK installation. AWSCore: %@ AWSTranscribe: %@", AWSiOSSDKVersion, AWSTranscribeSDKVersion]
									 userInfo:nil];
	}
}

#pragma mark - Setup

static AWSSynchronizedMutableDictionary *_serviceClients = nil;

+ (instancetype)defaultTranscribe {
	static AWSTranscribe *_defaultTranscribe = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		AWSServiceConfiguration *serviceConfiguration = nil;
		AWSServiceInfo *serviceInfo = [[AWSInfo defaultAWSInfo] defaultServiceInfo:AWSInfoTranscribe];
		if (serviceInfo) {
			serviceConfiguration = [[AWSServiceConfiguration alloc] initWithRegion:serviceInfo.region
															   credentialsProvider:serviceInfo.cognitoCredentialsProvider];
		}

		if (!serviceConfiguration) {
			serviceConfiguration = [AWSServiceManager defaultServiceManager].defaultServiceConfiguration;
		}

		if (!serviceConfiguration) {
			@throw [NSException exceptionWithName:NSInternalInconsistencyException
										   reason:@"The service configuration is `nil`. You need to configure `awsconfiguration.json`, `Info.plist` or set `defaultServiceConfiguration` before using this method."
										 userInfo:nil];
		}
		_defaultTranscribe = [[AWSTranscribe alloc] initWithConfiguration:serviceConfiguration];
	});

	return _defaultTranscribe;
}

+ (void)registerTranscribeWithConfiguration:(AWSServiceConfiguration *)configuration forKey:(NSString *)key {
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		_serviceClients = [AWSSynchronizedMutableDictionary new];
	});
	[_serviceClients setObject:[[AWSTranscribe alloc] initWithConfiguration:configuration]
						forKey:key];
}

+ (instancetype)S3ForKey:(NSString *)key {
	@synchronized(self) {
		AWSTranscribe *serviceClient = [_serviceClients objectForKey:key];
		if (serviceClient) {
			return serviceClient;
		}

		AWSServiceInfo *serviceInfo = [[AWSInfo defaultAWSInfo] serviceInfo:AWSInfoTranscribe
																	 forKey:key];
		if (serviceInfo) {
			AWSServiceConfiguration *serviceConfiguration = [[AWSServiceConfiguration alloc] initWithRegion:serviceInfo.region
																						credentialsProvider:serviceInfo.cognitoCredentialsProvider];
			[AWSTranscribe registerTranscribeWithConfiguration:serviceConfiguration
										forKey:key];
		}

		return [_serviceClients objectForKey:key];
	}
}

+ (void)removeTranscribeForKey:(NSString *)key {
	[_serviceClients removeObjectForKey:key];
}

- (instancetype)init {
	@throw [NSException exceptionWithName:NSInternalInconsistencyException
								   reason:@"`- init` is not a valid initializer. Use `+ defaultTranscribe` or `+ transcribeForKey:` instead."
								 userInfo:nil];
	return nil;
}

#pragma mark -

- (instancetype)initWithConfiguration:(AWSServiceConfiguration *)configuration {
	if (self = [super init]) {
		_configuration = [configuration copy];

		if(!configuration.endpoint){
			_configuration.endpoint = [[AWSEndpoint alloc] initWithRegion:_configuration.regionType
																  service:AWSServiceS3
															 useUnsafeURL:NO];
		}else{
			[_configuration.endpoint setRegion:_configuration.regionType
									   service:AWSServiceS3];
		}


		AWSSignatureV4Signer *signer = [[AWSSignatureV4Signer alloc] initWithCredentialsProvider:_configuration.credentialsProvider
																						endpoint:_configuration.endpoint];
		AWSNetworkingRequestInterceptor *baseInterceptor = [[AWSNetworkingRequestInterceptor alloc] initWithUserAgent:_configuration.userAgent];
		_configuration.requestInterceptors = @[baseInterceptor, signer];

		_configuration.baseURL = _configuration.endpoint.URL;
		_configuration.retryHandler = [[AWSTranscribeRequestRetryHandler alloc] initWithMaximumRetryCount:_configuration.maxRetryCount];


		_networking = [[AWSNetworking alloc] initWithConfiguration:_configuration];
	}

	return self;
}

- (AWSTask *)invokeRequest:(AWSRequest *)request
				HTTPMethod:(AWSHTTPMethod)HTTPMethod
				 URLString:(NSString *) URLString
			  targetPrefix:(NSString *)targetPrefix
			 operationName:(NSString *)operationName
			   outputClass:(Class)outputClass {

	@autoreleasepool {
		if (!request) {
			request = [AWSRequest new];
		}

		AWSNetworkingRequest *networkingRequest = request.internalRequest;
		if (request) {
			networkingRequest.parameters = [[AWSMTLJSONAdapter JSONDictionaryFromModel:request] aws_removeNullValues];
		} else {
			networkingRequest.parameters = @{};
		}
		networkingRequest.shouldWriteDirectly = [[request valueForKey:@"shouldWriteDirectly"] boolValue];
		networkingRequest.downloadingFileURL = request.downloadingFileURL;

		networkingRequest.HTTPMethod = HTTPMethod;
		networkingRequest.requestSerializer = [[AWSTranscribeRequestSerializer alloc] initWithJSONDefinition:[[AWSTranscribeResources sharedInstance] JSONObject]
																						  actionName:operationName];
		networkingRequest.responseSerializer = [[AWSTranscribeResponseSerializer alloc] initWithJSONDefinition:[[AWSTranscribeResources sharedInstance] JSONObject]
																							actionName:operationName
																						   outputClass:outputClass];

		return [self.networking sendRequest:networkingRequest];
	}
}

#pragma mark - Service method

- (AWSTask<AWSTranscribeStartTranscriptionJobOutput *> *)startTranscriptionJob:(AWSTranscribeStartTranscriptionJobRequest *)request {
	return [self invokeRequest:request
					HTTPMethod:AWSHTTPMethodPOST
					 URLString:@"/"
				  targetPrefix:@""
				 operationName:@"StartTranscriptionJob"
				   outputClass:[AWSTranscribeStartTranscriptionJobOutput class]];
}

- (AWSTask<AWSTranscribeListTranscriptionJobsOutput *> *)listTranscriptionJobs:(AWSTranscribeListTranscriptionJobsRequest *)request {
	return [self invokeRequest:request
					HTTPMethod:AWSHTTPMethodPOST
					 URLString:@"/"
				  targetPrefix:@""
				 operationName:@"ListTranscriptionJobs"
				   outputClass:[AWSTranscribeListTranscriptionJobsOutput class]];

}

- (void)listTranscriptionJobsWithRequest:(AWSTranscribeListTranscriptionJobsRequest *)request completionHandler:(void (^)(AWSTranscribeListTranscriptionJobsOutput * _Nullable, NSError * _Nullable))completionHandler {
	[[self listTranscriptionJobs:request] continueWithBlock:^id _Nullable(AWSTask<AWSTranscribeListTranscriptionJobsOutput *> * _Nonnull task) {
		AWSTranscribeListTranscriptionJobsOutput *result = task.result;
		NSError *error = task.error;

		if (completionHandler) {
			completionHandler(result, error);
		}

		return nil;
	}];
}

- (void)listTranscriptionJobs:(AWSTranscribeJobStatus)jobStatus
			completionHandler:(void (^)(AWSTranscribeListTranscriptionJobsOutput * _Nullable, NSError * _Nullable))completionHandler {
	AWSTranscribeListTranscriptionJobsRequest* request = [AWSTranscribeListTranscriptionJobsRequest new];
	request.status = AWSTranscribeJobStatusCompleted;
	[self listTranscriptionJobsWithRequest:request completionHandler:completionHandler];
}
@end
