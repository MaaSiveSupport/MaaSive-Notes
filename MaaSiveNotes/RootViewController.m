
#import "RootViewController.h"
#import "NoteViewController.h"
#import "Note.h"

@implementation RootViewController

@synthesize notes = _notes;

- (void)viewDidLoad {

    [super viewDidLoad];

	UIBarButtonItem *addButton  = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
																				target:self
																				action:@selector(addNote:)];
    self.navigationItem.rightBarButtonItem = addButton;
    [addButton release];
    
    self.title = @"My Notes";
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];    
    
    NSDictionary *query = [NSDictionary dictionaryWithObject:[[UIDevice currentDevice] uniqueIdentifier]
                                                      forKey:@"deviceID.eql"];
    
    [Note findRemoteAsyncWithQuery:query
                      cacheResults:YES 
                            target:self
                          selector:@selector(maaSiveDidFindNotes:error:)];
}

-(void)maaSiveDidFindNotes:(NSArray*)notes error:(NSError*)error {

    if(!error) {
        
        self.notes = [notes mutableCopy];
        [self.tableView performSelectorOnMainThread:@selector(reloadData) 
                                         withObject:nil 
                                      waitUntilDone:NO];
    }
    
    else {
    
        UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Fetch Error" 
                                                             message:@"There was a problem with MaaSive" 
                                                            delegate:self 
                                                   cancelButtonTitle:@"Ok"
                                                   otherButtonTitles:nil];
        [errorAlert show];
        [errorAlert release];
    }
}

- (void) addNote:(id) sender {
   
	NoteViewController *controller = [[NoteViewController alloc] initWithNibName:@"NoteViewController" bundle:[NSBundle mainBundle]];
	[controller setRootController:self];
    Note *note = [[Note alloc] init];
    controller.note = note;
    
	[self.navigationController pushViewController:controller animated:YES];
    [controller release];
    [note release];
}

- (void)viewDidAppear:(BOOL)animated {

    [super viewDidAppear:animated];	
}

- (void)viewWillDisappear:(BOOL)animated {

	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {

	[super viewDidDisappear:animated];
}

#pragma mark UITableViewDataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.notes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    Note *note = [self.notes objectAtIndex:indexPath.row];
    [cell.textLabel setText:note.content];
    
    return cell;
}

#pragma mark UITableViewDelegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    NoteViewController *controller = [[NoteViewController alloc] initWithNibName:@"NoteViewController" bundle:[NSBundle mainBundle]];
    Note *note = [self.notes objectAtIndex:indexPath.row];
    controller.note = note;
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
}

- (void)didReceiveMemoryWarning {

    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {

    [super viewDidUnload];
}

- (void)dealloc {

    [_notes release];
    [super dealloc];
}

@end
