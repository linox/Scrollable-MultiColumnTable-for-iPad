
//
//  MCTableScrollContainer.m
//  MColumnTable
//
//  Created by Andrey Cherkashin on 19.07.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MCTableScrollContainer.h"
#import "MCCell.h"
#import "MCTableHeaderView.h"

@interface MCTableScrollContainer (Private)

- (void)recalculateSize;

@end

@implementation MCTableScrollContainer {
	NSMutableArray *columns;
	MCTableHeaderView *tableHeaderView;
}

@synthesize horisontalScrolling, tableView = _tableView, showTableHeader;
@synthesize dataSource, styleDelegate;
@synthesize columns;

- (id)initWithCoder:(NSCoder *)aDecoder {
	if (self = [super initWithCoder:aDecoder]) {
		columns = [NSMutableArray array];
		
		showTableHeader = NO;
		
		_tableView = [[UITableView alloc] init];
		tableHeaderView = [[MCTableHeaderView alloc] init];
		
		[self recalculateSize];
		
		_tableView.dataSource = self;
		
		[self addSubview:_tableView];
	}
	return self;
}

- (id)initWithFrame:(CGRect)frame andColumnWidthes:(NSArray*)_columnWidthes {
	if (self = [super initWithFrame:frame]) {
		columns = [NSMutableArray arrayWithArray:_columnWidthes];
		
		showTableHeader = NO;
		
		_tableView = [[UITableView alloc] init];
		tableHeaderView = [[MCTableHeaderView alloc] init];
		
		[self recalculateSize];
		
		_tableView.dataSource = self;
		
		[self addSubview:_tableView];
	}
	return self;
}

- (void)changeWidth:(NSInteger)width inColumn:(NSInteger)column {
	[columns removeObjectAtIndex:column];
	[columns insertObject:[NSNumber numberWithInt:width] atIndex:column];
	[self recalculateSize];
	[_tableView reloadData];
}

- (void)addColumnWithWidth:(NSInteger)width {
	[columns addObject:[NSNumber numberWithInt:width]];
	[self recalculateSize];
	[_tableView reloadData];
}

- (void)insertColumnWidth:(NSInteger)width atIndex:(NSInteger)column {
	[columns insertObject:[NSNumber numberWithInt:width] atIndex:column];
	[self recalculateSize];
	[_tableView reloadData];
}

- (void)deleteColumnAtIndex:(NSInteger)column {
	[columns removeObjectAtIndex:column];
	[self recalculateSize];
	[_tableView reloadData];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
	if ([key isEqualToString:@"column"]) {
		[columns addObject:value];
	}
}

#pragma mark - Table Header actions

- (void)setShowTableHeader:(BOOL)_showTableHeader {
	showTableHeader = _showTableHeader;
	[self recalculateSize];
	[_tableView reloadData];
}

#pragma mark - UITableViewDataSource implementation

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [dataSource numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSString *reuseIdentifier = [dataSource reuseIdentifierForCellAtIndexPath:indexPath];
	MCCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
	
	int cellHeight = 44;
	if ([dataSource respondsToSelector:@selector(heightForRowAtIndexPath:)]) {
		cellHeight = [dataSource heightForRowAtIndexPath:indexPath];
	}
	
	if (!cell) {
		cell = [[MCCell alloc] initWithReuseIdentifier:reuseIdentifier cellHeight:cellHeight andColumns:columns];
	} else {
		[cell updateCellWithColumns:columns cellHeight:cellHeight];
	}
	
	[cell updateCellDataAtIndexPath:indexPath withDataSource:dataSource useStyleDelegate:styleDelegate];
	[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
	
	if ([styleDelegate respondsToSelector:@selector(willDisplayCell:atIndexPath:)]) {
		[styleDelegate willDisplayCell:cell atIndexPath:indexPath];
	}
	
	return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	if ([dataSource respondsToSelector:@selector(numberOfSectionsInTable)]) {
		return [dataSource numberOfSectionsInTable];
	}
	return 1;
}

- (void)reloadData {
	[self recalculateSize];
	[_tableView reloadData];
}

@end

@implementation MCTableScrollContainer (Private)

-(void)recalculateSize {
	
	int rowWidth = 0;
	for (int i = 0; i < [columns count]; i++) {
		rowWidth += [[columns objectAtIndex:i] intValue];
	}
	
	int tableHeaderHeight = 44;
	if ([dataSource respondsToSelector:@selector(heightForTableHeader)]) {
		tableHeaderHeight = [dataSource heightForTableHeader];
	}
	
	if (rowWidth > self.frame.size.width) {
		horisontalScrolling = YES;
		self.contentSize = CGSizeMake(rowWidth, self.frame.size.height);
		[_tableView setFrame:CGRectMake(0, 0, rowWidth, self.frame.size.height)];
		[tableHeaderView setFrame:CGRectMake(0, 0, rowWidth, tableHeaderHeight)];
	} else {
		horisontalScrolling = NO;
		self.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
		[_tableView setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
		[tableHeaderView setFrame:CGRectMake(0, 0, self.frame.size.width, tableHeaderHeight)];
	}
	
	if (showTableHeader) {
		_tableView.tableHeaderView = tableHeaderView;
		[tableHeaderView updateWithColumns:columns andHeaderHeight:tableHeaderHeight];
		[tableHeaderView updateDataWithDataSource:dataSource useStyleDelegate:styleDelegate];
		if ([styleDelegate respondsToSelector:@selector(willDisplayHeader:)]) {
			[styleDelegate willDisplayHeader:tableHeaderView];
		}
	} else {
		_tableView.tableHeaderView = nil;
	}
	
}

@end
