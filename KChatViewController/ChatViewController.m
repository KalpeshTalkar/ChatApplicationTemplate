//
//  KChatViewController.m
//  KChatViewController
//
//  Created by Kalpesh Talkar on 25/12/15.
//  Copyright © 2015 Kalpesh Talkar. All rights reserved.
//

#import "ChatViewController.h"

@interface ChatViewController ()

@end

@implementation ChatViewController

#pragma mark - Life Cycle Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureMessagesTableView];
    [self configureInputToolbar];
    [self loadMessages];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self addObservers];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self removeObservers];
}

#pragma mark - Configure Messages Table
- (void)configureMessagesTableView {
    [self.messagesTableView setKeyboardDismissMode:UIScrollViewKeyboardDismissModeInteractive];
    [self.messagesTableView setBackgroundColor:[UIColor clearColor]];
    
    // Register Cells
    [self.messagesTableView registerNib:[UINib nibWithNibName:NSStringFromClass([IncommingMessageCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([IncommingMessageCell class])];
    
    // Remove Extra Lines and Seperator
    [self.messagesTableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [self.messagesTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    // Data Source & Delegate
    [self.messagesTableView setDataSource:self];
    [self.messagesTableView setDelegate:self];
    
    [self.messagesTableView reloadData];
}

#pragma mark - Configure Input Toolbar
- (void)configureInputToolbar {
    // Placeholder Label
    [self.inputPlaceHolderLabel setUserInteractionEnabled:false];
    
    // Attachment Button
    [self.attachmentButton setTintColor:[UIColor darkGrayColor]];
    self.attachmentButton.backgroundColor = [UIColor clearColor];
    [self.attachmentButton setImage:[UIImage imageNamed:AttachmentIcon] forState:UIControlStateNormal];
    
    // Send Button
    self.sendButton.backgroundColor = [UIColor clearColor];
    self.sendButton.layer.cornerRadius = self.sendButton.frame.size.width/2;
    [self.sendButton setBackgroundImage:[UIImage imageNamed:SendMessageIcon] forState:UIControlStateNormal];
    self.sendButton.layer.masksToBounds = false;
    self.sendButton.layer.shadowOffset = CGSizeMake(0, 0);
    self.sendButton.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.sendButton.layer.shadowOpacity = 0.5;
    
    // Set Maximum Input Toolbar Height
    self.maxInputToolbarHeight = kDefaultMaxToolbarHeight;
    
    // Input Toolbar View
    self.inputToolbar.layer.masksToBounds = false;
    self.inputToolbar.layer.cornerRadius = kInputToolbarCornerRadius;
    self.inputToolbar.layer.shadowRadius = kInputToolbarCornerRadius;
    self.inputToolbar.layer.shadowOffset = CGSizeMake(0, 0);
    self.inputToolbar.layer.shadowColor = [[UIColor grayColor] CGColor];
    self.inputToolbar.layer.shadowOpacity = 0.2;
    
    // Input TextView
    [self.inputTextView setDelegate:self];
    
    // Prepare ChatViewController
    [self enableDisableSendButton];
    [self shoHidePlaceholder];
}

#pragma mark - Load MEssages
- (void)loadMessages {
    self.messageArray = [NSMutableArray new];
    [self.messagesTableView reloadData];
}

- (void)addMessage:(Message *)message {
    [self.messageArray addObject:message];
    [self.messagesTableView reloadData];
    [self scrollToBottom];
}

#pragma mark - Add/Remove Observers
- (void)addObservers {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)removeObservers {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - Keybpard Notifications
- (void)keyboardWillShow:(NSNotification *)notification {
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    [self.inputToolbarBottomConstraint setConstant:keyboardSize.height+kInputToolbarBottomConstraint];
    [self.sendButtonBottomConstraint setConstant:keyboardSize.height+kSendButtonBottomConstraint];
    
    [UIView animateWithDuration:kAnimationDuration animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)keyboardDidHide:(NSNotification *)notification {
    [self.inputToolbarBottomConstraint setConstant:kInputToolbarBottomConstraint];
    [self.sendButtonBottomConstraint setConstant:kSendButtonBottomConstraint];
    
    [UIView animateWithDuration:kAnimationDuration animations:^{
        [self.view layoutIfNeeded];
    }];
}

#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView {
    [self updateInputTextViewFrame];
    [self enableDisableSendButton];
    [self shoHidePlaceholder];
}

#pragma mark - Update Input TextView Frame
- (void)updateInputTextViewFrame {
    CGFloat height = self.inputTextView.contentSize.height;

    if (height < self.maxInputToolbarHeight) {
        [self.inputToolbarHeight setConstant:height+8];
        
        [UIView animateWithDuration:kAnimationDuration animations:^{
            [self.view layoutIfNeeded];
        }];
    }
}

#pragma mark - Enable/Disable Send Button
- (void)enableDisableSendButton {
    if ([self stringByTrimmingWhitespace:self.inputTextView.text].length > 0) {
        [self.sendButton setEnabled:true];
    } else {
        [self.sendButton setEnabled:false];
    }
}

#pragma mark - Show/Hide Placeholder Label
- (void)shoHidePlaceholder {
    if (self.inputTextView.text.length > 0) {
        [self.inputPlaceHolderLabel setHidden:true];
    } else {
        [self.inputPlaceHolderLabel setHidden:false];
    }
}

#pragma mark - Trim Whitespaces and New Line
- (NSString *)stringByTrimmingWhitespace:(NSString *)string {
    return [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

#pragma mark - TableView Data Source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.messageArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    IncommingMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([IncommingMessageCell class])];
    Message *message = [self.messageArray objectAtIndex:indexPath.row];
    if (indexPath.row == 0) {
        [cell showHeader:true];
        [cell setHeaderTitle:@"Header Title Here"];
        [cell showSenderName:true];
    } else {
        [cell showHeader:false];
        [cell showSenderName:false];
    }
    [cell setMessage:message forIndexPath:indexPath];
    return cell;
}

#pragma mark - TableView Delegate
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 112;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Selected at indexPath: %@",indexPath);
}

#pragma mark - Scroll To Bottom
- (void)scrollToBottom {
    //[self.messagesTableView setContentOffset:CGPointMake(0, CGFLOAT_MAX)];
    //CGPoint bottomOffset = CGPointMake(0, self.messagesTableView.contentSize.height - 0);
    //[self.messagesTableView setContentOffset:bottomOffset animated:YES];
}

#pragma mark - Input Toolbar Button Actions
- (IBAction)attachmentButtonPressed:(UIButton *)sender {
    NSLog(@"Functionality Pending");
}

- (IBAction)sendButtonPressed:(id)sender {
    Message *message = [[Message alloc] init];
    message.messageBody = self.inputTextView.text;
    [self addMessage:message];
    
    self.inputTextView.text = @"";
    
    [self updateInputTextViewFrame];
    [self enableDisableSendButton];
    [self shoHidePlaceholder];
}

@end
