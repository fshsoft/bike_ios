//
//  XYBaseVC.h
//  CateTool
//
//  Created by 雨停 on 2016/12/18.
//  Copyright © 2016年 雨停. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseModel.h"
extern NSString *const kName;

/*! 定义请求成功的 block */
typedef void( ^ RequestSuccess)(id  response);
/*! 定义请求失败的 block */
typedef void( ^ RequestFail)(NSError *error);


@interface XYBaseVC : UIViewController

@property (nonatomic, strong) NaviView * navi;
- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
           dictionary:(NSDictionary *)dic;


- (void)setData;
- (void)leftFoundation;
- (void)rightFoundation;
-(void)setNaivTitle:(NSString *)title;
-(void)setNaivBackgroundColor :(UIColor*)color;
- (void)setSubviews;

- (void)viewWillAppear:(BOOL)animated;
- (void)absPushViewController:(XYBaseVC *) controller animated:(BOOL) animated;


- (void)absRootPushViewController:(XYBaseVC *) controller animated:(BOOL) animated;


- (void)setBackBarButtonItem;
- (void)absPopNav;



- (void)setNavLeftItemTitle:(NSString *)str andImage:(UIImage *)image;
- (void)leftItemClick:(id)sender;


- (void)setNavRightItemTitle:(NSString *)str andImage:(UIImage *)image;
- (void)rightItemClick:(id)sender;



-(void)loadNewData;


-(void)loadMoreData;

- (void)updatePlaceholderView;

- (void)showPlaceholderViewWithImage:(UIImage *)image
                             message:(NSString *)message
                         buttonTitle:(NSString *)title
                       centerOffsetY:(CGFloat)centerOffsetY
                         onSuperView:(UIView *)superView;

- (UIView *)setPlaceholderViewWithImage:(UIImage *)image
                                message:(NSString *)message
                            buttonTitle:(NSString *)title
                          centerOffsetY:(CGFloat)centerOffsetY;
- (void)startLoading;
- (void)endLoading;
- (void)updateLoading;

- (BOOL)isLogin;
- (float)getTextWidth:(float)textHeight text:(NSString *)text font:(UIFont *)font ;
- (float)getTextHeight:(float)textWidth text:(NSString *)text font:(UIFont *)font;
- (void)refreshPassWordToken;
-(void)refreshClientCredentialsToken;
-(void)requestType:(HttpRequestType)type
               url:(NSString *)url
        parameters:(NSDictionary *)parm
      successBlock:(RequestSuccess)success failureBlock:(RequestFail)failure;

@end
