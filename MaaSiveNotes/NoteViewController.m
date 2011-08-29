
#import "NoteViewController.h"
#import "Note.h"
#import "RootViewController.h"

@implementation NoteViewController

@synthesize note = _note;
@synthesize rootController = _rootController;
@synthesize noteContentText;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
																					target:self
																					action:@selector(done:)];
        self.navigationItem.rightBarButtonItem = doneButton;
        [doneButton release];
    }
	
    return self;
}

- (void)dealloc
{
    [_note release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) done:(id)sender {
	
    self.note.content = self.noteContentText.text;
    self.note.deviceID = [[UIDevice currentDevice] uniqueIdentifier];
    NSError *saveError = nil;
    BOOL success = [self.note saveRemote:&saveError];
    
    if(success) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    else {
        
        UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Save Error" 
                                                             message:@"There was a problem with MaaSive" 
                                                            delegate:self 
                                                   cancelButtonTitle:@"Ok"
                                                   otherButtonTitles:nil];
        [errorAlert show];
        [errorAlert release];
    }
}

#pragma mark - View lifecycle

- (void) viewWillAppear:(BOOL)animated {
	
    self.noteContentText.text = self.note.content;
    [self.noteContentText becomeFirstResponder];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
