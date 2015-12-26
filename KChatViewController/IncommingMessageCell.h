//
//  IncommingMessageCell.h
//  KChatViewController
//
//  Created by Kalpesh Talkar on 26/12/15.
//  Copyright © 2015 Kalpesh Talkar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Message.h"
#import "MessageTextView.h"


@interface IncommingMessageCell : UITableViewCell

#define Avatar_Top_If_Header_Hidden 8
#define Avatar_Top_If_Header_Shown 37
#define Message_Top_If_Name_Hidden 0
#define Message_Top_If_Name_Shown 15

@property (weak, nonatomic) IBOutlet UILabel *headerLabel;
@property (weak, nonatomic) IBOutlet UIButton *senderAvatarButton;
@property (weak, nonatomic) IBOutlet UIView *messageContentTailView;
@property (weak, nonatomic) IBOutlet UIView *messageContentView;
@property (weak, nonatomic) IBOutlet UILabel *senderNameLabel;
@property (weak, nonatomic) IBOutlet MessageTextView *messageTextView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *messageContentViewTrailingConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *senderAvatarTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *messageTextViewTopConstraint;

@property (strong, nonatomic) NSIndexPath *indexPath;

- (void)showSenderName:(BOOL)flag;
- (void)showHeader:(BOOL)flag;
- (void)setHeaderTitle:(NSString *)title;
- (void)setMessage:(Message *)message forIndexPath:(NSIndexPath *)indexPath;

@end
