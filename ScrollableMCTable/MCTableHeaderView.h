//
//  MCTableHeaderView.h
//  MColumnTable
//
//  Created by Andrey Cherkashin on 20.07.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MCTableStyleDelegate, MCTableDataSource;
/** This class used to create and update multicolumn header */
@interface MCTableHeaderView : UIView

/** Update header using input parameters
 
 @param columns Array that contains all widthes of columns
 @param height Height of tableHeader
 @see updateDataWithDataSource:useStyleDelegate:
 */
- (void)updateWithColumns:(NSArray*)columns andHeaderHeight:(NSInteger)height;

/** Update header data using input parameters
 
 @param dataSource DataSource delegate used to get header titles
 @param styleDelegate Style delegate used to style labels and delimiters in headerView
 @see updateWithColumns:andHeaderHeight:
 */
- (void)updateDataWithDataSource:(id<MCTableDataSource>)dataSource useStyleDelegate:(id<MCTableStyleDelegate>)styleDelegate;

@end
