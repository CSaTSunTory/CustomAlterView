//
//  LXActionSheet.m
//  CloudEnglish
//
//  Created by lxb on 15/7/15.
//  Copyright (c) 2015年 YouYuan. All rights reserved.
//

#import "LXActionSheet.h"
#define WINDOW_COLOR                            [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]
#define ANIMATE_DURATION                        0.25f
#define ACTIONSHEET_BACKGROUNDCOLOR              [UIColor whiteColor]

#define CORNER_RADIUS                           5
#define BUTTON_INTERVAL_HEIGHT                  10
#define BUTTON_HEIGHT                           44
#define BUTTON_INTERVAL_WIDTH                   30
#define BUTTON_WIDTH                           [UIScreen mainScreen].bounds
#define BUTTON_BORDER_WIDTH                     0.25f
#define BUTTONTITLE_FONT                        [UIFont systemFontOfSize:18.0f]

#define BUTTON_BORDER_COLOR                    [UIColor lightGrayColor].CGColor
#define TITLE_INTERVAL_HEIGHT                   15
#define TITLE_HEIGHT                            100
#define TITLE_INTERVAL_WIDTH                    30
#define TITLE_WIDTH                              [UIScreen mainScreen].bounds
#define TITLE_FONT                              [UIFont systemFontOfSize:14.0f]
#define SHADOW_OFFSET                           CGSizeMake(0, 0.8f)
#define TITLE_NUMBER_LINES                      2
#define screenFrame         [UIScreen mainScreen].bounds
#define ANIMATE_DURATION                        0.25f
#define RGB(A,B,C) [UIColor colorWithRed:A/255.0 green:B/255.0 blue:C/255.0 alpha:1.0]
@interface LXActionSheet ()

@property (nonatomic,strong) UIView *backGroundView;


@property (nonatomic,strong) NSString *actionTitle;
@property (nonatomic,assign) NSInteger postionIndexNumber;
@property (nonatomic,assign) BOOL isHadTitle;
@property (nonatomic,assign) BOOL isHadDestructionButton;
@property (nonatomic,assign) BOOL isHadOtherButton;
@property (nonatomic,assign) BOOL isHadCancelButton;
@property (nonatomic,assign) CGFloat LXActionSheetHeight;

@end
@implementation LXActionSheet

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)init
{
    self = [super init];
    if (self) {
//        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
//        self.backgroundColor = WINDOW_COLOR;
//        self.imageView = [[UIImageView alloc] init];
//        [self addSubview:self.imageView];
//        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.center.equalTo(self);
//            make.size.mas_equalTo(CGSizeMake(100, 100));
//            
//        }];
//      self. label = [[UILabel alloc] init];
//        
//        [self. label mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.center.equalTo(self.imageView);
//            make.size.mas_equalTo(CGSizeMake(50, 50));
//            
//        }];
//        NSMutableArray *imageArr = [[NSMutableArray alloc] init];
//        for (int i=1; i < 14; i ++ ) {
//            [imageArr addObject:[UIImage imageNamed: [NSString stringWithFormat: @"loading%d",i]]];
//        }
//   
//        [self.imageView addSubview:self. label];
        
        
        
    }
    return self;
}

-(id)initWithLoadingImage{
    self = [super init];
    if (self) {
                self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
                self.backgroundColor = WINDOW_COLOR;
                self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(screenFrame.size.width/2 -50, screenFrame.size.height/2-50, 100, 100)];
         
                [self addSubview:self.imageView];
        UIImageView *iamge  = [[UIImageView alloc] initWithFrame:CGRectMake(17, 17, 66, 66)];
        iamge.image = [UIImage imageNamed:@"圆心"];
              self. label = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 70, 30)];
        [self.imageView addSubview:iamge];
        self.label.font = [UIFont systemFontOfSize:16.0f];
        self.label.textColor = [UIColor whiteColor];
        self.imageView.image = [UIImage imageNamed:@"loading1"];
        self.label.text = @"0%";
        self.label.textAlignment = NSTextAlignmentCenter;
//        self.imageView.backgroundColor = [UIColor redColor];
                [iamge addSubview:self. label];
    
    }
    return self;
}
- (id)initWithTitle:(NSString *)title delegate:(id<LXActionSheetDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSArray *)otherButtonTitlesArray andColor:(BOOL)sign;{
    self = [super init];
    if (self) {
        self.iscolor = sign;
        //初始化背景视图，添加手势
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        self.backgroundColor = WINDOW_COLOR;
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedCancel)];
        [self addGestureRecognizer:tapGesture];
        
        if (delegate) {
            self.delegate = delegate;
        }
     
      [self creatButtonsWithTitle:title cancelButtonTitle:cancelButtonTitle destructionButtonTitle:destructiveButtonTitle otherButtonTitles:otherButtonTitlesArray];
    }
    return self;
}

- (void)showInView:(UIView *)view
{
  
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}
- (void)showInView{
    self.alpha = 1;
 [[UIApplication sharedApplication].keyWindow addSubview:self];
}
#pragma mark - CreatButtonAndTitle method
- (void)creatButtonsWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle destructionButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSArray *)otherButtonTitlesArray {
    //初始化
    self.isHadTitle = NO;
    self.isHadDestructionButton = NO;
    self.isHadOtherButton = NO;
    self.isHadCancelButton = NO;
    
    //初始化LXACtionView的高度为0
    self.LXActionSheetHeight = 0;
    
    //初始化IndexNumber为0;
    self.postionIndexNumber = 0;
    //生成LXActionSheetView
    self.backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 0)];
    self.backGroundView.backgroundColor = [UIColor clearColor];
    
    //给LXActionSheetView添加响应事件
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedBackGroundView)];
    [self.backGroundView addGestureRecognizer:tapGesture];
        [self addSubview:self.backGroundView];
    if (title) {
            self.isHadTitle = YES;
       UILabel *titleLabel = [self creatTitleLabelWith:title];
        self.LXActionSheetHeight = self.LXActionSheetHeight +TITLE_HEIGHT;
        [self.backGroundView addSubview:titleLabel];
    }
    if (destructiveButtonTitle) {
        self.isHadDestructionButton = YES;
        
        UIButton *destructiveButton = [self creatDestructiveButtonWith:destructiveButtonTitle];
        destructiveButton.tag = self.postionIndexNumber;
        [destructiveButton addTarget:self action:@selector(clickOnButtonWith:) forControlEvents:UIControlEventTouchUpInside];
        
        if (self.isHadTitle == YES) {
            //当有title时
            [destructiveButton setFrame:CGRectMake(destructiveButton.frame.origin.x, self.LXActionSheetHeight, destructiveButton.frame.size.width, destructiveButton.frame.size.height)];
            
            if (otherButtonTitlesArray && otherButtonTitlesArray.count > 0) {
                self.LXActionSheetHeight = self.LXActionSheetHeight + destructiveButton.frame.size.height;            }
            else{
                self.LXActionSheetHeight = self.LXActionSheetHeight + destructiveButton.frame.size.height+BUTTON_INTERVAL_HEIGHT;
            }
        }
        else{
            //当无title时
            if (otherButtonTitlesArray && otherButtonTitlesArray.count > 0) {
                self.LXActionSheetHeight = self.LXActionSheetHeight + destructiveButton.frame.size.height+(BUTTON_INTERVAL_HEIGHT);
            }
            else{
                self.LXActionSheetHeight = self.LXActionSheetHeight + destructiveButton.frame.size.height+(BUTTON_INTERVAL_HEIGHT);
            }
        }
        [self.backGroundView addSubview:destructiveButton];
        
        self.postionIndexNumber++;
    }
    if (otherButtonTitlesArray) {
        if (otherButtonTitlesArray.count > 0) {
            self.isHadOtherButton = YES;
            
            //当无title与destructionButton时
            if (self.isHadTitle == NO && self.isHadDestructionButton == NO) {
                for (int i = 0; i<otherButtonTitlesArray.count; i++) {
                    UIButton *otherButton = [self creatOtherButtonWith:[otherButtonTitlesArray objectAtIndex:i] withPostion:i];
                    
                    otherButton.tag = self.postionIndexNumber;
                    [otherButton addTarget:self action:@selector(clickOnButtonWith:) forControlEvents:UIControlEventTouchUpInside];
                    [otherButton setFrame:CGRectMake(otherButton.frame.origin.x, self.LXActionSheetHeight, otherButton.frame.size.width, otherButton.frame.size.height)];
                    if (i != otherButtonTitlesArray.count - 1) {
                        self.LXActionSheetHeight = self.LXActionSheetHeight + otherButton.frame.size.height;
                    }
                    else{
                        self.LXActionSheetHeight = self.LXActionSheetHeight + otherButton.frame.size.height;
                    }
                    
                    [self.backGroundView addSubview:otherButton];
                    
                    self.postionIndexNumber++;
                }
            }
            
            //当有title或destructionButton时
            if (self.isHadTitle == YES || self.isHadDestructionButton == YES) {
                for (int i = 0; i<otherButtonTitlesArray.count; i++) {
                    UIButton *otherButton = [self creatOtherButtonWith:[otherButtonTitlesArray objectAtIndex:i] withPostion:i];
                    
                    otherButton.tag = self.postionIndexNumber;
                    [otherButton addTarget:self action:@selector(clickOnButtonWith:) forControlEvents:UIControlEventTouchUpInside];
                    [otherButton setFrame:CGRectMake(otherButton.frame.origin.x, self.LXActionSheetHeight, otherButton.frame.size.width, otherButton.frame.size.height)];
                    
                    if (i != otherButtonTitlesArray.count - 1) {
                        self.LXActionSheetHeight = self.LXActionSheetHeight + otherButton.frame.size.height;
                    }
                    else{
                        self.LXActionSheetHeight = self.LXActionSheetHeight + otherButton.frame.size.height;
                    }
                    
                    [self.backGroundView addSubview:otherButton];
                    
                    self.postionIndexNumber++;
                }
            }
        }
    }
    
    if (cancelButtonTitle) {
        self.isHadCancelButton = YES;
        
        UIButton *cancelButton = [self creatCancelButtonWith:cancelButtonTitle];
        
        cancelButton.tag = self.postionIndexNumber;
        [cancelButton addTarget:self action:@selector(clickOnButtonWith:) forControlEvents:UIControlEventTouchUpInside];
        
        //当没title destructionButton otherbuttons时
        if (self.isHadTitle == NO && self.isHadDestructionButton == NO && self.isHadOtherButton == NO) {
            self.LXActionSheetHeight = self.LXActionSheetHeight + cancelButton.frame.size.height+(2*BUTTON_INTERVAL_HEIGHT);
        }
        
        //当有title或destructionButton或otherbuttons时
        if (self.isHadTitle == YES || self.isHadDestructionButton == YES || self.isHadOtherButton == YES) {
            if(self.isHadTitle == YES & self.isHadDestructionButton == NO &self.isHadOtherButton == NO){
            
                [cancelButton setFrame:CGRectMake(cancelButton.frame.origin.x, self.LXActionSheetHeight+2*BUTTON_INTERVAL_HEIGHT, cancelButton.frame.size.width, cancelButton.frame.size.height)];
                self.LXActionSheetHeight = self.LXActionSheetHeight + cancelButton.frame.size.height+2*BUTTON_INTERVAL_HEIGHT;
            }else{
            [cancelButton setFrame:CGRectMake(cancelButton.frame.origin.x, self.LXActionSheetHeight+BUTTON_INTERVAL_HEIGHT/2, cancelButton.frame.size.width, cancelButton.frame.size.height)];
                self.LXActionSheetHeight = self.LXActionSheetHeight + cancelButton.frame.size.height+BUTTON_INTERVAL_HEIGHT/2;}
        }
        
        [self.backGroundView addSubview:cancelButton];
        
        self.postionIndexNumber++;
    }
    
    [UIView animateWithDuration:ANIMATE_DURATION animations:^{
        [self.backGroundView setFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-self.LXActionSheetHeight, [UIScreen mainScreen].bounds.size.width, self.LXActionSheetHeight)];
    } completion:^(BOOL finished) {
    }];



}

- (UILabel *)creatTitleLabelWith:(NSString *)title
{
   
    UILabel *titlelabel = [[UILabel alloc] initWithFrame:CGRectMake(0, TITLE_INTERVAL_HEIGHT, TITLE_WIDTH.size.width, TITLE_HEIGHT)];
    titlelabel.backgroundColor = [UIColor whiteColor];
    titlelabel.textAlignment = NSTextAlignmentCenter;
//    titlelabel.shadowColor = [UIColor blackColor];
//    titlelabel.layer.borderWidth = BUTTON_BORDER_WIDTH;
//    titlelabel.layer.borderColor = BUTTON_BORDER_COLOR;
//    titlelabel.shadowOffset = SHADOW_OFFSET;
//    titlelabel.font = TITLE_FONT;
     if(self.iscolor ){
         titlelabel.attributedText = title;
     }else {
         titlelabel.text = title;}
    titlelabel.font = [UIFont systemFontOfSize:18.0f];
    titlelabel.text = title;
    titlelabel.textColor = [UIColor redColor];
    titlelabel.numberOfLines = TITLE_NUMBER_LINES;
    return titlelabel;
}
-(UIButton *)creatTitleButtonWith:(NSString *)cancelButtonTitle{

    UIButton *destructiveButton = [[UIButton alloc] initWithFrame:CGRectMake(0, BUTTON_INTERVAL_HEIGHT, BUTTON_WIDTH.size.width, BUTTON_HEIGHT)];
//    destructiveButton.layer.masksToBounds = YES;
//    destructiveButton.layer.cornerRadius = CORNER_RADIUS;
    
    destructiveButton.layer.borderWidth = BUTTON_BORDER_WIDTH;
    destructiveButton.layer.borderColor = BUTTON_BORDER_COLOR;
    
    destructiveButton.backgroundColor = [UIColor whiteColor];
    [destructiveButton setTitle:cancelButtonTitle forState:UIControlStateNormal];
    destructiveButton.titleLabel.font = BUTTONTITLE_FONT;
    
    [destructiveButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
 
    return destructiveButton;


}
- (UIButton *)creatDestructiveButtonWith:(NSString *)destructiveButtonTitle
{
    UIButton *destructiveButton = [[UIButton alloc] initWithFrame:CGRectMake(0, BUTTON_INTERVAL_HEIGHT, BUTTON_WIDTH.size.width, BUTTON_HEIGHT)];
//    destructiveButton.layer.masksToBounds = YES;
//    destructiveButton.layer.cornerRadius = CORNER_RADIUS;
    destructiveButton.backgroundColor = [UIColor whiteColor];
    destructiveButton.layer.borderWidth = BUTTON_BORDER_WIDTH;
    destructiveButton.layer.borderColor = BUTTON_BORDER_COLOR;
//
//    destructiveButton.backgroundColor = DESTRUCTIVE_BUTTON_COLOR;

    [destructiveButton setTitle:destructiveButtonTitle forState:UIControlStateNormal];
    destructiveButton.titleLabel.font = BUTTONTITLE_FONT;
    
    [destructiveButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [destructiveButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    return destructiveButton;
}

- (UIButton *)creatOtherButtonWith:(NSString *)otherButtonTitle withPostion:(NSInteger )postionIndex
{
    UIButton *otherButton = [[UIButton alloc] initWithFrame:CGRectMake(0, BUTTON_INTERVAL_HEIGHT + (postionIndex*(BUTTON_HEIGHT+(BUTTON_INTERVAL_HEIGHT/2))), BUTTON_WIDTH.size.width, BUTTON_HEIGHT)];
//    otherButton.layer.masksToBounds = YES;
//    otherButton.layer.cornerRadius = CORNER_RADIUS;
    
    otherButton.layer.borderWidth = BUTTON_BORDER_WIDTH;
    otherButton.layer.borderColor = BUTTON_BORDER_COLOR;
    
    otherButton.backgroundColor = [UIColor whiteColor];
    if(self.iscolor ){
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:otherButtonTitle];
             [str addAttribute:NSForegroundColorAttributeName value:RGB(115, 192, 157) range:NSMakeRange(7,otherButtonTitle.length -8)];
        [otherButton setAttributedTitle:str forState:UIControlStateNormal];
    }else {
  [otherButton setTitle:otherButtonTitle forState:UIControlStateNormal];;}
  
    otherButton.titleLabel.font = BUTTONTITLE_FONT;
    [otherButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [otherButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    return otherButton;
}

- (UIButton *)creatCancelButtonWith:(NSString *)cancelButtonTitle
{
    UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(0, BUTTON_INTERVAL_HEIGHT, BUTTON_WIDTH.size.width, BUTTON_HEIGHT)];
//    cancelButton.layer.masksToBounds = YES;
//    cancelButton.layer.cornerRadius = CORNER_RADIUS;
    
//    cancelButton.layer.borderWidth = BUTTON_BORDER_WIDTH;
//    cancelButton.layer.borderColor = BUTTON_BORDER_COLOR;
    
    cancelButton.backgroundColor = [UIColor whiteColor];
    [cancelButton setTitle:cancelButtonTitle forState:UIControlStateNormal];
    cancelButton.titleLabel.font = BUTTONTITLE_FONT;
    [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [cancelButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    return cancelButton;
}

//- (UILabel *)creatTitleLabelWith:(NSString *)title
//{
//    UILabel *titlelabel = [[UILabel alloc] initWithFrame:CGRectMake(TITLE_INTERVAL_WIDTH, TITLE_INTERVAL_HEIGHT, TITLE_WIDTH, TITLE_HEIGHT)];
//    titlelabel.backgroundColor = [UIColor whiteColor];
//    titlelabel.textAlignment = NSTextAlignmentCenter;
//    titlelabel.shadowColor = [UIColor blackColor];
//    titlelabel.shadowOffset = SHADOW_OFFSET;
//    titlelabel.font = TITLE_FONT;
//    titlelabel.text = title;
//    titlelabel.textColor = [UIColor grayColor];
//    titlelabel.numberOfLines = TITLE_NUMBER_LINES;
//    return titlelabel;
//}


- (void)clickOnButtonWith:(UIButton *)button
{
    
    if (self.isHadDestructionButton == YES) {
        if (self.delegate) {
            if (button.tag == 0) {
                if ([self.delegate respondsToSelector:@selector(didClickOnDestructiveButton)] == YES){
                    [self.delegate didClickOnDestructiveButton];
                }
            }
        }
    }
    
    if (self.isHadCancelButton == YES) {
        if (self.delegate) {
            if (button.tag == self.postionIndexNumber-1) {
                if ([self.delegate respondsToSelector:@selector(didClickOnCancelButton)] == YES) {
                    [self.delegate didClickOnCancelButton];
                }
            }
        }
    }
    
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(didClickOnButtonIndex:)] == YES) {
            [self.delegate didClickOnButtonIndex:(NSInteger *)button.tag];
        }
    }
    
    [self tappedCancel];
}
- (void)tappedCancel
{
    [UIView animateWithDuration:ANIMATE_DURATION animations:^{
        [self.backGroundView setFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 0)];
        self.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}
- (void)Cancel{
    [UIView animateWithDuration:ANIMATE_DURATION animations:^{
        [self.backGroundView setFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 0)];
        self.alpha = 0;
    } completion:^(BOOL finished) {
     
    }];

}
- (void)tappedBackGroundView
{
    //
}
-(void)initMessage:(NSString *)message liftButtonTitle:(NSString *)liftTitle andRight:(NSString *)rightTitle {
    //初始化背景视图，添加手势
    //初始化LXACtionView的高度为0
    
//    CGFloat LXActionSheetHeight = 0;
    self.backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 0)];
    self.backGroundView.backgroundColor = [UIColor clearColor];
    self.LXActionSheetHeight = 0;
 
    self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    self.backgroundColor = WINDOW_COLOR;
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedCancel)];
    [self addGestureRecognizer:tapGesture];
    UILabel *titleLabel = [self creatTitleLabelWith:message];
    self.LXActionSheetHeight = self.LXActionSheetHeight +TITLE_HEIGHT+TITLE_INTERVAL_HEIGHT;
    [self.backGroundView addSubview:titleLabel];
    
    UIButton *liftbtn = [[UIButton alloc] init];
    [liftbtn setFrame:CGRectMake(0, self.LXActionSheetHeight+5 , screenFrame.size.width/2, 40)];
    [liftbtn setTitle:liftTitle forState:UIControlStateNormal];
    [liftbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    liftbtn.backgroundColor = [UIColor whiteColor];
    UIButton *rightbtn = [[UIButton alloc] init];
    [rightbtn setFrame:CGRectMake( screenFrame.size.width/2, self.LXActionSheetHeight+5  , screenFrame.size.width/2, 40)];
     [rightbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];    [rightbtn setTitle:rightTitle forState:UIControlStateNormal];
    rightbtn.backgroundColor = [UIColor whiteColor];
    UIImageView *iamge = [[UIImageView alloc] init];
     [iamge setFrame:CGRectMake( screenFrame.size.width/2, self.LXActionSheetHeight+10 , 1, 30)];
    iamge.backgroundColor = [UIColor lightGrayColor];
    UIImageView *iamge1 = [[UIImageView alloc] init];
    [iamge1 setFrame:CGRectMake( 0, self.LXActionSheetHeight , screenFrame.size.width, 1)];
    iamge1.backgroundColor = [UIColor lightGrayColor];
    [self.backGroundView addSubview:liftbtn];
    [self.backGroundView addSubview:rightbtn];
    [self .backGroundView addSubview:iamge];
      [self .backGroundView addSubview:iamge1];
    self.LXActionSheetHeight = self.LXActionSheetHeight +40+5;
    
    [liftbtn addTarget:self action:@selector(cilck:) forControlEvents:UIControlEventTouchUpInside];
       [rightbtn addTarget:self action:@selector(cilck:) forControlEvents:UIControlEventTouchUpInside];
    liftbtn.tag = 0;
    rightbtn .tag = 1;
    
    [UIView animateWithDuration:ANIMATE_DURATION animations:^{
        [self.backGroundView setFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-self.LXActionSheetHeight, [UIScreen mainScreen].bounds.size.width, self.LXActionSheetHeight)];
       
    } completion:^(BOOL finished) {
         [self addSubview:self.backGroundView];
          [[UIApplication sharedApplication].keyWindow addSubview:self];
    }];
   
  


}
-(void)setProess:(int )pross{

    self.label.text = [NSString stringWithFormat:@"%d%%",pross];
    self.label.textAlignment  = NSTextAlignmentCenter;
 
    self.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"loading%d",pross/4+1]];
//     [self setImages:imageArr forState:MJRefreshStateRefreshing];

}
-(void)cilck:(UIButton *)sender{

    [self.delegate towBtnCilck:sender.tag];
    [self tappedCancel];

}
@end
