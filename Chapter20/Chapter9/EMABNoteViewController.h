//
//  EMABNoteViewController.h
//  Chapter19
//
//  Created by Liangjun Jiang on 4/23/15.
//  Copyright (c) 2015 Liangjun Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EMABNoteViewController;

typedef void (^ViewControllerDidFinish)(EMABNoteViewController *viewController, NSString *note);
typedef void (^ViewControllerDidCancel)(EMABNoteViewController *viewController);

@interface EMABNoteViewController : UIViewController
@property (nonatomic, copy) ViewControllerDidCancel cancelBlock;
@property (nonatomic, copy) ViewControllerDidFinish finishBlock;
@end
