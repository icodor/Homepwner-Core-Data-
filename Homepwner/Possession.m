//
//  Possession.m
//  Homepwner
//
//  Created by tony on 13-5-3.
//  Copyright (c) 2013年 tony. All rights reserved.
//

#import "Possession.h"


@implementation Possession

@dynamic possessionName;
@dynamic serialNumber;
@dynamic valueInDollars;
@dynamic dateCreated;
@dynamic imageKey;
@dynamic thumbnailData;
@dynamic thumbnail;
@dynamic orderingValue;
@dynamic assetType;


-(void)setThumbnailDataFromImage:(UIImage *)image
{
    CGSize origImageSize=[image size];
    CGRect newRect;
    newRect.origin=CGPointZero;
    newRect.size=[[self class] thumbnailSize];
    float ratio=MAX(newRect.size.width/origImageSize.width, newRect.size.height/origImageSize.height);
    UIGraphicsBeginImageContext(newRect.size);
    UIBezierPath *path=[UIBezierPath bezierPathWithRoundedRect:newRect cornerRadius:5.0];
    [path addClip];
    CGRect projectRect;
    projectRect.size.width=ratio*origImageSize.width;
    projectRect.size.height=ratio*origImageSize.height;
    projectRect.origin.x=(newRect.size.width-projectRect.size.width)/2.0;
    projectRect.origin.y=(newRect.size.height-projectRect.size.height)/2.0;
    [image drawInRect:projectRect];
    UIImage *small=UIGraphicsGetImageFromCurrentImageContext();
    [self setThumbnail:small];
    //JPEGData
    NSData *data=UIImageJPEGRepresentation(small, 1);
    [self setThumbnailData:data];
    UIGraphicsEndImageContext();
    
    
}
+(CGSize)thumbnailSize
{
    return CGSizeMake(40, 40);
}
//设置thumbnail
-(void)awakeFromFetch
{
    [super awakeFromFetch];
    UIImage *tn=[UIImage imageWithData:[self thumbnailData]];
    [self setPrimitiveValue:tn forKey:@"thumbnail"];
}
-(void)awakeFromInsert
{
    [super awakeFromInsert];
    [self setDateCreated:[NSDate date]];
}
@end
