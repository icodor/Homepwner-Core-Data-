//
//  AssetTypePicker.m
//  Homepwner
//
//  Created by tony on 13-5-3.
//  Copyright (c) 2013年 tony. All rights reserved.
//

#import "AssetTypePicker.h"
#import "PossessionStore.h"

@interface AssetTypePicker ()

@end

@implementation AssetTypePicker
@synthesize possession;
-(id)init
{
    return [super initWithStyle:UITableViewStyleGrouped];
}
- (id)initWithStyle:(UITableViewStyle)style
{
    return [self init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[PossessionStore defaultStore] allAssetTypes] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell2";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        NSArray *allAssets=[[PossessionStore defaultStore] allAssetTypes];
        NSManagedObject *assetType=[allAssets objectAtIndex:indexPath.row];
        NSString *assetLabel=[assetType valueForKey:@"label"];
        [[cell textLabel] setText:assetLabel];
        if (assetType==[possession assetType]) {
            [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
        }else
        {
            [cell setAccessoryType:UITableViewCellAccessoryNone];
        }
    }
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    NSArray *allAssets=[[PossessionStore defaultStore] allAssetTypes];
    NSManagedObject *assetType=[allAssets objectAtIndex:indexPath.row];
    [possession setAssetType:assetType];
    [[self navigationController] popViewControllerAnimated:YES];
}

@end
