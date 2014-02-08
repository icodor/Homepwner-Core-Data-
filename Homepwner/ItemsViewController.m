//
//  ItemsViewController.m
//  Homepwner
//
//  Created by tony on 13-4-23.
//  Copyright (c) 2013年 tony. All rights reserved.
//

#import "ItemsViewController.h"
#import "Possession.h"
#import "PossessionStore.h"
#import "HPNavigationViewController.h"
#import "HomepwnerItemCell.h"

@interface ItemsViewController ()

@end
NSMutableArray *possessions;
//NSMutableArray *Possessions2;
@implementation ItemsViewController
-(id)init
{
    self=[super initWithStyle:UITableViewStyleGrouped];
    //增加10个possession随机实例对象
    if (self) {
//        for (int i=0; i<10; i++) {
//            [[PossessionStore defaultStore] createPossession];
//        }
//        possessions=[[PossessionStore defaultStore] possessions];
//        NSLog(@"possessions:%@",possessions);
//        Possessions2=[[PossessionStore defaultStore] Possessions2];
        UITabBarItem *tbi=[self tabBarItem];
//        [tbi setTitle:@"Pwner"];
        [tbi setTitle:NSLocalizedString(@"Pwner", nil)];
        UIImage *i=[UIImage imageNamed:@"Time.png"];
        [tbi setImage:i];
        UIBarButtonItem *bbi=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewPossession:)];
        [[self navigationItem] setRightBarButtonItem:bbi];
        [[self navigationItem] setTitle:@"HomePwner"];
        [[self navigationItem] setLeftBarButtonItem:[self editButtonItem]];
        
    }
    
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[self tableView] reloadData];
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
//-(void)viewWillDisappear:(BOOL)animated
//{
//    [[PossessionStore defaultStore] saveChanges];
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
//    if (section==0) {
//        return [ Possessions1 count];
//
//    }else
//    {
//        return [ Possessions2 count];
//    }
    return [[[PossessionStore defaultStore] possessions] count];
//    return 10;
//    NSLog(@"%d",[possessions count]);
    }

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
//    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//    }
//
//    Possession *p=[[[PossessionStore defaultStore] possessions] objectAtIndex:[indexPath row]];
//           [[cell textLabel] setText:[p description]];
    //自定义cell
    HomepwnerItemCell *cell=(HomepwnerItemCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell=[[HomepwnerItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    Possession *p=[[[PossessionStore defaultStore] possessions] objectAtIndex:[indexPath row]];
    [cell setPossession:p];
    
        return cell;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    Possession *p;
    if (editingStyle==UITableViewCellEditingStyleDelete) {
//        if (indexPath.section==0) {
//            p=[Possessions1 objectAtIndex:indexPath.row];
//            NSLog(@"%@",[p description]);
//        }else{
//            p=[Possessions2 objectAtIndex:indexPath.row];
//        }
        p=[[[PossessionStore defaultStore] possessions] objectAtIndex:indexPath.row];
        PossessionStore *ps=[PossessionStore defaultStore];
        [ps removePossession:p];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }
}
-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
//    Possession *p=[[[PossessionStore defaultStore] possessions] objectAtIndex:sourceIndexPath.row];
//                [[[PossessionStore defaultStore] possessions] removeObjectAtIndex:sourceIndexPath.row];
//               [[[PossessionStore defaultStore] possessions] insertObject:p atIndex:destinationIndexPath.row];
    [[PossessionStore defaultStore] movePossessionAtIndex:sourceIndexPath.row  toIndex:destinationIndexPath.row];
    
    
//    if (sourceIndexPath.section==destinationIndexPath.section) {
//        if (sourceIndexPath.section==0) {
//            Possession *p=[Possessions1 objectAtIndex:sourceIndexPath.row];
//            [Possessions1 removeObjectAtIndex:sourceIndexPath.row];
//            [Possessions1 insertObject:p atIndex:destinationIndexPath.row];
//        }else
//        {
//            Possession *p=[Possessions2 objectAtIndex:sourceIndexPath.row];
//            [Possessions2 removeObjectAtIndex:sourceIndexPath.row];
//            [Possessions2 insertObject:p atIndex:destinationIndexPath.row];
//        }
//    }else
//    {
//        if (sourceIndexPath.section==0) {
//            Possession *p=[Possessions1 objectAtIndex:sourceIndexPath.row];
//            [Possessions1 removeObjectAtIndex:sourceIndexPath.row];
//            [Possessions2 insertObject:p atIndex:destinationIndexPath.row];
//        }else
//        {
//            Possession *p=[Possessions2 objectAtIndex:sourceIndexPath.row];
//            [Possessions2 removeObjectAtIndex:sourceIndexPath.row];
//            [Possessions1 insertObject:p atIndex:destinationIndexPath.row];
//        }
//    }
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
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ItemDetailViewController *detailViewContrller=[[ItemDetailViewController alloc] initForNewItem:NO];
    Possession *p;
//    if (indexPath.section==0) {
//        p=[Possessions1 objectAtIndex:indexPath.row];
//    }else
//    {
//        p=[Possessions2 objectAtIndex:indexPath.row];
//    }
    p=[[[PossessionStore defaultStore] possessions] objectAtIndex:indexPath.row];
    detailViewContrller.possession=p;
    
    [[self navigationController] pushViewController:detailViewContrller animated:YES];
}
//表头视图
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    if (section==0) {
//        return [self headerView];
//    }else
//    {
//        return nil;
//    }
//}
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    if (section==0) {
//        return [[self headerView] bounds].size.height;
//    }else
//    {
//        return 0.0;
//    }
//    
//}
#pragma mark --headerView
-(UIView *)headerView
{
    //don't load headerView
    if (!headerView) {
        [[NSBundle mainBundle] loadNibNamed:@"HeaderView" owner:self options:nil];
            }
    return headerView;

}
-(IBAction)addNewPossession:(id)sender
{
    Possession*newPossession= [[PossessionStore defaultStore] createPossession];
    
    ItemDetailViewController *detailViewController=[[ItemDetailViewController alloc] initForNewItem:YES];
    [detailViewController setDelegate:self];
    [detailViewController setPossession:newPossession];
    HPNavigationViewController *navController=[[HPNavigationViewController alloc] initWithRootViewController:detailViewController];
    [navController setModalPresentationStyle:UIModalPresentationFormSheet];
    [navController setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [self presentViewController:navController animated:YES completion:nil];
    
    //reloadData
    [[self tableView] reloadData];
}
-(IBAction)toggleEditingMode:(id)sender
{
    if ([self isEditing]) {
        [sender setTitle:@"Edit" forState:UIControlStateNormal];
        [self setEditing:NO animated:YES];
    }else
    {
        [sender setTitle:@"Done" forState:UIControlStateNormal];
        [self setEditing:YES animated:YES];
    }
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom]==UIUserInterfaceIdiomPad) {
        return YES;
    }else
    {
        return (toInterfaceOrientation==UIInterfaceOrientationPortrait);
    }
}
- (BOOL)shouldAutorotate
{
    if ([[UIDevice currentDevice] userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
    {
        return NO;
    }
    return YES;
}
- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom]==UIUserInterfaceIdiomPhone) {
        
        return UIInterfaceOrientationMaskPortrait;
    }
    
    return UIInterfaceOrientationMaskAll;
}
-(void)itemDetailViewControllerWillDismiss:(ItemDetailViewController *)vc
{
    [[self tableView] reloadData];
}
@end
