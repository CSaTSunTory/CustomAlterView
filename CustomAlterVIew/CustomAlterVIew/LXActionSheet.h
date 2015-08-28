//
//  LXActionSheet.h
//  CloudEnglish
//
//  Created by lxb on 15/7/15.
//  Copyright (c) 2015年 YouYuan. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LXActionSheetDelegate <NSObject>
- (void)didClickOnButtonIndex:(NSInteger *)buttonIndex;
- (void)towBtnCilck:(NSInteger *)buttonIndex;
@optional
- (void)didClickOnDestructiveButton;
- (void)didClickOnCancelButton;
@end
@interface LXActionSheet : UIView
- (id)initWithTitle:(NSString *)title delegate:(id<LXActionSheetDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSArray *)otherButtonTitlesArray andColor:(BOOL)sign;
- (void)showInView:(UIView *)view;
- (void)showInView;
-(void)initMessage:(NSString *)message liftButtonTitle:(NSString *)liftTitle andRight:(NSString *)rightTitle ;
-(id)initWithLoadingImage;
-(void)setProess:(int)pross;
- (void)tappedCancel;
- (void)Cancel;
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UILabel *label;
@property (assign,nonatomic) BOOL iscolor;
@property (assign,nonatomic) id<LXActionSheetDelegate> delegate;

@end
