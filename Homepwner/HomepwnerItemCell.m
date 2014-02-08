//
//  HomepwnerItemCell.m
//  Homepwner
//
//  Created by tony on 13-4-27.
//  Copyright (c) 2013年 tony. All rights reserved.
//

#import "HomepwnerItemCell.h"
#import "Possession.h"
#import "ImageStore.h"
@implementation HomepwnerItemCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        valueLable=[[UILabel alloc] initWithFrame:CGRectZero];
        [[self contentView] addSubview:valueLable];
        nameLable=[[UILabel alloc] initWithFrame:CGRectZero];
        [[self contentView] addSubview:nameLable];
        nameLable.textAlignment=1;
        imageView=[[UIImageView alloc] initWithFrame:CGRectZero];
        [[self contentView] addSubview:imageView];
        [imageView setContentMode:UIViewContentModeCenter];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//layoutSubViews
-(void)layoutSubviews
{
    [super layoutSubviews];
    float inset=5.0;
    CGRect bounds=[[self contentView] bounds];
    float h=bounds.size.height;
    float w=bounds.size.width;
    float valueWidth=40.0;
//    CGRect imageFram=CGRectMake(inset, inset, 40, h-inset*2);
    CGSize thumbnailSize=[Possession thumbnailSize];
    float imageSpace=h-thumbnailSize.height;
    CGRect imageFrame=CGRectMake(inset, imageSpace/2.0, thumbnailSize.width, thumbnailSize.height);
    [imageView setFrame:imageFrame];
    CGRect nameFram=CGRectMake(imageFrame.size.width+imageFrame.origin.x+inset, inset, w-(h+valueWidth+inset*4), h-inset*2);
    [nameLable setFrame:nameFram];
    CGRect valueFrame=CGRectMake(nameFram.size.width+nameFram.origin.x+inset, inset, valueWidth, h-inset*2);
    [valueLable setFrame:valueFrame];
}
-(void)setPossession:(Possession*)possession
{
    NSString *currencySymbol=[[NSLocale currentLocale] objectForKey:NSLocaleCurrencySymbol];
    
    [valueLable setText:[NSString stringWithFormat:@"%@%@",currencySymbol,[possession valueInDollars  ]]];
    [nameLable setText:[possession possessionName]];
//    [imageView setImage:[[ImageStore defaultImageStore] imageForKey:[possession imageKey]]];
    UIImage *tim=[possession thumbnail];
    if (!tim) {
        UIImage *im=[[ImageStore defaultImageStore] imageForKey:[possession imageKey]];
        [possession setThumbnailDataFromImage:im];
    }
    [imageView setImage:[possession thumbnail]];
}
@end
