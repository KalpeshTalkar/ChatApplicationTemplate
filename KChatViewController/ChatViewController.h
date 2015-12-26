//
//  KChatViewController.h
//  KChatViewController
//
//  Created by Kalpesh Talkar on 25/12/15.
//  Copyright © 2015 Kalpesh Talkar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IncommingMessageCell.h"

#define kInputToolbarCornerRadius 5.0f
#define kInputToolbarBottomConstraint 8
#define kSendButtonBottomConstraint 6
#define kAnimationDuration 0.2
#define kDefaultMaxToolbarHeight 150

#define AttachmentIcon @"attach_icon"
#define SendMessageIcon @"send_message_icon"

@interface ChatViewController : UIViewController <UITextViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *messagesTableView;
@property (weak, nonatomic) IBOutlet UIView *inputToolbar;
@property (weak, nonatomic) IBOutlet UIButton *attachmentButton;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) IBOutlet UITextView *inputTextView;
@property (weak, nonatomic) IBOutlet UILabel *inputPlaceHolderLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *inputToolbarHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *inputToolbarBottomConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sendButtonBottomConstraint;

@property (strong, nonatomic) NSMutableArray *messageArray;
@property CGFloat maxInputToolbarHeight;

@end
