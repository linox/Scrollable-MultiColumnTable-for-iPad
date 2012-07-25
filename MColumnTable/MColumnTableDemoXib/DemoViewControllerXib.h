//
//  DemoViewControllerXib.h
//  MColumnTable
//
//  Created by Andrey Cherkashin on 20.07.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCTableScrollContainer.h"

@interface DemoViewControllerXib : UIViewController <MCTableDataSource, MCTableStyleDelegate>

@property (weak, nonatomic) IBOutlet MCTableScrollContainer *scrollTable;
@property (weak, nonatomic) IBOutlet UILabel *numberOfColumnsLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberOfRowsLabel;
@property (weak, nonatomic) IBOutlet UILabel *widthLabel;

- (IBAction)deleteColumn:(id)sender;
- (IBAction)addColumn:(id)sender;
- (IBAction)insertColumn:(id)sender;
- (IBAction)addRow:(id)sender;
- (IBAction)deleteRow:(id)sender;
- (IBAction)tableHeaderChanged:(UISwitch *)sender;
- (IBAction)columnWidthChanged:(UISlider *)sender;

- (void)updateLabels;


@end
