//
//  MCCell.h
//  MColumnTable
//
//  Created by Andrey Cherkashin on 19.07.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MCTableStyleDelegate, MCTableDataSource;
/** This class used to create and update multicolumn cells */
@interface MCCell : UITableViewCell

/** Initialize instance of MCCell using input parameters
 
 @param reuseIdentifier A parameter that sets Reuse Identifier for new cell
 @param height A parameter that sets a height of new cell
 @param columns An array that contains all widthes of columns
 @return Initialized instance of MCCell
 @see updateCellWithColumns:cellHeight:
 */
- (id)initWithReuseIdentifier:(NSString*)reuseIdentifier cellHeight:(CGFloat)height andColumns:(NSArray*)columns;

/** Update cell using input parameters
 
 @param columns An array that contains all widthes of columns
 @param height A parameter that sets a height of new cell
 @see updateCellDataAtIndexPath:withDataSource:useStyleDelegate:
 */
- (void)updateCellWithColumns:(NSArray*)columns cellHeight:(CGFloat)height;
/** Update cell data using input parameters
 
 @param indexPath IndexPath of cell
 @param dataSource DataSource delegate that used to get values for columns
 @param styleDelegate Style delegate that used to style labels and delimiters for cell
 @see updateCellWithColumns:cellHeight:
 */
- (void)updateCellDataAtIndexPath:(NSIndexPath*)indexPath withDataSource:(id<MCTableDataSource>)dataSource useStyleDelegate:(id<MCTableStyleDelegate>)styleDelegate;

@end
