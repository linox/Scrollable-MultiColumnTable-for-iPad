//
//  MCTableScrollContainer.h
//  MColumnTable
//
//  Created by Andrey Cherkashin on 19.07.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

/** Protocol for custom MCTable styling */
@protocol MCTableStyleDelegate <NSObject>
@optional

/** Used to style labels for header */
- (void)willDisplayHeaderLabel:(UILabel*)label inColumn:(NSInteger)column;
/** Used to style delimiters for header */
- (void)willDisplayHeaderDelimiter:(UIView*)delimiter inColumn:(NSInteger)column;
/** Used to style headerView */
- (void)willDisplayHeader:(UIView *)headerView;
/** Used to style labels for cell */
- (void)willDisplayLabel:(UILabel*)label atIndexPath:(NSIndexPath*)indexPath inColumn:(NSInteger)column;
/** Used to style delimiters for cell */
- (void)willDisplayDelimiter:(UIView*)delimiter atIndexPath:(NSIndexPath*)indexPath inColumn:(NSInteger)column;
/** Used to style cell */
- (void)willDisplayCell:(UITableViewCell*)cell atIndexPath:(NSIndexPath*)indexPath;

@end

/** Protocol for inplementing data source for MCTable */
@protocol MCTableDataSource <NSObject>

/** Returns value for cell */
- (NSString*)cellValueAtIndexPath:(NSIndexPath*)indexPath forColumn:(NSInteger)column;
/** Returns number of rows */
- (NSInteger)numberOfRowsInSection:(NSInteger)section;
/** Returns reuseIdentifier for cells */
- (NSString*)reuseIdentifierForCellAtIndexPath:(NSIndexPath*)indexPath;

@optional

/** Returns title for column to use in header */
- (NSString*)titleForColumn:(NSInteger)column;
/** Returns height for table header */
- (NSInteger)heightForTableHeader;
/** Returns height for cell */
- (NSInteger)heightForRowAtIndexPath:(NSIndexPath*)indexPath;
/** Returns number of sections in table */
- (NSInteger)numberOfSectionsInTable;

@end

/** Class that represents a scrollable MCTable
 
 Scrollable MCTable can be created in two ways:
 
 - Programmaticaly, using creation code in viewDidLoad method.
 - Using interface builder.
 
 */
@interface MCTableScrollContainer : UIScrollView <UITableViewDelegate, UITableViewDataSource>

/** Indicates when Table is bigger than frame and horisontalScrolling is used
 */
@property (readonly, assign) BOOL horisontalScrolling;
/** Used to enable/disable table header showing
 */
@property (nonatomic, assign) BOOL showTableHeader;
/** UITableView used in table
 */
@property (strong, nonatomic) UITableView *tableView;
/** Used to assign custom styles for table
 */
@property (unsafe_unretained) IBOutlet id<MCTableStyleDelegate> styleDelegate;
/** Gives data for table
 */
@property (unsafe_unretained) IBOutlet id<MCTableDataSource> dataSource;
/** Array of columns used in table
 */
@property (readonly, nonatomic) NSArray *columns;

/** Initialize a MCTableScrollContainer with input parameters
 
 @param frame Frame for table
 @param columns Array that contains widthes of all columns
 @return Initialized instance of table
 */
- (id)initWithFrame:(CGRect)frame andColumnWidthes:(NSArray*)columnWidthes;

/** Changes width of chosen column
 
 @param width New width for column
 @param column Column index that needs to be changed
 */
- (void)changeWidth:(NSInteger)width inColumn:(NSInteger)column;

/** Adds column with specific width
 
 @param width Width for new column
 @see addColumn:
 @see insertColumn:atIndex:
 @see deleteColumn:
 */
- (void)addColumnWithWidth:(NSInteger)width;
/** Inserts column to table by index
 
 @param width Width for new column
 @param column Column index, where we wanted to insert a new column
 @see addColumn:
 @see insertColumn:atIndex:
 @see deleteColumn:
 */
- (void)insertColumnWidth:(NSInteger)width atIndex:(NSInteger)column;
/** Deleting column at index from table
 
 @param column Column index of deleting column
 @see addColumn:
 @see insertColumn:atIndex:
 @see deleteColumn:
 */
- (void)deleteColumnAtIndex:(NSInteger)column;

/** Force to update table data */
- (void)reloadData;

@end
