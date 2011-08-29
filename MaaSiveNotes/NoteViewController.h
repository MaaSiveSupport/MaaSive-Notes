
#import <UIKit/UIKit.h>

@class Note;
@class RootViewController;

@interface NoteViewController : UIViewController {
    Note *_note;
	RootViewController *_rootController;
}

@property(nonatomic, retain) Note *note;
@property(nonatomic, retain) IBOutlet UITextView *noteContentText;
@property(nonatomic, retain) RootViewController *rootController;

@end
