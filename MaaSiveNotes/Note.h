
#import <MaaSive/MaaSive.h>
#import <Foundation/Foundation.h>

@interface Note : MaaSModel {
    NSString *_content;
    NSString *_deviceID;
}

@property(nonatomic, retain) NSString *content;
@property(nonatomic, retain) NSString *deviceID;

@end
