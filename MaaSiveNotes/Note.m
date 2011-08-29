
#import "Note.h"

@implementation Note

@synthesize content = _content;
@synthesize deviceID = _deviceID;

- (void) dealloc {
	
    [_content release];
    [_deviceID release];
    [super dealloc];
}

@end
