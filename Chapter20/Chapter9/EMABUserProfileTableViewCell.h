//
//  EMABUserProfileTableViewCell.h
//  Chapter20
//
//  Created by Liangjun Jiang on 4/23/15.
//  Copyright (c) 2015 Liangjun Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EMABUserProfileTableViewCell : UITableViewCell
- (void)setContentForTableCellLabel:(NSString*)title placeHolder:(NSString *)placeHolder :(NSString *)text keyBoardType:(NSNumber *)type enabled:(BOOL)enabled;
@end
