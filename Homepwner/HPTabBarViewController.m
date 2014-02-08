//
//  HPTabBarViewController.m
//  Homepwner
//
//  Created by tony  on 13-4-25.
//  Copyright (c) 2013年 tony. All rights reserved.
//

#import "HPTabBarViewController.h"

@interface HPTabBarViewController ()

@end

@implementation HPTabBarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - interfaceOrientation
//-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
//{
//    if ([[UIDevice currentDevice] userInterfaceIdiom]==UIUserInterfaceIdiomPad) {
//        return YES;
//    }else
//    {
//        return (toInterfaceOrientation==UIInterfaceOrientationPortrait);
//    }
//}
//-(BOOL)shouldAutorotate
//{
//    if ([[UIDevice currentDevice] userInterfaceIdiom]==UIUserInterfaceIdiomPad) {
//        return YES;
//    }else
//    {
//        return NO;
//    }
//}
//-(NSUInteger)supportedInterfaceOrientations
//{
//    if ([[UIDevice currentDevice] userInterfaceIdiom]==UIUserInterfaceIdiomPad ) {
//        return UIInterfaceOrientationMaskAll;
//    }else
//    {
//        return UIInterfaceOrientationMaskPortrait;
//    }
//}
#pragma mark - 屏幕旋转
- (BOOL)shouldAutorotate
{
    return self.selectedViewController.shouldAutorotate;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return self.selectedViewController.supportedInterfaceOrientations;
}

@end
