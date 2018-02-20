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

#import <AWSCore/AWSCore.h>
#import "AWSTranscribeSerializer.h"
#import "AWSTranscribeService.h"

@interface AWSTranscribeRequestSerializer()

@property (nonatomic, strong) NSDictionary *serviceDefinitionJSON;
@property (nonatomic, strong) NSString *actionName;
@property (nonatomic, strong) id<AWSURLRequestSerializer> requestSerializer;

@end

@implementation AWSTranscribeRequestSerializer

- (instancetype)initWithJSONDefinition:(NSDictionary *)JSONDefinition
							actionName:(NSString *)actionName{
	if (self = [super init]) {

		_serviceDefinitionJSON = JSONDefinition;
		if (_serviceDefinitionJSON == nil) {
			AWSDDLogError(@"serviceDefinitionJSON is nil.");
			return nil;
		}
		_actionName = actionName;
		_requestSerializer = [[AWSJSONRequestSerializer alloc]initWithJSONDefinition:JSONDefinition actionName:actionName];
	}

	return self;
}

- (AWSTask *)validateRequest:(NSURLRequest *)request{
	return [_requestSerializer validateRequest:request];
}

- (AWSTask *)serializeRequest:(NSMutableURLRequest *)request headers:(NSDictionary *)headers parameters:(NSDictionary *)parameters{
	return [_requestSerializer serializeRequest:request headers:headers parameters:parameters];
}

@end


@interface AWSTranscribeResponseSerializer()

@property (nonatomic, strong) NSDictionary *serviceDefinitionJSON;
@property (nonatomic, strong) NSString *actionName;
@property (nonatomic, strong) id<AWSHTTPURLResponseSerializer> responseSerializer;

@end

@implementation AWSTranscribeResponseSerializer

- (instancetype)initWithJSONDefinition:(NSDictionary *)JSONDefinition
							actionName:(NSString *)actionName
						   outputClass:(Class)outputClass{
	if (self = [super init]) {

		_serviceDefinitionJSON = JSONDefinition;
		if (_serviceDefinitionJSON == nil) {
			AWSDDLogError(@"serviceDefinitionJSON is nil.");
			return nil;
		}
		_actionName = actionName;
		_outputClass = outputClass;
		_responseSerializer = [[AWSJSONResponseSerializer alloc]initWithJSONDefinition:JSONDefinition actionName:actionName outputClass:outputClass];
	}

	return self;
}

static NSDictionary *errorCodeDictionary = nil;
+ (void)initialize {
	errorCodeDictionary = @{
							@"BadRequestException" : @(AWSTranscribeErrorBadRequestException),
							@"InternalFailureException" : @(AWSTranscribeErrorInternalFailureException),
							@"LimitExceededException" : @(AWSTranscribeErrorLimitExceededException),
							@"NotFoundException" : @(AWSTranscribeErrorNotFoundException),
							};
}

- (id)responseObjectForResponse:(NSHTTPURLResponse *)response
				originalRequest:(NSURLRequest *)originalRequest
				 currentRequest:(NSURLRequest *)currentRequest
						   data:(id)data
						  error:(NSError *__autoreleasing *)error {

	id responseObject =  [_responseSerializer responseObjectForResponse:response
														originalRequest:originalRequest
														 currentRequest:currentRequest
																   data:data
																  error:error];


	if (!*error && [responseObject isKindOfClass:[NSDictionary class]]) {
		NSDictionary *errorInfo = responseObject[@"Error"];
		if (errorInfo[@"Code"] && errorCodeDictionary[errorInfo[@"Code"]]) {
			if (error) {
				*error = [NSError errorWithDomain:AWSTranscribeErrorDomain
											 code:[errorCodeDictionary[errorInfo[@"Code"]] integerValue]
										 userInfo:errorInfo];
				return responseObject;
			}
		} else if (errorInfo) {
			if (error) {
				*error = [NSError errorWithDomain:AWSTranscribeErrorDomain
											 code:AWSTranscribeErrorUnknown
										 userInfo:errorInfo];
				return responseObject;
			}
		}
	}

	if (!*error
		&& response.statusCode/100 != 2
		&& response.statusCode/100 != 3) {
		*error = [NSError errorWithDomain:AWSTranscribeErrorDomain
									 code:AWSTranscribeErrorUnknown
								 userInfo:nil];
	}

	if (!*error && [responseObject isKindOfClass:[NSDictionary class]]) {
		if (self.outputClass) {
			responseObject = [AWSMTLJSONAdapter modelOfClass:self.outputClass
										  fromJSONDictionary:responseObject
													   error:error];
		}
	}

	return responseObject;

}

- (BOOL)validateResponse:(NSHTTPURLResponse *)response
			 fromRequest:(NSURLRequest *)request
					data:(id)data
				   error:(NSError *__autoreleasing *)error{

	return [_responseSerializer validateResponse:response
									 fromRequest:request
											data:data
										   error:error];
}

@end

