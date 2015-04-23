//
//  EMABNoteViewController.m
//  Chapter19
//
//  Created by Liangjun Jiang on 4/23/15.
//  Copyright (c) 2015 Liangjun Jiang. All rights reserved.
//

#import "EMABNoteViewController.h"

@interface EMABNoteViewController ()
@property (nonatomic, weak) IBOutlet UITextView *noteTextView;
@end

@implementation EMABNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.noteTextView becomeFirstResponder];
}


-(IBAction)onCancel:(id)sender {
    [self.noteTextView resignFirstResponder];
    self.cancelBlock(self);
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)onDone:(id)sender {
    if ([self.noteTextView.text length]>0) {
        [self.noteTextView resignFirstResponder];
        self.finishBlock(self, self.noteTextView.text);
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Warning", @"Warning")
                                                                       message:@"It doesn't look like you have entered anything"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK",@"OK") style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
}

@end
