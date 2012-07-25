Scrollable MultiColumnTable for iPad
====================================

Scrollable MultiColumn Table easy to use, and easily customizable table control for iOS. Simply add the header, implement MCTableDataSource delegate and MCTableStyleDelegate (optional).

![SMCTable Screenshot](https://github.com/downloads/Eclair90/Scrollable-MultiColumnTable-for-iPad/SMCTable01.PNG)

Examples
========

You can create scrollable multi column in two ways:

1. Programmatically, just using a code below

		scrollTable = [[MCTableScrollContainer alloc] initWithFrame:CGRectMake(15, 15, 738, 440) andColumnWidthes:testColumns];
		scrollTable.dataSource = self;
		scrollTable.styleDelegate = self;
	
		[self.view addSubview:scrollTable];
	
2. Using interface builder:

In xib file add UIScrollView, change class to "MCTableScrollContainer"
You can also add initial columns to table, by adding key/value pairs with key "column" and value that contains column widths;

![SMCTable xibexample](https://github.com/downloads/Eclair90/Scrollable-MultiColumnTable-for-iPad/SMCTable02.png)