//
//  KIFUITestActor+I3DndTestAppAdditions.m
//  Test App
//
//  Created by Stephen Fortune on 05/04/2014.
//  Copyright (c) 2014 IceCube Software Ltd. All rights reserved.
//

#import "KIFUITestActor+I3DndTestAppAdditions.h"
#import "UIWindow-KIFAdditions.h"
#import "UIAccessibilityElement-KIFAdditions.h"
#import "UIView-KIFAdditions.h"
#import "NSError-KIFAdditions.h"
#import "CGGeometry-KIFAdditions.h"


@implementation KIFUITestActor (I3DndTestAppAdditions)


-(NSArray*) testCaseToAccessibillityMap{
    
    return @[
             @"2 Re Tables",
             @"2ExTablesTabButton",
             @"2ReExTablesTabButton",
             @"tableToReTableTabButton",
             @"2ExCollectionsTabButton",
             @"col2ReColTabButtonTabButton",
             @"paintMeTabButton",
             ];
}


-(UIView*) mainSuperview{
    return [[[UIApplication sharedApplication] keyWindow] subviews].lastObject;
}


-(UIView*) viewForAccessibilityLabel:(NSString*) label{
    
    UIAccessibilityElement* accessibility = nil;
    UIView* view = nil;
    
    [self waitForAccessibilityElement:&accessibility
                                 view:&view
                            withLabel:label
                                value:nil
                               traits:UIAccessibilityTraitNone
                             tappable:NO];
    
    return view;

}


-(CGPoint) pointForIndexPath:(NSIndexPath*) index inTableView:(UITableView*) table{
    
    CGRect cellRect = [table rectForRowAtIndexPath:index];
    CGPoint centerCellPoint = CGPointCenteredInRect(cellRect);
    UIView* superview = [self mainSuperview];
    
    return [superview convertPoint:centerCellPoint fromView:superview];
}


-(CGPoint) pointForIndexPath:(NSIndexPath*) index inCollectionView:(UICollectionView*) collection{
    
    // TODO

}


-(void) dragCellInTableViewWithAccessibilityLabel:(NSString*) fromLabel
                                      atIndexPath:(NSIndexPath*) from
                toTableViewWithAccessibilityLabel:(NSString*) toLabel
                                      atIndexPath:(NSIndexPath*) to{

    /** Load table views from accessibility labels */
    
    UITableView* toTable = (UITableView*)[self viewForAccessibilityLabel:toLabel];
    UITableView* fromTable = (UITableView*)[self viewForAccessibilityLabel:fromLabel];
    UIView* superview = [self mainSuperview];
    
    
    /** Triggers a drag */
    
    CGPoint fromPoint = [self pointForIndexPath:from inTableView:fromTable];
    CGPoint toPoint = [self pointForIndexPath:to inTableView:toTable];
    
    [superview dragFromPoint:fromPoint toPoint:toPoint];
    
}


-(void) dragCellInTableViewWithAccessibilityLabel:(NSString*) fromLabel
                                      atIndexPath:(NSIndexPath*) from
           toCollectionViewWithAccessibilityLabel:(NSString*) toLabel
                                      atIndexPath:(NSIndexPath*) to{
    
    /** Load containers from accessibility labels */
    
    UICollectionView* toCollection = (UICollectionView*)[self viewForAccessibilityLabel:toLabel];
    UITableView* fromTable = (UITableView*)[self viewForAccessibilityLabel:fromLabel];
    UIView* superview = [self mainSuperview];
    
    
    /** Triggers a drag */
    
    CGPoint fromPoint = [self pointForIndexPath:from inTableView:fromTable];
    CGPoint toPoint = [self pointForIndexPath:to inCollectionView:toCollection];
    
    [superview dragFromPoint:fromPoint toPoint:toPoint];
    
}


-(void) dragCellInCollectionViewWithAccessibilityLabel:(NSString*) fromLabel
                                           atIndexPath:(NSIndexPath*) from
                     toTableViewWithAccessibilityLabel:(NSString*) toLabel
                                           atIndexPath:(NSIndexPath*) to{
    
    /** Load containers from accessibility labels */
    
    UITableView* toTable = (UITableView*)[self viewForAccessibilityLabel:toLabel];
    UICollectionView* fromCollection = (UICollectionView*)[self viewForAccessibilityLabel:fromLabel];
    UIView* superview = [self mainSuperview];
    
    
    /** Triggers a drag */
    
    CGPoint fromPoint = [self pointForIndexPath:from inCollectionView:fromCollection];
    CGPoint toPoint = [self pointForIndexPath:to inTableView:toTable];
    
    [superview dragFromPoint:fromPoint toPoint:toPoint];
    
}


-(void) dragCellInCollectionViewWithAccessibilityLabel:(NSString*) fromLabel
                                           atIndexPath:(NSIndexPath*) from
                toCollectionViewWithAccessibilityLabel:(NSString*) toLabel
                                           atIndexPath:(NSIndexPath*) to{

    
    /** Load collections from accessibility labels */
    
    UICollectionView* toCollection = (UICollectionView*)[self viewForAccessibilityLabel:toLabel];
    UICollectionView* fromCollection = (UICollectionView*)[self viewForAccessibilityLabel:fromLabel];
    UIView* superview = [self mainSuperview];
    
    
    /** Triggers a drag */
    
    CGPoint fromPoint = [self pointForIndexPath:from inCollectionView:fromCollection];
    CGPoint toPoint = [self pointForIndexPath:to inCollectionView:toCollection];
    
    [superview dragFromPoint:fromPoint toPoint:toPoint];

}



-(void) navigateToExampleCaseNumber:(NSInteger) testCaseNumber{

    --testCaseNumber;
    
    /** Check that the test case number exists as an example case */
    
    if(testCaseNumber < 0 || testCaseNumber >= self.testCaseToAccessibillityMap.count){
        
        [NSException raise:@"KIFUITestActor(I3DndTestAppAdditions)InvalidExampleCase"
                    format:@"Example case number %ld does not exist or is not in the text case map",
                            (long)testCaseNumber];
    }
    
    NSString* tabButtonAccessibillityLabel = self.testCaseToAccessibillityMap[testCaseNumber];
    [self tapViewWithAccessibilityLabel:tabButtonAccessibillityLabel];
}


 @end