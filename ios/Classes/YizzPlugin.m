#import "YizzPlugin.h"
#if __has_include(<yizz_plugin/yizz_plugin-Swift.h>)
#import <yizz_plugin/yizz_plugin-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "yizz_plugin-Swift.h"
#endif

@implementation YizzPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftYizzPlugin registerWithRegistrar:registrar];
}
@end
