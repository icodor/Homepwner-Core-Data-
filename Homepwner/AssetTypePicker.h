//
//  AssetTypePicker.h
//  Homepwner
//
//  Created by tony on 13-5-3.
//  Copyright (c) 2013年 tony. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Possession.h"

@interface AssetTypePicker : UITableViewController
{
    Possession *possession;
}
@property (nonatomic,retain) Possession *possession;
@end
