//
//  IncommingMessageCell.m
//  KChatViewController
//
//  Created by Kalpesh Talkar on 26/12/15.
//  Copyright © 2015 Kalpesh Talkar. All rights reserved.
//

#import "IncommingMessageCell.h"

@implementation IncommingMessageCell

- (void)awakeFromNib {
    // Initialization code
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Sender Name Methods
- (void)showSenderName:(BOOL)flag {
    if (flag) {
        [self.senderNameLabel setHidden:false];
        [self.messageTextViewTopConstraint setConstant:Message_Top_If_Name_Shown];
    } else {
        [self.senderNameLabel setHidden:true];
        [self.messageTextViewTopConstraint setConstant:Message_Top_If_Name_Hidden];
    }
    [self layoutIfNeeded];
}

#pragma mark - Header Configuration
- (void)showHeader:(BOOL)flag {
    if (flag) {
        [self.headerLabel setHidden:false];
        [self.senderAvatarTopConstraint setConstant:Avatar_Top_If_Header_Shown];
    } else {
        [self.headerLabel setHidden:true];
        [self.senderAvatarTopConstraint setConstant:Avatar_Top_If_Header_Hidden];
    }
    [self layoutIfNeeded];
}

- (void)setHeaderTitle:(NSString *)title {
    [self.headerLabel setText:[NSString stringWithFormat:@" %@ ",title]];
    [self configureHeader];
}

#pragma mark - Set Message Data
- (void)setMessage:(Message *)message forIndexPath:(NSIndexPath *)indexPath {
    self.indexPath = indexPath;
    [self configureView];
    self.messageTextView.text = message.messageBody;
}

#pragma mark - Configure Cell
- (void)configureView {
    // Margin
    CGFloat rightMargin = self.frame.size.width*0.15;
    [self.messageContentViewTrailingConstraint setConstant:rightMargin];
    [self layoutIfNeeded];
    
    [self configureHeader];
    
    self.senderAvatarButton.layer.cornerRadius = self.senderAvatarButton.frame.size.width/2;
    self.messageContentTailView.layer.cornerRadius = 4;
    self.messageContentView.layer.cornerRadius = 5;
    
    [self.senderNameLabel setBackgroundColor:[UIColor clearColor]];
    [self.senderNameLabel setTextColor:[UIColor darkGrayColor]];
    
    [self.messageTextView setDataDetectorTypes:UIDataDetectorTypeAll];
    [self.messageTextView setScrollEnabled:false];
    [self.messageTextView setEditable:false];
    [self.messageTextView setBackgroundColor:[UIColor clearColor]];
    [self.messageTextView setTextColor:[UIColor darkGrayColor]];
    
    [self.timeLabel setBackgroundColor:[UIColor clearColor]];
    [self.timeLabel setTextColor:[UIColor grayColor]];
}

- (void)configureHeader {
    [self.headerLabel setClipsToBounds:true];
    self.headerLabel.layer.cornerRadius = 3;
}

#pragma mark - Cell Action Methods


@end
