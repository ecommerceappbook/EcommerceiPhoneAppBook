//
//  EMABDispatchViewController.m
//  Chapter6
//
//  Created by Liangjun Jiang on 4/18/15.
//  Copyright (c) 2015 Liangjun Jiang. All rights reserved.
//

#import "EMABDispatchViewController.h"
#import "EMABConstants.h"
#import "EMABUser.h"
#import <ParseFacebookUtils/PFFacebookUtils.h>
@interface EMABDispatchViewController ()
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicatorView;
@end

@implementation EMABDispatchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.activityIndicatorView.hidden = YES;
    
}


-(IBAction)onFacebookLogin:(id)sender{
    // Set permissions required from the facebook user account
    NSArray *permissionsArray = @[@"user_about_me"];
    [self updateIndicator:YES];
    [PFFacebookUtils logInWithPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
        if (error) {
                NSString *facebookError = [FBErrorUtility userMessageForError:error];
                [self showError:facebookError];
            } else {
                [self obtainFacebookUserInfo:user];
        }
        [self updateIndicator:NO];
    }];
}

-(void)obtainFacebookUserInfo:(PFUser *)user{
    [self updateIndicator:YES];
    EMABUser *fbUser = (EMABUser *)user;
    FBRequest *request = [FBRequest requestForMe];
    [request startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        [self updateIndicator:NO];
        if (!error) {
            // Parse the data received
            NSDictionary *userData = (NSDictionary *)result;
            [fbUser setEmail:userData[@"email"]];
            [fbUser setUsername:userData[@"email"]];
            [fbUser setName:userData[@"name"]];
            if (userData[@"gender"]) {
                [fbUser setGender:userData[@"gender"]];
            }
            
            NSString *facebookID = userData[@"id"];
            NSURL *pictureURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=square&return_ssl_resources=1", facebookID]];
            
            if ([pictureURL absoluteString]) {
                dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
                dispatch_async(queue, ^{
                    NSData * imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[pictureURL absoluteString]]];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        PFFile *iconFile = [PFFile fileWithName:@"avatar.jpg" data:imageData];
                        [iconFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                            if (!error) {
                                fbUser.photo = iconFile;
                            }
                        }];
                        
                    });
                });
            }
            
            [fbUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (!error) {
                    [self dismissViewControllerAnimated:YES completion:nil];
                }
            }];
            
        } else if ([[[[error userInfo] objectForKey:@"error"] objectForKey:@"type"]
                    isEqualToString: @"OAuthException"]) {
            [self dismissViewControllerAnimated:YES completion:^{
                [self showError:@"The facebook session was invalidated"];
            }];
        } else {
            [self dismissViewControllerAnimated:YES completion:^{
                [self showError:[error localizedDescription]];
            }];
        }
    }];
}

-(IBAction)onCancel:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)updateIndicator:(BOOL)shouldEnable{
    self.navigationItem.leftBarButtonItem.enabled = !shouldEnable;
    (shouldEnable)?[self.activityIndicatorView startAnimating]:[self.activityIndicatorView stopAnimating];
    self.activityIndicatorView.hidden = !shouldEnable;
    
}

#pragma mark - helper
-(void)showError:(NSString *)message {
     [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", @"Error") message:message delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"OK") otherButtonTitles:nil , nil] show];
}
@end
