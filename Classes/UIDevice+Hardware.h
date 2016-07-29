/*
 Erica Sadun, http://ericasadun.com
 iPhone Developer's Cookbook, 6.x Edition
 BSD License, Use at your own risk
 */

#import <UIKit/UIKit.h>

#define IFPGA_NAMESTRING                @"iFPGA"

#define IPHONE_1G_NAMESTRING            @"iPhone1G"
#define IPHONE_3G_NAMESTRING            @"iPhone3G"
#define IPHONE_3GS_NAMESTRING           @"iPhone3GS"
#define IPHONE_4_NAMESTRING             @"iPhone4"
#define IPHONE_4S_NAMESTRING            @"iPhone4S"
#define IPHONE_5_NAMESTRING             @"iPhone5"

#define IPHONE_5S_NAMESTRING            @"iPhone5S"
#define IPHONE_6_NAMESTRING             @"iPhone6"
#define IPHONE_6Plus_NAMESTRING         @"iPhone6Plus"

#define IPHONE_6S_NAMESTRING             @"iPhone6S"
#define IPHONE_6SPlus_NAMESTRING         @"iPhone6SPlus"

#define IPHONE_UNKNOWN_NAMESTRING       @"UnknowniPhone"

#define IPOD_1G_NAMESTRING              @"iPod touch1G"
#define IPOD_2G_NAMESTRING              @"iPod touch2G"
#define IPOD_3G_NAMESTRING              @"iPod touch3G"
#define IPOD_4G_NAMESTRING              @"iPod touch4G"
#define IPOD_UNKNOWN_NAMESTRING         @"UnknowniPod"

#define IPAD_1G_NAMESTRING              @"iPad1G"
#define IPAD_2G_NAMESTRING              @"iPad2G"
#define IPAD_3G_NAMESTRING              @"iPad3G"
#define IPAD_4G_NAMESTRING              @"iPad4G"
#define IPAD_UNKNOWN_NAMESTRING         @"UnknowniPad"

#define APPLETV_2G_NAMESTRING           @"AppleTV2G"
#define APPLETV_3G_NAMESTRING           @"AppleTV3G"
#define APPLETV_4G_NAMESTRING           @"AppleTV4G"
#define APPLETV_UNKNOWN_NAMESTRING      @"UnknownAppleTV"

#define IOS_FAMILY_UNKNOWN_DEVICE       @"UnknowniOSdevice"

#define SIMULATOR_NAMESTRING            @"iPhoneSimulator"
#define SIMULATOR_IPHONE_NAMESTRING     @"iPhoneSimulator"
#define SIMULATOR_IPAD_NAMESTRING       @"iPadSimulator"
#define SIMULATOR_APPLETV_NAMESTRING    @"AppleTVSimulator" // :)

typedef enum {
    UIDeviceUnknown,
    
    UIDeviceSimulator,
    UIDeviceSimulatoriPhone,
    UIDeviceSimulatoriPad,
    UIDeviceSimulatorAppleTV,
    
    UIDevice1GiPhone,
    UIDevice3GiPhone,
    UIDevice3GSiPhone,
    UIDevice4iPhone,
    UIDevice4SiPhone,
    UIDevice5iPhone,
    UIDevice5SiPhone,
    UIDevice6iPhone,
    UIDevice6PiPhone,
    UIDevice6SiPhone,
    UIDevice6SPiPhone,
    
    UIDevice1GiPod,
    UIDevice2GiPod,
    UIDevice3GiPod,
    UIDevice4GiPod,
    
    UIDevice1GiPad,
    UIDevice2GiPad,
    UIDevice3GiPad,
    UIDevice4GiPad,
    
    UIDeviceAppleTV2,
    UIDeviceAppleTV3,
    UIDeviceAppleTV4,
    
    UIDeviceUnknowniPhone,
    UIDeviceUnknowniPod,
    UIDeviceUnknowniPad,
    UIDeviceUnknownAppleTV,
    UIDeviceIFPGA,

} UIDevicePlatform;

typedef enum {
    UIDeviceFamilyiPhone,
    UIDeviceFamilyiPod,
    UIDeviceFamilyiPad,
    UIDeviceFamilyAppleTV,
    UIDeviceFamilyUnknown,
    
} UIDeviceFamily;

@interface UIDevice (Hardware)
- (NSString *) platform;
- (NSString *) hwmodel;
- (NSUInteger) platformType;
- (NSString *) platformString;

- (NSUInteger) cpuFrequency;
- (NSUInteger) busFrequency;
- (NSUInteger) cpuCount;
- (NSUInteger) totalMemory;
- (NSUInteger) userMemory;

- (NSNumber *) totalDiskSpace;
- (NSNumber *) freeDiskSpace;

- (NSString *) macaddress;

- (BOOL) hasRetinaDisplay;
- (UIDeviceFamily) deviceFamily;
@end