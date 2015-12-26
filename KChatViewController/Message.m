//
//  KMessage.m
//  KChatViewController
//
//  Created by Kalpesh Talkar on 26/12/15.
//  Copyright © 2015 Kalpesh Talkar. All rights reserved.
//

#import "Message.h"

@implementation Message

#pragma mark - Instance Methods/Init
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setDefaults];
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)rawMessage {
    self = [super init];
    if (self) {
        [self setDefaults];
        
        if ([rawMessage objectForKey:Message_Sender_Id]) {
            self.senderId = [rawMessage objectForKey:Message_Sender_Id];
        }
        if ([rawMessage objectForKey:Message_Sender_Name]) {
            self.senderName = [rawMessage objectForKey:Message_Sender_Name];
        }
        if ([rawMessage objectForKey:Message_Body]) {
            self.messageBody = [rawMessage objectForKey:Message_Body];
        }
        if ([rawMessage objectForKey:Message_Image_Url]) {
            self.imageUrl = [rawMessage objectForKey:Message_Image_Url];
        }
        if ([rawMessage objectForKey:Message_Date]) {
            self.messageDate = [rawMessage objectForKey:Message_Date];
        }
    }
    return self;
}

#pragma mark - Set Defaults
- (void)setDefaults {
    self.senderId = @"";
    self.senderName = @"";
    self.messageBody = @"";
    self.imageUrl = @"";
    self.image = [UIImage imageNamed:DefaultImage];
    self.messageDate = [NSDate new];
    self.messageType = MessageTypeText;
    self.messageState = MessageStatePending;
}

@end
