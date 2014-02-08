//
//  PossessionStore.h
//  Homepwner
//
//  Created by tony on 13-4-23.
//  Copyright (c) 2013年 tony. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Possession;
@interface PossessionStore : NSObject
{
    NSMutableArray *possessions;
//    NSMutableArray *Possessions2;
    NSMutableArray *allAssetTypes;
    NSManagedObjectContext *context;
    NSManagedObjectModel *model;
}
+(PossessionStore *)defaultStore;
-(NSMutableArray *)possessions;
//-(NSArray *)Possessions2;
-(Possession *)createPossession;
-(void)removePossession:(Possession *)p;
-(void)movePossessionAtIndex:(int)from toIndex:(int)to;
-(NSString*)possessionArchivePath;
-(BOOL)saveChanges;
-(void)fetchPossessionsIfNecessary;
#pragma mark Asset types
-(NSArray*)allAssetTypes;

@end
