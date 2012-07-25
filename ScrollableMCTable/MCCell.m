//
//  MCCell.m
//  MColumnTable
//
//  Created by Andrey Cherkashin on 19.07.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MCCell.h"
#import "MCTableScrollContainer.h"

@interface MCCell (Private)

- (UILabel*)cellLabelForX:(NSInteger)x withWidth:(NSInteger)width andHeight:(NSInteger)height;
- (UIView*)delimiterForX:(NSInteger)x withHeight:(NSInteger)height;

@end

@implementation MCCell {
	NSMutableArray *cellLabels;
	NSMutableArray *delimiters;
}

- (id)initWithReuseIdentifier:(NSString*)reuseIdentifier cellHeight:(CGFloat)height andColumns:(NSArray*)columns {
	if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) {
		
		cellLabels = [NSMutableArray array];
		delimiters = [NSMutableArray array];
		
		int currentX = 0;
		for (int i = 0; i < [columns count]; i++) {
			
			// Creating new cell UILabel
			UILabel *newCellLabel = [self cellLabelForX:currentX withWidth:[[columns objectAtIndex:i] intValue] andHeight:height];
			[cellLabels addObject:newCellLabel];
			[self addSubview:newCellLabel];
			
			// Creating new delimiter view
			UIView *delimiterView = [self delimiterForX:(currentX + [[columns objectAtIndex:i] intValue]) withHeight:height];
			[delimiters addObject:delimiterView];
			[self addSubview:delimiterView];
			
			currentX += [[columns objectAtIndex:i] intValue];
		}
		
	}
	return self;
}

- (void)updateCellWithColumns:(NSArray*)columns cellHeight:(CGFloat)height {
	if ([columns count] == [cellLabels count]) {
		
		int currentX = 0;
		for (int i = 0; i < [columns count]; i++) {
			
			UILabel *cellLabel = [cellLabels objectAtIndex:i];
			[cellLabel setFrame:CGRectMake(currentX + 1, 0, [[columns objectAtIndex:i] intValue] - 1, height)];
			
			UIView *delimiter = [delimiters objectAtIndex:i];
			[delimiter setFrame:CGRectMake(currentX + [[columns objectAtIndex:i] intValue], 0, 1, height)];
			
			currentX += [[columns objectAtIndex:i] intValue];
			
		}
		
	} else {
		
		if ([columns count] < [cellLabels count]) {
			
			int currentX = 0;
			for (int i = 0; i < [columns count]; i++) {
				
				UILabel *cellLabel = [cellLabels objectAtIndex:i];
				[cellLabel setFrame:CGRectMake(currentX + 1, 0, [[columns objectAtIndex:i] intValue] - 1, height)];
				
				UIView *delimiter = [delimiters objectAtIndex:i];
				[delimiter setFrame:CGRectMake(currentX + [[columns objectAtIndex:i] intValue], 0, 1, height)];
				
				currentX += [[columns objectAtIndex:i] intValue];
				
			}
			for (int j = [cellLabels count]-1; j >= [columns count]; j--) {
				
				[[cellLabels objectAtIndex:j] removeFromSuperview];
				[cellLabels removeObjectAtIndex:j];
				
				[[delimiters objectAtIndex:j] removeFromSuperview];
				[delimiters removeObjectAtIndex:j];
				
			}
			
		} else {
			
			int currentX = 0;
			for (int i = 0; i < [cellLabels count]; i++) {
				
				UILabel *cellLabel = [cellLabels objectAtIndex:i];
				[cellLabel setFrame:CGRectMake(currentX + 1, 0, [[columns objectAtIndex:i] intValue] - 1, height)];
				
				UIView *delimiter = [delimiters objectAtIndex:i];
				[delimiter setFrame:CGRectMake(currentX + [[columns objectAtIndex:i] intValue], 0, 1, height)];
				
				currentX += [[columns objectAtIndex:i] intValue];
				
			}
			for (int j = [cellLabels count]; j < [columns count]; j++) {
				
				// Creating new cell UILabel
				UILabel *newCellLabel = [self cellLabelForX:currentX withWidth:[[columns objectAtIndex:j] intValue] andHeight:height];
				[cellLabels addObject:newCellLabel];
				[self addSubview:newCellLabel];
				
				// Creating new delimiter view
				UIView *delimiterView = [self delimiterForX:(currentX + [[columns objectAtIndex:j] intValue]) withHeight:height];
				[delimiters addObject:delimiterView];
				[self addSubview:delimiterView];
				
				currentX += [[columns objectAtIndex:j] intValue];
				
			}
			
		}
		
	}
}

- (void)updateCellDataAtIndexPath:(NSIndexPath*)indexPath withDataSource:(id<MCTableDataSource>)dataSource useStyleDelegate:(id<MCTableStyleDelegate>)styleDelegate {
	
	for (int i = 0; i < [cellLabels count]; i++) {
		
		UILabel *cellLabel = [cellLabels objectAtIndex:i];
		[cellLabel setText:[dataSource cellValueAtIndexPath:indexPath forColumn:i]];
		if ([styleDelegate respondsToSelector:@selector(willDisplayLabel:atIndexPath:inColumn:)]) {
			[styleDelegate willDisplayLabel:cellLabel atIndexPath:indexPath inColumn:i];
		}
		
		UIView *delimiterView = [delimiters objectAtIndex:i];
		if ([styleDelegate respondsToSelector:@selector(willDisplayDelimiter:atIndexPath:inColumn:)]) {
			[styleDelegate willDisplayDelimiter:delimiterView atIndexPath:indexPath inColumn:i];
		}
		
	}
}

@end

@implementation MCCell (Private)

- (UILabel*)cellLabelForX:(NSInteger)x withWidth:(NSInteger)width andHeight:(NSInteger)height {
	UILabel *newCellLabel = [[UILabel alloc] initWithFrame:CGRectMake(x + (x == 0 ? 0 : 1), 0, width - 1, height)];
	[newCellLabel setBackgroundColor:[UIColor clearColor]];
	[newCellLabel setTextAlignment:UITextAlignmentRight];
	return newCellLabel;
}

- (UIView*)delimiterForX:(NSInteger)x withHeight:(NSInteger)height {
	UIView *delimiterView = [[UIView alloc] initWithFrame:CGRectMake(x, 0, 1, height)];
	[delimiterView setBackgroundColor:[UIColor grayColor]];
	return delimiterView;
}

@end
