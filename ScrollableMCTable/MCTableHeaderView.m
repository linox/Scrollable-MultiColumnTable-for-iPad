//
//  MCTableHeaderView.m
//  MColumnTable
//
//  Created by Andrey Cherkashin on 20.07.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MCTableHeaderView.h"
#import "MCTableScrollContainer.h"

@interface MCTableHeaderView (Private)

- (UILabel*)headerLabelForX:(NSInteger)x withWidth:(NSInteger)width andHeight:(NSInteger)height;
- (UIView*)delimiterForX:(NSInteger)x withHeight:(NSInteger)height;

@end

@implementation MCTableHeaderView {
	NSMutableArray *headerLabels;
	NSMutableArray *delimiters;
}

- (id)init {
	if (self = [super init]) {
		headerLabels = [NSMutableArray array];
		delimiters = [NSMutableArray array];
		[self setBackgroundColor:[UIColor lightGrayColor]];
	}
	return self;
}

- (void)updateWithColumns:(NSArray*)columns andHeaderHeight:(NSInteger)height {
	if ([headerLabels count] == [columns count]) {
		
		int currentX = 0;
		for (int i = 0; i < [columns count]; i++) {
			
			UILabel *headerLabel = [headerLabels objectAtIndex:i];
			[headerLabel setFrame:CGRectMake(currentX + (currentX == 0 ? 0 : 1), 0, [[columns objectAtIndex:i] intValue] - (currentX == 0 ? 0 : 1), height)];
			
			UIView *delimiter = [delimiters objectAtIndex:i];
			[delimiter setFrame:CGRectMake(currentX + [[columns objectAtIndex:i] intValue], 0, 1, height)];
			
			currentX += [[columns objectAtIndex:i] intValue];
			
		}
		
	} else {
		if ([headerLabels count] > [columns count]) {
			
			int currentX = 0;
			for (int i = 0; i < [columns count]; i++) {
				
				UILabel *headerLabel = [headerLabels objectAtIndex:i];
				[headerLabel setFrame:CGRectMake(currentX + (currentX == 0 ? 0 : 1), 0, [[columns objectAtIndex:i] intValue] - (currentX == 0 ? 0 : 1), height)];
				
				UIView *delimiter = [delimiters objectAtIndex:i];
				[delimiter setFrame:CGRectMake(currentX + [[columns objectAtIndex:i] intValue], 0, 1, height)];
				
				currentX += [[columns objectAtIndex:i] intValue];
				
			}
			for (int j = [headerLabels count]-1; j >= [columns count]; j--) {
				
				[[headerLabels objectAtIndex:j] removeFromSuperview];
				[headerLabels removeObjectAtIndex:j];
				
				[[delimiters objectAtIndex:j] removeFromSuperview];
				[delimiters removeObjectAtIndex:j];
				
			}
			
		} else {
			
			int currentX = 0;
			for (int i = 0; i < [headerLabels count]; i++) {
				
				UILabel *headerLabel = [headerLabels objectAtIndex:i];
				[headerLabel setFrame:CGRectMake(currentX + (currentX == 0 ? 0 : 1), 0, [[columns objectAtIndex:i] intValue] - (currentX == 0 ? 0 : 1), height)];
				
				UIView *delimiter = [delimiters objectAtIndex:i];
				[delimiter setFrame:CGRectMake(currentX + [[columns objectAtIndex:i] intValue], 0, 1, height)];
				
				currentX += [[columns objectAtIndex:i] intValue];
				
			}
			for (int j = [headerLabels count]; j < [columns count]; j++) {
				
				// Creating new cell UILabel
				UILabel *newHeaderLabel = [self headerLabelForX:currentX withWidth:[[columns objectAtIndex:j] intValue] andHeight:height];
				[headerLabels addObject:newHeaderLabel];
				[self addSubview:newHeaderLabel];
				
				// Creating new delimiter view
				UIView *delimiterView = [self delimiterForX:(currentX + [[columns objectAtIndex:j] intValue]) withHeight:height];
				[delimiters addObject:delimiterView];
				[self addSubview:delimiterView];
				
				currentX += [[columns objectAtIndex:j] intValue];
				
			}
			
		}
	}
}

- (void)updateDataWithDataSource:(id<MCTableDataSource>)dataSource useStyleDelegate:(id<MCTableStyleDelegate>)styleDelegate {
	for (int i = 0; i < [headerLabels count]; i++) {
		
		UILabel *headerLabel = [headerLabels objectAtIndex:i];
		[headerLabel setText:@""];
		if ([dataSource respondsToSelector:@selector(titleForColumn:)]) {
			[headerLabel setText:[dataSource titleForColumn:i]];
		}
		if ([styleDelegate respondsToSelector:@selector(willDisplayHeaderLabel:inColumn:)]) {
			[styleDelegate willDisplayHeaderLabel:headerLabel inColumn:i];
		}
		
		UIView *delimiterView = [delimiters objectAtIndex:i];
		if ([styleDelegate respondsToSelector:@selector(willDisplayHeaderDelimiter:inColumn:)]) {
			[styleDelegate willDisplayHeaderDelimiter:delimiterView inColumn:i];
		}
		
	}
}

@end

@implementation MCTableHeaderView (Private)

- (UILabel*)headerLabelForX:(NSInteger)x withWidth:(NSInteger)width andHeight:(NSInteger)height {
	UILabel *newHeaderLabel = [[UILabel alloc] initWithFrame:CGRectMake(x + (x == 0 ? 0 : 1), 0, width - (x == 0 ? 0 : 1), height)];
	[newHeaderLabel setBackgroundColor:[UIColor clearColor]];
	[newHeaderLabel setTextAlignment:UITextAlignmentCenter];
	return newHeaderLabel;
}

- (UIView*)delimiterForX:(NSInteger)x withHeight:(NSInteger)height {
	UIView *delimiterView = [[UIView alloc] initWithFrame:CGRectMake(x, 0, 1, height)];
	[delimiterView setBackgroundColor:[UIColor grayColor]];
	return delimiterView;
}

@end
