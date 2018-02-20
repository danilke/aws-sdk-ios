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
#import <AWSCore/AWSCore.h>
#import "AWSTranscribeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AWSTranscribe : AWSService

/**
 The service configuration used to instantiate this service client.

 @warning Once the client is instantiated, do not modify the configuration object. It may cause unspecified behaviors.
 */
@property (nonatomic, strong, readonly) AWSServiceConfiguration *configuration;

/**
 Returns the singleton service client. If the singleton object does not exist, the SDK instantiates the default service client with `defaultServiceConfiguration` from `[AWSServiceManager defaultServiceManager]`. The reference to this object is maintained by the SDK, and you do not need to retain it manually.

 For example, set the default service configuration in `- application:didFinishLaunchingWithOptions:`

 *Swift*

 func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
 let credentialProvider = AWSCognitoCredentialsProvider(regionType: .USEast1, identityPoolId: "YourIdentityPoolId")
 let configuration = AWSServiceConfiguration(region: .USEast1, credentialsProvider: credentialProvider)
 AWSServiceManager.default().defaultServiceConfiguration = configuration

 return true
 }

 *Objective-C*

 - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
 AWSCognitoCredentialsProvider *credentialsProvider = [[AWSCognitoCredentialsProvider alloc] initWithRegionType:AWSRegionUSEast1
 identityPoolId:@"YourIdentityPoolId"];
 AWSServiceConfiguration *configuration = [[AWSServiceConfiguration alloc] initWithRegion:AWSRegionUSEast1
 credentialsProvider:credentialsProvider];
 [AWSServiceManager defaultServiceManager].defaultServiceConfiguration = configuration;

 return YES;
 }

 Then call the following to get the default service client:

 *Swift*

 let S3 = AWSS3.default()

 *Objective-C*

 AWSS3 *S3 = [AWSS3 defaultS3];

 @return The default service client.
 */
+ (instancetype)defaultTranscribe;

/**
 Creates a service client with the given service configuration and registers it for the key.

 For example, set the default service configuration in `- application:didFinishLaunchingWithOptions:`

 *Swift*

 func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
 let credentialProvider = AWSCognitoCredentialsProvider(regionType: .USEast1, identityPoolId: "YourIdentityPoolId")
 let configuration = AWSServiceConfiguration(region: .USWest2, credentialsProvider: credentialProvider)
 AWSS3.register(with: configuration!, forKey: "USWest2S3")

 return true
 }

 *Objective-C*

 - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
 AWSCognitoCredentialsProvider *credentialsProvider = [[AWSCognitoCredentialsProvider alloc] initWithRegionType:AWSRegionUSEast1
 identityPoolId:@"YourIdentityPoolId"];
 AWSServiceConfiguration *configuration = [[AWSServiceConfiguration alloc] initWithRegion:AWSRegionUSWest2
 credentialsProvider:credentialsProvider];

 [AWSS3 registerS3WithConfiguration:configuration forKey:@"USWest2S3"];

 return YES;
 }

 Then call the following to get the service client:

 *Swift*

 let S3 = AWSS3(forKey: "USWest2S3")

 *Objective-C*

 AWSS3 *S3 = [AWSS3 S3ForKey:@"USWest2S3"];

 @warning After calling this method, do not modify the configuration object. It may cause unspecified behaviors.

 @param configuration A service configuration object.
 @param key           A string to identify the service client.
 */
+ (void)registerTranscribeWithConfiguration:(AWSServiceConfiguration *)configuration forKey:(NSString *)key;

/**
 Retrieves the service client associated with the key. You need to call `+ registerS3WithConfiguration:forKey:` before invoking this method.

 For example, set the default service configuration in `- application:didFinishLaunchingWithOptions:`

 *Swift*

 func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
 let credentialProvider = AWSCognitoCredentialsProvider(regionType: .USEast1, identityPoolId: "YourIdentityPoolId")
 let configuration = AWSServiceConfiguration(region: .USWest2, credentialsProvider: credentialProvider)
 AWSS3.register(with: configuration!, forKey: "USWest2S3")

 return true
 }

 *Objective-C*

 - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
 AWSCognitoCredentialsProvider *credentialsProvider = [[AWSCognitoCredentialsProvider alloc] initWithRegionType:AWSRegionUSEast1
 identityPoolId:@"YourIdentityPoolId"];
 AWSServiceConfiguration *configuration = [[AWSServiceConfiguration alloc] initWithRegion:AWSRegionUSWest2
 credentialsProvider:credentialsProvider];

 [AWSS3 registerS3WithConfiguration:configuration forKey:@"USWest2S3"];

 return YES;
 }

 Then call the following to get the service client:

 *Swift*

 let S3 = AWSS3(forKey: "USWest2S3")

 *Objective-C*

 AWSS3 *S3 = [AWSS3 S3ForKey:@"USWest2S3"];

 @param key A string to identify the service client.

 @return An instance of the service client.
 */
+ (instancetype)transcribeForKey:(NSString *)key;

/**
 Removes the service client associated with the key and release it.

 @warning Before calling this method, make sure no method is running on this client.

 @param key A string to identify the service client.
 */
+ (void)removeTranscribeForKey:(NSString *)key;

/**
 Starts a new transcribe job.

 @param request A container for the necessary parameters to execute the
 StartTranscriptionJob service method.

 @return An instance of `AWSTask`. On successful execution, `task.result` will
 contain an instance of `AWSTranscribeStartTranscriptionJobOutput`. On failed
 execution, `task.error` may contain an `NSError` with `AWSTranscribeErrorDomain`
 domain and the `AWSTranscribeError` error codes.

 @see AWSTranscribeStartTranscriptionJobRequest
 @see AWSTranscribeStartTranscriptionJobOutput
 @see AWSTranscribeError
 */
- (AWSTask<AWSTranscribeStartTranscriptionJobOutput *> *)startTranscriptionJob:(AWSTranscribeStartTranscriptionJobRequest *)request;

/**
 Starts a new transcribe job.

 @param request A container for the necessary parameters to execute the
 		StartTranscriptionJob service method.
 @param completionHandler The completion handler to call when the load request is complete.
		`response` - A response object, or `nil` if the request failed.
		`error` - An error object that indicates why the request failed, or `nil` if the request was successful.

 @see AWSTranscribeStartTranscriptionJobRequest
 @see AWSTranscribeStartTranscriptionJobOutput
 */
- (void)startTranscriptionJobWithRequest:(AWSTranscribeStartTranscriptionJobRequest *)request
			completionHandler:(void (^ _Nullable)(AWSTranscribeStartTranscriptionJobOutput * _Nullable response, NSError * _Nullable error))completionHandler;

/**
 Starts a new transcribe job.

 @param jobName The name of the transcribe job
 @param completionHandler The completion handler to call when the load request is complete.
 `response` - A response object, or `nil` if the request failed.
 `error` - An error object that indicates why the request failed, or `nil` if the request was successful.

 @see AWSTranscribeStartTranscriptionJobRequest
 @see AWSTranscribeStartTranscriptionJobOutput
 */
- (void)startTranscriptionJob:(NSString *)jobName
				 languageCode:(AWSTranscribeLanguageCode)languageCode
					 mediaUri:(NSString*)mediaUri
			  mediaSampleRate:(NSNumber* _Nullable)mediaSampleRate
			completionHandler:(void (^ _Nullable)(AWSTranscribeStartTranscriptionJobOutput * _Nullable response, NSError * _Nullable error))completionHandler;

/**
 Gets an existing transaction job.

 @param request A container for the necessary parameters to execute the
 		GetTranscriptionJob service method.

 @return An instance of `AWSTask`. On successful execution, `task.result` will
 contain an instance of `AWSTranscribeGetTranscriptionJobOutput`. On failed
 execution, `task.error` may contain an `NSError` with `AWSTranscribeErrorDomain`
 domain and the `AWSTranscribeError` error codes.

 @see AWSTranscribeGetTranscriptionJobRequest
 @see AWSTranscribeGetTranscriptionJobOutput
 @see AWSTranscribeError
 */
- (AWSTask<AWSTranscribeGetTranscriptionJobOutput *> *)getTranscriptionJob:(AWSTranscribeGetTranscriptionJobRequest *)request;

/**
 Gets an existing transaction job.

 @param request A container for the necessary parameters to execute the
 		GetTranscriptionJob service method.
 @param completionHandler The completion handler to call when the load request is complete.
		`response` - A response object, or `nil` if the request failed.
		`error` - An error object that indicates why the request failed, or `nil` if the request was successful.

 @see AWSTranscribeGetTranscriptionJobRequest
 @see AWSTranscribeGetTranscriptionJobOutput
 @see AWSTranscribeError
 */
- (void)getTranscriptionJobWithRequest:(AWSTranscribeGetTranscriptionJobRequest *)request
			completionHandler:(void (^ _Nullable)(AWSTranscribeGetTranscriptionJobOutput * _Nullable response, NSError * _Nullable error))completionHandler;

/**
 Gets an existing transaction job.

 @param jobName The name of the job to get.
 @param completionHandler The completion handler to call when the load request is complete.
 `response` - A response object, or `nil` if the request failed.
 `error` - An error object that indicates why the request failed, or `nil` if the request was successful.

 @see AWSTranscribeGetTranscriptionJobOutput
 @see AWSTranscribeError
 */
- (void)getTranscriptionJob:(NSString *)jobName
		  completionHandler:(void (^ _Nullable)(AWSTranscribeGetTranscriptionJobOutput * _Nullable response, NSError * _Nullable error))completionHandler;

/**
 Returns a list of all transcription jobs matching `jobStatus`.

 @param request A container for the necessary parameters to execute the
		ListTranscriptionJobs service method.

 @return An instance of `AWSTask`. On successful execution, `task.result` will
		contain an instance of `AWSTranscribeListTranscriptionJobsOutput`. On failed
		execution, `task.error` may contain an `NSError` with `AWSTranscribeErrorDomain`
		domain and the `AWSTranscribeError` error codes.

 @see AWSTranscribeListTranscriptionJobsRequest
 @see AWSTranscribeListTranscriptionJobsOutput
 @see AWSTranscribeError
 */
- (AWSTask<AWSTranscribeListTranscriptionJobsOutput *> *)listTranscriptionJobs:(AWSTranscribeListTranscriptionJobsRequest *)request;

/**
 Returns a list of all transcription jobs matching `jobStatus`.

 @param request A container for the necessary parameters to execute the
 		GetTranscriptionJob service method.
 @param completionHandler The completion handler to call when the load request is complete.
		`response` - A response object, or `nil` if the request failed.
		`error` - An error object that indicates why the request failed, or `nil` if the request was successful.

 @see AWSTranscribeListTranscriptionJobsRequest
 @see AWSTranscribeListTranscriptionJobsOutput
 @see AWSTranscribeError
 */
- (void)listTranscriptionJobsWithRequest:(AWSTranscribeListTranscriptionJobsRequest *)request
					   completionHandler:(void (^ _Nullable)(AWSTranscribeListTranscriptionJobsOutput * _Nullable response, NSError * _Nullable error))completionHandler;

/**
 Returns a list of all transcription jobs matching `jobStatus`.

 @param jobStatus The status of the jobs to list.
 @param completionHandler The completion handler to call when the load request is complete.
 `response` - A response object, or `nil` if the request failed.
 `error` - An error object that indicates why the request failed, or `nil` if the request was successful.

 @see AWSTranscribeListTranscriptionJobsOutput
 @see AWSTranscribeJobStatus
 @see AWSTranscribeError
 */
- (void)listTranscriptionJobs:(AWSTranscribeJobStatus)jobStatus
			completionHandler:(void (^ _Nullable)(AWSTranscribeListTranscriptionJobsOutput * _Nullable response, NSError * _Nullable error))completionHandler;

@end

NS_ASSUME_NONNULL_END
