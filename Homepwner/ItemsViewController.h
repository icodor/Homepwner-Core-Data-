//
//  ItemsViewController.h
//  Homepwner
//
//  Created by tony on 13-4-23.
//  Copyright (c) 2013年 tony. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemDetailViewController.h"

@interface ItemsViewController : UITableViewController<UITableViewDelegate,UITableViewDataSource,ItemDetailViewControllerDelegate>
{
    IBOutlet UIView *headerView;
}
-(UIView *)headerView;
-(IBAction)addNewPossession:(id)sender;
-(IBAction)toggleEditingMode:(id)sender;
@end
