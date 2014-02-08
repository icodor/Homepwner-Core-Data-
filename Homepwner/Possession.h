//
//  Possession.h
//  Homepwner
//
//  Created by tony on 13-5-3.
//  Copyright (c) 2013年 tony. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Possession : NSManagedObject

@property (nonatomic, retain) NSString * possessionName;
@property (nonatomic, retain) NSString * serialNumber;
@property (nonatomic, retain) NSNumber * valueInDollars;
@property (nonatomic, retain) NSDate * dateCreated;
@property (nonatomic, retain) NSString * imageKey;
@property (nonatomic, retain) NSData * thumbnailData;
@property (nonatomic, retain) UIImage * thumbnail;
@property (nonatomic, retain) NSNumber * orderingValue;
@property (nonatomic, retain) NSManagedObject *assetType;
+(CGSize)thumbnailSize;

-(void)setThumbnailDataFromImage:(UIImage*)image;
@end
