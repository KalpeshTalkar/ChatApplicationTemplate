//
//  KMessage.h
//  KChatViewController
//
//  Created by Kalpesh Talkar on 26/12/15.
//  Copyright © 2015 Kalpesh Talkar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// Default Image
#define DefaultImage @"default_message_image"

// Dictionary Keys
#define Message_Sender_Id @"senderId"
#define Message_Sender_Name @"senderName"
#define Message_Body @"messageBody"
#define Message_Image_Url @"imageUrl"
#define Message_Date @"messageDate"

// Message Type
typedef NS_ENUM(NSInteger, MessageType) {
    MessageTypeText,
    MessageTypeImage,
    MessageTypeImageWithText,
    MessageTypeVideo,
    MessageTypeAudio
};

// Message Status
typedef NS_ENUM(NSInteger, MessageState) {
    MessageStatePending,
    MessageStateFailed,
    MessageStateSent
};

@interface Message : NSObject

@property (strong, nonatomic) NSString *senderId;
@property (strong, nonatomic) NSString *senderName;
@property (strong, nonatomic) NSString *messageBody;
@property (strong, nonatomic) NSString *imageUrl;
@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) NSDate *messageDate;
@property (assign, nonatomic) MessageType *messageType;
@property (assign, nonatomic) MessageState *messageState;

- (instancetype)init;
- (instancetype)initWithDictionary:(NSDictionary *)rawMessage;

@end
