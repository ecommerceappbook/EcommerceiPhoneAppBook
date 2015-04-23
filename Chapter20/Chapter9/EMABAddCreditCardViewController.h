//
//  EMABAddCreditCardViewController.h
//  Chapter20
//
//  Created by Liangjun Jiang on 4/23/15.
//  Copyright (c) 2015 Liangjun Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EMABAddCreditCardViewController;
typedef void (^ViewControllerDidFinish)(EMABAddCreditCardViewController *viewController, NSString *customerId);
typedef void (^ViewControllerDidCancel)(EMABAddCreditCardViewController *viewController);

@interface EMABAddCreditCardViewController : UIViewController
@property (nonatomic, copy) ViewControllerDidFinish finishBlock;
@property (nonatomic, copy) ViewControllerDidCancel cancelBlock;
@end
