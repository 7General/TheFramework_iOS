//
//  CustomSearchViewController.h
//  LongFor
//
//  Created by ruantong on 17/5/18.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Additions.h"

@interface CustomSearchViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *searchView;
- (IBAction)SearchBut:(id)sender;
- (IBAction)cancelSearchBut:(id)sender;
- (IBAction)cancelHistory:(id)sender;

@end
