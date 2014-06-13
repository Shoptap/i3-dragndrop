//
//  KIFUITestActor+I3DndTestAppAdditions.h
//  Test App
//
//  Created by Stephen Fortune on 05/04/2014.
//  Copyright (c) 2014 IceCube Software Ltd. All rights reserved.
//

#import "KIFUITestActor.h"


@interface KIFUITestActor (I3DndTestAppAdditions)


/**
 *  Test step methods for initiating dragging cells between tables and
 *  collections.
 */

-(void) dragCellInTableViewWithAccessibilityLabel:(NSString*) fromLabel
                                      atIndexPath:(NSIndexPath*) from
                toTableViewWithAccessibilityLabel:(NSString*) toLabel
                                      atIndexPath:(NSIndexPath*) to;

-(void) dragCellInTableViewWithAccessibilityLabel:(NSString*) fromLabel
                                      atIndexPath:(NSIndexPath*) from
           toCollectionViewWithAccessibilityLabel:(NSString*) toLabel
                                      atIndexPath:(NSIndexPath*) to;

-(void) dragCellInCollectionViewWithAccessibilityLabel:(NSString*) fromLabel
                                           atIndexPath:(NSIndexPath*) from
                     toTableViewWithAccessibilityLabel:(NSString*) toLabel
                                           atIndexPath:(NSIndexPath*) to;

-(void) dragCellInCollectionViewWithAccessibilityLabel:(NSString*) fromLabel
                                           atIndexPath:(NSIndexPath*) from
                toCollectionViewWithAccessibilityLabel:(NSString*) toLabel
                                           atIndexPath:(NSIndexPath*) to;

/**
 *  Helper additional method for navigating between the current test
 *  cases.
 *  Takes the example case number as a parameter.
 */
-(void) navigateToExampleCaseNumber:(NSInteger) testCaseNumber;


/**
 *  Helper method which returns the point relative to the main superview, for the
 *  center of a given cell in a table.
 */
-(CGPoint) pointForIndexPath:(NSIndexPath*) index inTableView:(UITableView*) table;


/**
 *  Helper method which returns the point relative to the main superview, for the
 *  center of a given cell in a collection view.
 */
-(CGPoint) pointForIndexPath:(NSIndexPath*) index inCollectionView:(UICollectionView*) collection;


/**
 *  An array of the Example Cases' tab button accessabillity labels. The
 *  index of the table represents its test case number - 1, for example
 *  at index 0, there will be the accessibillity label for the tab button
 *  for Example Case 1.
 *  You can pass this number to navigateToExampleCaseNumber: to navigate
 *  to that example case.
 */
@property (nonatomic, readonly, strong) NSArray* testCaseToAccessibillityMap;


@end
