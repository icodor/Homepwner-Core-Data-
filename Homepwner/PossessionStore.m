//
//  PossessionStore.m
//  Homepwner
//
//  Created by tony on 13-4-23.
//  Copyright (c) 2013年 tony. All rights reserved.
//

#import "PossessionStore.h"
#import "Possession.h"
#import "ImageStore.h"

static PossessionStore *defaultStore=nil;

@implementation PossessionStore
+(PossessionStore *)defaultStore
{
    if (!defaultStore) {
        defaultStore=[[super allocWithZone:NULL] init];
        
    }
    return defaultStore;
}
+(id)allocWithZone:(NSZone *)zone
{
    return [self defaultStore];
}
-(id)init
{
    if (defaultStore) {
        return defaultStore;
    }
//    self=[super init];
//    if (self) {
//        Possessions1=[[NSMutableArray alloc] init];
//        Possessions2=[[NSMutableArray alloc] init];
//    }
    self=[super init];
//    if (self) {
//        NSString *path=[self possessionArchivePath ];
//        possessions=[NSKeyedUnarchiver unarchiveObjectWithFile:path];
//        
//    }
//    if (!possessions) {
//        possessions=[[NSMutableArray alloc] init];
//    }
    model=[NSManagedObjectModel mergedModelFromBundles:nil];
    NSLog(@"model=%@",model);
    NSPersistentStoreCoordinator *psc=[[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    NSString *path=pathInDocumentDirectory(@"store.data");
    NSURL *storeURL=[NSURL fileURLWithPath:path];
    NSError *error=nil;
    if (![psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        [NSException raise:@"Open failed" format:@"Reason:%@",[error localizedDescription]];
    }
    context=[[NSManagedObjectContext alloc] init];
    [context setPersistentStoreCoordinator:psc];
    return self;
}
-(NSMutableArray *)possessions
{
    [self fetchPossessionsIfNecessary];
    return possessions;
    NSLog(@"%@",possessions);
}
//-(NSMutableArray *)Possessions2
//{
//    [self fetchPossessionsIfNecessary];
//    return Possessions2;
//}

-(Possession *)createPossession
{
    
//    [self fetchPossessionsIfNecessary];
//    Possession *p=[Possession randomPossession];
//    [possessions addObject:p];
//    return p;
    double order;
    if ([possessions count]==0) {
        order=1.0;
    }else
    {
        order=[[[possessions lastObject] orderingValue] doubleValue]+1.0;
    }
    NSLog(@"Adding after %d items.order=%2.f",[possessions count],order);
    Possession *p=[NSEntityDescription insertNewObjectForEntityForName:@"Possession" inManagedObjectContext:context];
    [p setOrderingValue:[NSNumber numberWithDouble:order]];
    [possessions addObject:p];
    return p;

}
-(void)removePossession:(Possession *)p
{
//    if (p.valueInDollars>50) {
//        [Possessions1 removeObjectIdenticalTo:p];
//    }else{
//        [Possessions2 removeObjectIdenticalTo:p];
//    }
    NSString *key=[p imageKey];
    [[ImageStore defaultImageStore] deleteImageForKey:key];
    [context deleteObject:p];
    [possessions removeObject:p];
}
-(void)movePossessionAtIndex:(int)from toIndex:(int)to
{
    if (from==to) {
        return;
    }
    Possession *p=[possessions objectAtIndex:from];
    [possessions removeObjectAtIndex:from];
    [possessions insertObject:p atIndex:to];
    double lowerBound=0.0;
    if (to>0) {
        lowerBound=[[[possessions objectAtIndex:to-1] orderingValue]doubleValue];
        }else
        {
            lowerBound=[[[possessions objectAtIndex:1] orderingValue] doubleValue]-2.0;
        }
    double upperBound=0.0;
    if (to<[possessions count]-1) {
        upperBound=[[[possessions objectAtIndex:to+1] orderingValue] doubleValue];
    }else
    {
        upperBound=[[[possessions objectAtIndex:to-1] orderingValue] doubleValue]+2.0;
    }
    NSNumber *n=[NSNumber numberWithDouble:(lowerBound+upperBound)/2.0];
    NSLog(@"moving to order %@", n);
    [p setOrderingValue:n];
}
-(NSString*)possessionArchivePath
{
    return pathInDocumentDirectory(@"possessions.data");
}
-(BOOL)saveChanges
{
    
//        return [NSKeyedArchiver archiveRootObject:possessions toFile:[self possessionArchivePath] ];
//    NSLog(@"save:%@",possessions);
    
    NSError *err=nil;
    BOOL successful=[context save:&err];
    if (!successful) {
        NSLog(@"Error saving:%@",[err localizedDescription]);
    }
    return successful;
//    return [NSKeyedArchiver archiveRootObject:Possessions1 toFile:[self possessionArchivePath] ];
    
}
-(void)fetchPossessionsIfNecessary
{
//    if (!Possessions1) {
//        NSString *path=[self possessionArchivePath];
//        Possessions1=[NSKeyedUnarchiver unarchiveObjectWithFile:path];
//    }
//    if (!Possessions1) {
//        Possessions1=[[NSMutableArray alloc] init];
//    }
//    if (!Possessions2) {
//        NSString *path=[self possessionArchivePath];
//        Possessions2=[NSKeyedUnarchiver unarchiveObjectWithFile:path];
//    }
//    if (!Possessions2) {
//        Possessions2=[[NSMutableArray alloc] init];
//    }
//    if (!possessions) {
//        NSString*path=[self possessionArchivePath];
//        
//        possessions=[NSKeyedUnarchiver unarchiveObjectWithFile:path];
//    }
//    NSString*path=[self possessionArchivePath];
//    
//    possessions=[NSKeyedUnarchiver unarchiveObjectWithFile:path];
    
//    Possession *p;
//    for (int i=0; i<[pos count]; i++) {
//        p=[pos objectAtIndex:i];
//        NSLog(@"%@",p);
//        if (p.valueInDollars>50) {
//            [Possessions1 addObject:p];
//        }else
//        {
//            [Possessions2 addObject:p];
//        }
//    }
//    if (!possessions) {
//        possessions=[[NSMutableArray alloc] init];
//    }
//    if (!Possessions2) {
//        Possessions2=[[NSMutableArray alloc] init];
//    }
    if (!possessions) {
        NSFetchRequest *request=[[NSFetchRequest alloc] init];
        NSEntityDescription *e=[[model entitiesByName] objectForKey:@"Possession"];
        [request setEntity:e];
        NSSortDescriptor *sd=[NSSortDescriptor sortDescriptorWithKey:@"orderingValue" ascending:YES];
        [request setSortDescriptors:[NSArray arrayWithObject:sd]];
        NSError *error;
        NSArray *result=[context executeFetchRequest:request error:&error];
        if (!result) {
            [ NSException raise:@"Fetch failed" format:@"Reason:%@",[error localizedDescription] ];
        }
        possessions=[[NSMutableArray alloc] initWithArray:result];
    }

}
-(NSArray *)allAssetTypes
{
    if (!allAssetTypes) {
        NSFetchRequest *request=[[NSFetchRequest alloc] init];
        NSEntityDescription *e=[[model entitiesByName] objectForKey:@"AssetType"];
        [request setEntity:e];
        NSError *error;
        NSArray *result=[context executeFetchRequest:request error:&error];
        if (!result) {
            [NSException raise:@"Fetch failed" format:@"Reason:%@",[error localizedDescription]];
        }
        allAssetTypes=[result mutableCopy];
    }
    if ([allAssetTypes count]==0) {
        NSManagedObject *type;
        type=[NSEntityDescription insertNewObjectForEntityForName:@"AssetType" inManagedObjectContext:context];
        [type setValue:@"Furniture" forKey:@"label"];
        [allAssetTypes addObject:type];
        type=[NSEntityDescription insertNewObjectForEntityForName:@"AssetType" inManagedObjectContext:context];
        [type setValue:@"Jewelry" forKey:@"label"];
        [allAssetTypes addObject:type];
        type=[NSEntityDescription insertNewObjectForEntityForName:@"AssetType" inManagedObjectContext:context];
        [type setValue:@"Electronics" forKey:@"label"];
        [allAssetTypes addObject:type];
    }
    return allAssetTypes;
}
@end
