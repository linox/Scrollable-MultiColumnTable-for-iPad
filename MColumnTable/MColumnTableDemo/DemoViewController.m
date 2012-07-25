//
//  DemoViewController.m
//  MColumnTable
//
//  Created by Andrey Cherkashin on 19.07.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DemoViewController.h"

@interface DemoViewController ()

@end

@implementation DemoViewController {
	MCTableScrollContainer *scrollTable;
	NSInteger rows;
}
@synthesize numberOfColumnsLabel;
@synthesize numberOfRowsLabel;
@synthesize widthLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
		rows = 5;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
	// Table Creation Code
	NSArray *testColumns = [NSArray arrayWithObjects:[NSNumber numberWithInt:40], [NSNumber numberWithInt:240], [NSNumber numberWithInt:100], [NSNumber numberWithInt:50], nil];
	
	scrollTable = [[MCTableScrollContainer alloc] initWithFrame:CGRectMake(15, 15, 738, 440) andColumnWidthes:testColumns];
	scrollTable.dataSource = self;
	scrollTable.styleDelegate = self;
	
	[self.view addSubview:scrollTable];
	
	[self updateLabels];
}

- (void)viewDidUnload {
	[self setNumberOfColumnsLabel:nil];
	[self setNumberOfRowsLabel:nil];
	[self setWidthLabel:nil];
    [super viewDidUnload];
	
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - MCTableDataSource

- (NSString*)cellValueAtIndexPath:(NSIndexPath*)indexPath forColumn:(NSInteger)column {
	switch (column) {
		case 0:
			return [NSString stringWithFormat:@"%d",indexPath.row+1];
			
		case 1:
			return [NSString stringWithFormat:@"This is the text for %d row",indexPath.row+1];
			
		case 2:
			return [NSString stringWithFormat:@"Data %d",indexPath.row+1];
			
		default:
			return [NSString stringWithFormat:@"%d",indexPath.row+1];
	}
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section {
	return rows;
}

- (NSString*)reuseIdentifierForCellAtIndexPath:(NSIndexPath*)indexPath {
	return @"testTable";
}

- (NSString*)titleForColumn:(NSInteger)column {
	switch (column) {
		case 0:
			return @"No";
		case 1:
			return @"Title";
		case 2:
			return @"Data";
			
		default:
			return [NSString stringWithFormat:@"C:%d",column];
	}
}

- (NSInteger)heightForTableHeader {
	return 20;
}

#pragma mark - MCTableStyleDelegate

- (void)willDisplayLabel:(UILabel*)label atIndexPath:(NSIndexPath*)indexPath inColumn:(NSInteger)column {
	[label setFont:[UIFont systemFontOfSize:12]];
	[label setBackgroundColor:[UIColor clearColor]];
	switch (column) {
		case 0:
			if ((indexPath.row+1)%5 == 0) {
				[label setTextColor:[UIColor redColor]];
			} else {
				[label setTextColor:[UIColor blackColor]];
			}
			break;
		
		case 1:
			switch (indexPath.row%5) {
				case 0:
					[label setTextColor:[UIColor yellowColor]];
					break;
				case 1:
					[label setTextColor:[UIColor greenColor]];
					break;
				case 2:
					[label setTextColor:[UIColor orangeColor]];
					break;
				case 3:
					[label setTextColor:[UIColor purpleColor]];
					break;
				case 4:
					[label setTextColor:[UIColor whiteColor]];
					[label setBackgroundColor:[UIColor blackColor]];
					break;
			}
			break;
			
		default:
			[label setTextColor:[UIColor brownColor]];
			break;
	}
}

- (void)willDisplayDelimiter:(UIView*)delimiter atIndexPath:(NSIndexPath*)indexPath inColumn:(NSInteger)column {
	if (column == 0) {
		[delimiter setBackgroundColor:[UIColor redColor]];
	}
}

- (void)willDisplayCell:(UITableViewCell*)cell atIndexPath:(NSIndexPath*)indexPath {
	[cell setBackgroundView:nil];
	if (indexPath.row == 0) {
		UIView *backgroundView = [[UIView alloc] initWithFrame:cell.frame];
		[backgroundView setBackgroundColor:[UIColor cyanColor]];
		[cell setBackgroundView:backgroundView];
	}
}

- (void)willDisplayHeaderLabel:(UILabel*)label inColumn:(NSInteger)column {
	[label setTextColor:[UIColor blackColor]];
	if (column == 0) {
		[label setTextColor:[UIColor whiteColor]];
		[label setBackgroundColor:[UIColor redColor]];
	}
	if (column == 1) {
		[label setBackgroundColor:[UIColor whiteColor]];
		[label setFont:[UIFont boldSystemFontOfSize:15]];
		[label setTextColor:[UIColor greenColor]];
	}
}

- (void)willDisplayHeaderDelimiter:(UIView*)delimiter inColumn:(NSInteger)column {
	[delimiter setBackgroundColor:[UIColor lightGrayColor]];
	if (column == 0) {
		[delimiter setBackgroundColor:[UIColor redColor]];
	}
}

- (void)willDisplayHeader:(UIView *)headerView {
	[headerView setBackgroundColor:[UIColor greenColor]];
}

#pragma mark - UI Actions

- (IBAction)deleteColumn:(id)sender {
	if ([scrollTable.columns count] > 4) {
		[scrollTable deleteColumnAtIndex:4];
	} else {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Deleting Unsuccessful" message:@"Number of columns is smaller than 5" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
	}
	[self updateLabels];
}

- (IBAction)addColumn:(id)sender {
	[scrollTable addColumnWithWidth:50];
	[self updateLabels];
}

- (IBAction)insertColumn:(id)sender {
	[scrollTable insertColumnWidth:50 atIndex:4];
	[self updateLabels];
}

- (IBAction)addRow:(id)sender {
	rows++;
	[scrollTable.tableView reloadData];
	[self updateLabels];
}

- (IBAction)deleteRow:(id)sender {
	if (rows > 0) {
		rows--;
		[scrollTable.tableView reloadData];
	}
	[self updateLabels];
}

- (IBAction)tableHeaderChanged:(UISwitch *)sender {
	[scrollTable setShowTableHeader:sender.isOn];
}

- (IBAction)columnWidthChanged:(UISlider *)sender {
	[scrollTable changeWidth:(int)sender.value inColumn:1];
	[widthLabel setText:[NSString stringWithFormat:@"Width of Second Column in Table: %d",(int)sender.value]];
}

- (void)updateLabels {
	[numberOfColumnsLabel setText:[NSString stringWithFormat:@"Number of Columns: %d",[scrollTable.columns count]]];
	[numberOfRowsLabel setText:[NSString stringWithFormat:@"Number of Rows: %d",rows]];
}

@end
