//
//  EMABSignupViewController.m
//  Chapter7
//
//  Created by Liangjun Jiang on 4/19/15.
//  Copyright (c) 2015 Liangjun Jiang. All rights reserved.
//

#import "EMABSignupViewController.h"
#import "EMABConstants.h"
#import "EMABUser.h"
@interface EMABSignupViewController ()<UITableViewDataSource, UITextFieldDelegate>
@property (nonatomic, strong) UITextField *emailTextField;
@property (nonatomic, strong) UITextField *passwordTextField;
@property (nonatomic, strong) UITextField *passwordAgainTextField;
@end

@implementation EMABSignupViewController

- (UITextField *)emailTextField
{
    if (_emailTextField == nil)
    {
        CGRect frame = CGRectMake(kLeftMargin, 8.0, kTextFieldWidth, kTextFieldHeight);
        _emailTextField = [[UITextField alloc] initWithFrame:frame];
        
        self.emailTextField.borderStyle = UITextBorderStyleNone;
        self.emailTextField.textColor = [UIColor blackColor];
        self.emailTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        self.emailTextField.placeholder = NSLocalizedString(@"Email", @"");
        self.emailTextField.backgroundColor = [UIColor whiteColor];
        self.emailTextField.autocorrectionType = UITextAutocorrectionTypeNo;	// no auto correction support
        
        self.emailTextField.keyboardType = UIKeyboardTypeEmailAddress;	// use the default type input method (entire keyboard)
        self.emailTextField.returnKeyType = UIReturnKeyDone;
        
        self.emailTextField.clearButtonMode = UITextFieldViewModeWhileEditing;	// has a clear 'x' button to the right
        
        self.emailTextField.tag = 0;		// tag this control so we can remove it later for recycled cells
        
        self.emailTextField.delegate = self;	// let us be the delegate so we know when the keyboard's "Done" button is pressed
        
        // Add an accessibility label that describes what the text field is for.
        [self.emailTextField setAccessibilityLabel:NSLocalizedString(@"Email", @"")];
    }
    return _emailTextField;
}

- (UITextField *)passwordTextField
{
    if (_passwordTextField == nil)
    {
        CGRect frame = CGRectMake(kLeftMargin, kTopMargin, kTextFieldWidth, kTextFieldHeight);
        self.passwordTextField = [[UITextField alloc] initWithFrame:frame];
        self.passwordTextField.borderStyle = UITextBorderStyleNone;
        self.passwordTextField.textColor = [UIColor blackColor];
        self.passwordTextField.placeholder = NSLocalizedString(@"Password",@"");
        self.passwordTextField.backgroundColor = [UIColor whiteColor];
        
        self.passwordTextField.keyboardType = UIKeyboardTypeDefault;
        self.passwordTextField.returnKeyType = UIReturnKeyDone;
        self.passwordTextField.secureTextEntry = YES;	// make the text entry secure (bullets)
        
        self.passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;	// has a clear 'x' button to the right
        
        self.passwordTextField.tag = 1;		// tag this control so we can remove it later for recycled cells
        
        self.passwordTextField.delegate = self;	// let us be the delegate so we know when the keyboard's "Done" button is pressed
        
        // Add an accessibility label that describes what the text field is for.
        [self.passwordTextField setAccessibilityLabel:NSLocalizedString(@"Password", @"")];
    }
    return _passwordTextField;
}

- (UITextField *)passwordAgainTextField
{
    if (_passwordAgainTextField == nil)
    {
        CGRect frame = CGRectMake(kLeftMargin, kTopMargin, kTextFieldWidth, kTextFieldHeight);
        self.passwordAgainTextField = [[UITextField alloc] initWithFrame:frame];
        self.passwordAgainTextField.borderStyle = UITextBorderStyleNone;
        self.passwordAgainTextField.textColor = [UIColor blackColor];
        self.passwordAgainTextField.placeholder = NSLocalizedString(@"Password Again",@"");
        self.passwordAgainTextField.backgroundColor = [UIColor whiteColor];
        
        self.passwordAgainTextField.keyboardType = UIKeyboardTypeDefault;
        self.passwordAgainTextField.returnKeyType = UIReturnKeyDone;
        self.passwordAgainTextField.secureTextEntry = YES;	// make the text entry secure (bullets)
        
        self.passwordAgainTextField.clearButtonMode = UITextFieldViewModeWhileEditing;	// has a clear 'x' button to the right
        
        self.passwordAgainTextField.tag = 2;		// tag this control so we can remove it later for recycled cells
        
        self.passwordAgainTextField.delegate = self;	// let us be the delegate so we know when the keyboard's "Done" button is pressed
        
        // Add an accessibility label that describes what the text field is for.
        [self.passwordAgainTextField setAccessibilityLabel:NSLocalizedString(@"Password Again", @"")];
    }
    return _passwordAgainTextField;
}


- (void)viewDidLoad {
    [super viewDidLoad];
}


-(IBAction)onSignup:(id)sender{
    BOOL cont0 = [self.passwordTextField.text length] > kMinTextLength;
    BOOL cont1 = [self.passwordAgainTextField.text length] > kMinTextLength;
    BOOL cont2 = [self.passwordTextField.text isEqualToString:self.passwordAgainTextField.text];
    BOOL cont3 = [self.emailTextField.text length] > kMinTextLength;
    BOOL cont4 = [self isValidEmail];
    
    if (!cont0) {
        [self showWarning:NSLocalizedString(@"Password at least 6 characters.", @"Password at least 6 characters.")];
    }
    if (!cont1) {
        [self showWarning:NSLocalizedString(@"Password at least 6 characters.", @"Password at least 6 characters.")];
    }
    if (!cont2) {
        [self showWarning:NSLocalizedString(@"Passwords have to match.", @"Passwords have to match.")];
    }
    if (!cont3) {
        [self showWarning:NSLocalizedString(@"Email at least 6 characters.", @"Password at least 6 characters.")];
    }
    
    if (!cont4) {
        [self showWarning:NSLocalizedString(@"Doesn't look like a valid email.", @"Doesn't look like a valid email.")];
    }
    
    if (cont0 && cont1 && cont2 && cont3 && cont4) {
        EMABUser *user = (EMABUser *)[PFUser user];
        user.username = [self.emailTextField text];
        user.email = [self.emailTextField text];
        user.password = [self.passwordTextField text];
        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
            if (!error) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        }];
    }
}

#pragma mark - tableview datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"SignupCell" forIndexPath:indexPath];
    
    UITextField *textField = nil;
    switch (indexPath.row) {
        case 0:
            textField = self.emailTextField;
            break;
        case 1:
            textField = self.passwordTextField;
            break;
        case 2:
            textField = self.passwordAgainTextField;
            break;
        default:
            break;
    }
    
    // make sure this textfield's width matches the width of the cell
    CGRect newFrame = textField.frame;
    newFrame.size.width = CGRectGetWidth(cell.contentView.frame) - kLeftMargin*2;
    textField.frame = newFrame;
    
    // if the cell is ever resized, keep the textfield's width to match the cell's width
    textField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    [cell.contentView addSubview:textField];
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


#pragma mark - helper
-(BOOL)isValidEmail {
    //https://github.com/benmcredmond/DHValidation
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self.emailTextField.text];
}

-(void)showWarning:(NSString *)message {
    [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Warning", @"Warning") message:message delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"OK") otherButtonTitles:nil , nil] show];
}

#pragma mark - UITextField Delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
@end
