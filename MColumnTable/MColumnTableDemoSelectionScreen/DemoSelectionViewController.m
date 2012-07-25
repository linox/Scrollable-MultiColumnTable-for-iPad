//
//  DemoSelectionViewController.m
//  MColumnTable
//
//  Created by Andrey Cherkashin on 20.07.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DemoSelectionViewController.h"
#import "DemoViewController.h"
#import "DemoViewControllerXib.h"

@interface DemoSelectionViewController ()

@end

@implementation DemoSelectionViewController {
	DemoViewController *demoViewController;
	DemoViewControllerXib *demoViewControllerXib;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	
	demoViewController = [[DemoViewController alloc] initWithNibName:nil bundle:nil];
	demoViewControllerXib = [[DemoViewControllerXib alloc] initWithNibName:nil bundle:nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)programmaticalyCreation:(id)sender {
	[self.navigationController pushViewController:demoViewController animated:YES];
}

- (IBAction)usingInterfaceBuilder:(id)sender {
	[self.navigationController pushViewController:demoViewControllerXib animated:YES];
}

@end
