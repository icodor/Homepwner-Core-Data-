//
//  ImageStore.m
//  Homepwner
//
//  Created by tony on 13-4-25.
//  Copyright (c) 2013年 tony. All rights reserved.
//

#import "ImageStore.h"
static ImageStore *defaultImageStore=nil;
@implementation ImageStore
+(id)allocWithZone:(NSZone *)zone
{
    return [self defaultImageStore];
}
+(ImageStore *)defaultImageStore
{
    if (!defaultImageStore) {
        defaultImageStore=[[super allocWithZone:NULL] init];
    }
    return defaultImageStore;
}
-(id)init
{
    if (defaultImageStore) {
        return defaultImageStore;   
    }
    self=[super init];
    if (self) {
        dictionary=[[NSMutableDictionary alloc] init];
    }
    NSNotificationCenter *nc=[NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(clearCache:) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    return self;
}
-(void)setImage:(UIImage *)i  forkey:(NSString *)s
{
    [dictionary setObject:i forKey:s];
    NSString *path=pathInDocumentDirectory(s);
    NSData *d=UIImageJPEGRepresentation(i, 1);
    [d writeToFile:path atomically:YES];
}
-(void)deleteImageForKey:(NSString *)s
{
    if (!s) {
        return;
    }
    [dictionary removeObjectForKey:s];
    NSString *path=pathInDocumentDirectory(s);
    [[NSFileManager defaultManager] removeItemAtPath:path error:NULL];
}
-(UIImage *)imageForKey:(NSString*)s
{
//    return [dictionary objectForKey:s];
    UIImage *result=[dictionary objectForKey:s];
    if (!result) {
        result=[UIImage imageWithContentsOfFile:pathInDocumentDirectory(s)];
        if (result) {
            [dictionary setObject:result forKey:s];
        }else
            NSLog(@"Error:unable to find %@",pathInDocumentDirectory(s));
    }
    return result;
}
-(void)clearCache:(NSNotification*)note
{
    NSLog(@"flushing %d images out of the cache",[dictionary count]);
    [dictionary removeAllObjects];
}
@end
