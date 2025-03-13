//
//  Generated file. Do not edit.
//

// clang-format off

#import "GeneratedPluginRegistrant.h"

#if __has_include(<ffmpeg_kit_flutter_full_gpl/FFmpegKitFlutterPlugin.h>)
#import <ffmpeg_kit_flutter_full_gpl/FFmpegKitFlutterPlugin.h>
#else
@import ffmpeg_kit_flutter_full_gpl;
#endif

#if __has_include(<flutter_sound/FlutterSound.h>)
#import <flutter_sound/FlutterSound.h>
#else
@import flutter_sound;
#endif

#if __has_include(<path_provider_foundation/PathProviderPlugin.h>)
#import <path_provider_foundation/PathProviderPlugin.h>
#else
@import path_provider_foundation;
#endif

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [FFmpegKitFlutterPlugin registerWithRegistrar:[registry registrarForPlugin:@"FFmpegKitFlutterPlugin"]];
  [FlutterSound registerWithRegistrar:[registry registrarForPlugin:@"FlutterSound"]];
  [PathProviderPlugin registerWithRegistrar:[registry registrarForPlugin:@"PathProviderPlugin"]];
}

@end
