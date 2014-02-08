//
//  ItemDetailViewController.m
//  Homepwner
//
//  Created by tony on 13-4-25.
//  Copyright (c) 2013年 tony. All rights reserved.
//

#import "ItemDetailViewController.h"
#import "Possession.h"
#import "ImageStore.h"
#import "PossessionStore.h"
#import "AssetTypePicker.h"

@interface ItemDetailViewController ()

@end

@implementation ItemDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
    @throw [NSException exceptionWithName:NSLocalizedString(@"Wrong", nil) reason:@"Use initForNewItem" userInfo:nil];
    return nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIColor *clr=nil;
    if ([[UIDevice currentDevice] userInterfaceIdiom]==UIUserInterfaceIdiomPad) {
        clr=[UIColor colorWithRed:0.875 green:0.88 blue:0.91 alpha:1];
         
    }else
    {
        clr=[UIColor groupTableViewBackgroundColor];
    }
    [[self view] setBackgroundColor:clr];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.nameField setText:[self.possession possessionName]];
    [self.serialNumberField setText:[self.possession serialNumber]];
    if ([self.possession valueInDollars]) {
        [self.valueField setText:[NSString stringWithFormat:@"%@",[self.possession valueInDollars]]];
    }else
    {
        [self.valueField setText:@"0"];
    }
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [self.dateLabel setText:[dateFormatter stringFromDate:[self.possession dateCreated]]];
    [[self navigationItem] setTitle:[self.possession possessionName]];
    NSString *imageKey=[self.possession imageKey];
    if (imageKey) {
        UIImage *imageToDisplay=[[ImageStore defaultImageStore] imageForKey:imageKey];
        [self.imageView setImage:imageToDisplay];
        
    }else
    {
        [self.imageView setImage:nil];
    }
    NSString *typeLabel=[[self.possession assetType] valueForKey:@"label"];
    if (!typeLabel) {
        typeLabel=NSLocalizedString(@"None", nil);
    }
        [self.assetTypeButton setTitle:[NSString stringWithFormat:@"Type:%@",typeLabel] forState:UIControlStateNormal];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[self view] endEditing:YES];
    [self.possession setPossessionName:[self.nameField text]];
    [self.possession setSerialNumber:[self.serialNumberField text]];
    NSNumber *valueNum=[NSNumber numberWithInt:[[self.valueField text] intValue]];
    [self.possession setValueInDollars:valueNum];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (IBAction)takePicture:(id)sender {
    UIImagePickerController *imagePicker=[[UIImagePickerController alloc] init];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
    }else
    {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }
    [imagePicker setDelegate:self];
    if ([[UIDevice currentDevice] userInterfaceIdiom]==UIUserInterfaceIdiomPad) {
        imagePickerPopover=[[UIPopoverController alloc] initWithContentViewController:imagePicker];
        [imagePickerPopover setDelegate:self];
        [imagePickerPopover presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        
        
    }else
    {
       [self presentViewController:imagePicker animated:YES completion:nil]; 
    }
    
}
-(void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    imagePickerPopover=nil;
}
- (IBAction)backgroundTapped:(id)sender {
    [[self view] endEditing:YES];
}

- (IBAction)deleteImage:(id)sender {
    NSString *imageKey=[self.possession imageKey];
    [[ImageStore defaultImageStore] deleteImageForKey:imageKey];
    [self.imageView setImage:nil];
}
#pragma mark - UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *oldKey=[self.possession imageKey];
    if (oldKey) {
        [[ImageStore defaultImageStore] deleteImageForKey:oldKey];
    }
    UIImage *image=[info objectForKey:UIImagePickerControllerOriginalImage];
    //core foundation获取uuid
    CFUUIDRef newUniqueID=CFUUIDCreate(kCFAllocatorDefault);
    CFStringRef newUniqueIDString=CFUUIDCreateString(kCFAllocatorDefault,newUniqueID);
//    NSString *usd=[NSString stringWithFormat:@"%@",newUniqueIDString];
//    NSLog(@"%@",usd);
    //简单获取uuid
//    NSString *newUniqueIDString1=[[NSProcessInfo processInfo] globallyUniqueString];
//    NSLog(@"%@",newUniqueIDString1);
//    [self.possession setImageKey:newUniqueIDString1];
    
    [self.possession setImageKey:(__bridge NSString*)newUniqueIDString];
    NSLog(@"%@",(__bridge NSString*)newUniqueIDString);
    CFRelease(newUniqueIDString);
    CFRelease(newUniqueID);
    [[ImageStore defaultImageStore] setImage:image forkey:[self.possession imageKey]];
    [self.imageView setImage:image];
    if ([[UIDevice currentDevice] userInterfaceIdiom]==UIUserInterfaceIdiomPad) {
        [imagePickerPopover dismissPopoverAnimated:YES];
        imagePickerPopover=nil;
    }else
    {
       [self dismissViewControllerAnimated:YES completion:nil];
    }
    [self.possession setThumbnailDataFromImage:image];
    
}
#pragma mark - interfaceOrientation
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom]==UIUserInterfaceIdiomPad) {
        return YES;
    }else
    {
        return (toInterfaceOrientation==UIInterfaceOrientationPortrait);
    }
}
-(BOOL)shouldAutorotate
{
    if ([[UIDevice currentDevice] userInterfaceIdiom]==UIUserInterfaceIdiomPad) {
        return YES;
    }else
    {
        return YES;
    }
}
-(NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom]==UIUserInterfaceIdiomPad ) {
        return UIInterfaceOrientationMaskAll;
    }else
    {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    }
}
-(id)initForNewItem:(BOOL)isNew
{
    self=[super initWithNibName:@"ItemDetailViewController" bundle:nil];
    if (self) {
        if (isNew) {
            UIBarButtonItem *doneItem=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(save:)];
            [[self navigationItem] setRightBarButtonItem:doneItem];
            UIBarButtonItem *cancelItem=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
            [[self navigationItem] setLeftBarButtonItem:cancelItem];
            
        }

    }
      return self;
    }
-(IBAction)save:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
    if ([self.delegate respondsToSelector:@selector(itemDetailViewControllerWillDismiss:)]) {
        [self.delegate itemDetailViewControllerWillDismiss:self];
    }
}
-(IBAction)cancel:(id)sender{
    [[PossessionStore defaultStore] removePossession:self.possession];
    [self dismissViewControllerAnimated:YES completion:nil];
    if ([self.delegate respondsToSelector:@selector(itemDetailViewControllerWillDismiss:)]) {
        [self.delegate itemDetailViewControllerWillDismiss:self];
    }

}

- (IBAction)showAssetTypePicker:(id)sender {
    [[self view] endEditing:YES];
    AssetTypePicker *assetTypePicker=[[AssetTypePicker alloc] init];
    [assetTypePicker setPossession:self.possession];
    [[self navigationController] pushViewController:assetTypePicker animated:YES];
}
@end
