//
//  ImageStore.h
//  Homepwner
//
//  Created by tony on 13-4-25.
//  Copyright (c) 2013年 tony. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageStore : NSObject
{
    NSMutableDictionary *dictionary;
}
+(ImageStore *)defaultImageStore;
-(void)setImage:(UIImage *)i  forkey:(NSString *)s;
-(UIImage *)imageForKey:(NSString*)s;
-(void)deleteImageForKey:(NSString *)s;
@end
