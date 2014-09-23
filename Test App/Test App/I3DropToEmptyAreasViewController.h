//
//  I3DropToEmptyAreasViewController.h
//  Test App
//
//  Copyright (c) 2014 IceCube Software Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "I3DragBetweenHelper.h"

@interface I3DropToEmptyAreasViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate, I3DragBetweenDelegate>

/** This is the Source collection */

@property (nonatomic, strong) IBOutlet UICollectionView* leftCollection;

/** This is the Destination collection */

@property (nonatomic, strong) IBOutlet UICollectionView* rightCollection;

@end
