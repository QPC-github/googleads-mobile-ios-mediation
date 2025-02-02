// Copyright 2019 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#import "GADMediationAdapterMyTarget.h"

#import <MyTargetSDK/MyTargetSDK.h>

#import "MyTargetSDK/MyTargetSDK-Swift.h"
#import "GADMAdapterMyTargetConstants.h"
#import "GADMAdapterMyTargetExtras.h"
#import "GADMAdapterMyTargetRewardedAd.h"

@interface GADMediationAdapterMyTarget ()

@end

@implementation GADMediationAdapterMyTarget {
  /// myTarget rewarded ad wrapper.
  GADMAdapterMyTargetRewardedAd *_rewardedAd;
}

+ (void)setUpWithConfiguration:(nonnull GADMediationServerConfiguration *)configuration
             completionHandler:(nonnull GADMediationAdapterSetUpCompletionBlock)completionHandler {
  // INFO: MyTarget SDK doesn't have any initialization API.
  completionHandler(nil);
}

+ (GADVersionNumber)adSDKVersion {
  NSString *versionString = [MTRGVersion currentVersion];
  GADVersionNumber version = {0};
  NSArray<NSString *> *components = [versionString componentsSeparatedByString:@"."];
  if (components.count >= 3) {
    version.majorVersion = components[0].integerValue;
    version.minorVersion = components[1].integerValue;
    version.patchVersion = components[2].integerValue;
  } else {
    NSLog(@"Unexpected MyTarget version string: %@. Returning 0 for adSDKVersion.", versionString);
  }
  return version;
}

+ (nullable Class<GADAdNetworkExtras>)networkExtrasClass {
  return [GADMAdapterMyTargetExtras class];
}

+ (GADVersionNumber)adapterVersion {
  NSString *versionString = GADMAdapterMyTargetVersion;
  NSArray<NSString *> *components = [versionString componentsSeparatedByString:@"."];
  GADVersionNumber version = {0};
  if (components.count >= 4) {
    version.majorVersion = components[0].integerValue;
    version.minorVersion = components[1].integerValue;
    version.patchVersion = components[2].integerValue * 100 + components[3].integerValue;
  }
  return version;
}

- (void)loadRewardedAdForAdConfiguration:
            (nonnull GADMediationRewardedAdConfiguration *)adConfiguration
                       completionHandler:
                           (nonnull GADMediationRewardedLoadCompletionHandler)completionHandler {
  _rewardedAd = [[GADMAdapterMyTargetRewardedAd alloc] initWithAdConfiguration:adConfiguration
                                                             completionHandler:completionHandler];
  [_rewardedAd loadRewardedAd];
}

@end
