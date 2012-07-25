Scrollable MultiColumnTable for iPad
====================================

Scrollable MultiColumn Table is easy-to-use and easily customizable table control for iOS. Simply add the header, implement MCTableDataSource delegate and MCTableStyleDelegate (optional).

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

License (MIT)
=============

Copyright (C) 2012 Bekitzur, Andrey Cherkashin

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.