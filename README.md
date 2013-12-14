iOS Drag-n-Drop Between Helper
==============================

Objective-C helper class(es) for the iOS platform that handle drag and drop logic between 2 UITableView s and/or UICollectionView s.


Installation
------------

To use this in your project, copy the I3DragBetweenHelper class into your project directory - there is no Podspec (at the moment).

This repo also contains and example project called 'Test App' where you can see the helper class in action.

This project requires ARC to compile as is targeted at iOS 6 +.


Basic Usage
-----------

The helper has requires 2 view objects to be injected as the dragging targets:

- The source view. This must be either a UITableView or a UICollectionView
- The destination view. This, like the source, must either be a UITableView or a UICollectionView

These are the views which we will drag items between.

The helper also requires a 'superview' UIView to be injected. This is the view that contains both of the dragging target views.
The UIPanGestureRecognizer is attached to this view by the helper and this view's frame is where all panning events are listened for.

Here is a simple example of how to configure the helper:

	UIView* view = self.view // View controller's main view
	UITableView* sourceTable = self.sourceTable; // A table configured for the View controller via IB
	UITableView* destinationTable = self.destinationTable // A table configured for the View controller via IB
	
	I3DragBetweenHelper* helper = [[I3DragBetweenHelper alloc] initWithSuperview:view 
                                						 				 srcView:sourceTable
                                               						  	 dstView:destinationTable];

Now we have a helper configured to act on the appropriate view objects, but it doesn't do much. Next we need to implement a delegate for the Helper, so that we can deal with dropping events appropriately:

	helper.delegate = self; // The UIViewController must implement the I3DragBetweenDelegate protocol

See the various Example Cases for how to actually implement I3DragBetweenDelegate methods and further configure the helper to do cool things.



Stability
----------

This class is constantly being changed and updated as its being used and refined in a separate project - use it at your own risk.

Its been tested on iOS 6 and iOS 7 iPads for dragging between a UITableView and a UICollectionView.


*See notes on App Store Approval.

*See Example Cases for the included scenarios that the helper has been tested against.



Example Cases
-------------

######Example Case 1 - I32RearrangeableTablesViewController######
- 2 Table Views
- Src table does not accept cells from the Dst table
- Dst table does not accept cells from the Src table
- Src table is rearrangeable
- Dst table is rearrangeable
- Also demonstrates how to 'hide' the cell that's being dragged whilst its dragging

######Example Case 2 - I32ExchangeableTableViewsController######
- 2 Table Views
- Src table accepts cells from the Dst table
- Dst table accepts cells from the Src table
- Src table is not rearrangeable
- Dst table is not rearrangeable

######Example Case 3 - I32RearrangeableExchangeableTablesViewController######
- 2 Table Views
- Src table accepts cells from the Dst table
- Dst table accepts cells from the Src table
- Src table is rearrangeable
- Dst table is rearrangeable
- Both tables contain 1 cell that isn't draggable but is rearrangeable
- Both tables contain 1 cell that isn't rearrangeable but is draggable
- Both tables contain 1 cell that is neither draggable nor rearrangeable

######Example Case 4 - I3UnrearrangebleTableToTableViewController######
- 2 Table Views
- Src table does not accept cells from the Dst table
- Dst table accepts cells from the Src table
- Src table is not rearrangeable
- Dst table is rearrangeable
- Dst table contains 1 undraggable, un-rearrangeable placeholder cell
- If a cell from the Dst table is dragged outside of the table it is removed

######Example Case 5 - I32ExchangeableCollectionViewsController######
- 2 Collection Views
- Src accepts cells from Dst
- Dst accepts cells form Src
- Src is rearrangeable
- Dst is rearrangeable
- Both collections contain 1 cell that is neither draggable nor rearrangeable

######Example Case 6 - I3UnrarranreableToRearrangeableCollectionsViewController######
- 2 Collection Views
- Src doesn't accept Dst
- Dst accepts Src
- Src is not rearrangeable
- Dst is rearrangeable
- Dst contains 1 undraggable, un-rearrangeable placeholder cell
- Src cells aren't hidden on drag
- Dst cells are hidden on drag
- If a cell from the Dst collection is dragged outside of the view it is removed

######Example Case 6 - I3CollectionToRearrangeableTableViewController - Paint Me!######

This is the most complex example. The idea is that you can 'paint' the table cells with various colours, available from the collection view. By dragging the coloured collection view cells onto the table view cells you can apply the colour to the table view.

You can rearrange and play around with the table view to 'style' it.

You can also 'clean' the table view cells by dragging them outside of the table, at which point they will snap back to being white.

Configuration:

- Src Collection view
- Dst Table view
- Src doesn't accept Dst
- Dst accepts Src
- Src is not rearrangeable
- Dst is rearrangeable
- Src cells aren't hidden on drag
- Dst cells are hidden on drag
- If a cell from the Dst collection is dragged outside of the view it is altered and then snapped back


Recent Changes
--------------

- The helper no longer uses the actual sub view for the dragging cell - now, instead it generates a dummy cell for dragging. Its left up to the user to 'hide' the cell whilst its being dragged in the appropriate delegate methods, see Example Case 1. This breaks anything using the previous version.
- 'Hide' functionality has been added back to the helper in the form of the hide[Dst | Src]DraggingCell properties. This sets the original cell's alpha value to 0.001 while dragging is taking place. We have re-introducted this concept because UICollectionView sometimes returned nil for cellForItemAtIndexPath in the helper's delegate, after the collection had been reordered. This resulted in a buggy 'sometimes hidden' collection cell whilst dragging.
- Delegate refactoring: I'm currently in the process of updating the delegate protocol to send the helper 'sender' object along as well to makeit easier for 1 class to be delegates for multiple helpers. This is reflected in the current branch and has *BROKEN ALL THE TESTS TEMPORARILY*, so TestApp on this branch won't compile.


Limitations
-----------

Having used this class in a separate project, I have realised that there are several limitations:
- You can't have overlapping source and destination tables
- If you're implementing a subclass of UITableViewCell or UICollectioViewCell you need to override NSCoder methods to encode/decode your cell, so that when the helper archives/unarchives it for duplication it still has all your custom properties. I will provide examples on how to do this for the next merge to dev/master.


Notes on App Store Approval
---------------------------

At the moment this is being used in an in-house app.

I haven't used this helper in an App Store approved project yet - the rearranging functionality is already built into UITableView/UICollectionView s in the form of 'Edit mode', and I have no idea how Apple will respond to this ad-hoc approach to rearranging table/collection views. It might _just_ be a cause for rejection, but who knows.. You can always turn off the helper-provided rearranging functionality and use Edit Mode instead.

Just something to bear in mind.
