//
//  ViewController.m
//  KChatViewController
//
//  Created by Kalpesh Talkar on 25/12/15.
//  Copyright © 2015 Kalpesh Talkar. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - Life Cycle Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"Chat Template"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigate To Chat View Controller
- (IBAction)openChatViewController:(id)sender {
    ChatViewController *chatVC = [MainStoryboard instantiateViewControllerWithIdentifier:ChatVC_Id];
    [self.navigationController pushViewController:chatVC animated:true];
}

@end
