//
//  MessageTextView.m
//  KChatViewController
//
//  Created by Kalpesh Talkar on 26/12/15.
//  Copyright © 2015 Kalpesh Talkar. All rights reserved.
//

#import "MessageTextView.h"

@implementation MessageTextView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setEditable:false];
    [self setSelectable:true];
    [self setUserInteractionEnabled:true];
    [self setDataDetectorTypes:UIDataDetectorTypeNone];
    [self setShowsHorizontalScrollIndicator:false];
    [self setShowsVerticalScrollIndicator:false];
    [self setScrollEnabled:false];
}

- (void)setSelectedRange:(NSRange)selectedRange {
    // Prevent Text Selection
    [super setSelectedRange:NSMakeRange(NSNotFound, 0)];
}

- (NSRange)selectedRange {
    // Prevent Text Selection
    return NSMakeRange(NSNotFound, NSNotFound);
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    //  Ignore double-tap to prevent copy/define/etc. menu from showing
    if ([gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]]) {
        UITapGestureRecognizer *tap = (UITapGestureRecognizer *)gestureRecognizer;
        if (tap.numberOfTapsRequired == 2) {
            return false;
        }
    }
    
    return true;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    //  Ignore double-tap to prevent copy/define/etc. menu from showing
    if ([gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]]) {
        UITapGestureRecognizer *tap = (UITapGestureRecognizer *)gestureRecognizer;
        if (tap.numberOfTapsRequired == 2) {
            return false;
        }
    }
    
    return true;
}

@end
