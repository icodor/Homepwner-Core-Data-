//
//  ItemDetailViewController.h
//  Homepwner
//
//  Created by tony on 13-4-25.
//  Copyright (c) 2013年 tony. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ItemDetailViewController;
@protocol ItemDetailViewControllerDelegate <NSObject>

-(void)itemDetailViewControllerWillDismiss:(ItemDetailViewController *)vc;


@end
@class Possession;
@interface ItemDetailViewController : UIViewController<UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationBarDelegate,UIPopoverControllerDelegate>
{
    UIPopoverController *imagePickerPopover;
}
@property (strong, nonatomic) IBOutlet UITextField *nameField;
@property (strong, nonatomic) IBOutlet UITextField *serialNumberField;
@property (strong, nonatomic) IBOutlet UITextField *valueField;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIButton *assetTypeButton;
@property (nonatomic, strong) Possession *possession;
@property (nonatomic, assign)id <ItemDetailViewControllerDelegate> delegate;
- (IBAction)takePicture:(id)sender;
- (IBAction)backgroundTapped:(id)sender;
- (IBAction)deleteImage:(id)sender;
//Modal View Controllers
-(id)initForNewItem:(BOOL)isNew;
-(IBAction)save:(id)sender;
-(IBAction)cancel:(id)sender;
- (IBAction)showAssetTypePicker:(id)sender;

@end
