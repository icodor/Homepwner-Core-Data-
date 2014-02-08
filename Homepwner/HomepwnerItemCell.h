//
//  HomepwnerItemCell.h
//  Homepwner
//
//  Created by tony on 13-4-27.
//  Copyright (c) 2013年 tony. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Possession;
@interface HomepwnerItemCell : UITableViewCell
{
 UIImageView *imageView;
 UILabel *nameLable;
 UILabel *valueLable;
}
-(void)setPossession:(Possession*)possession;
@end
