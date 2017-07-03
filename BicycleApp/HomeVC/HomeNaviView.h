//
//  HomeNaviView.h
//  BicycleApp
//
//  Created by 雨停 on 2017/5/19.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^leftBlock)();
typedef void(^mesBlock)();
typedef void(^searchBlock)();
@interface HomeNaviView : UIView
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIButton *mesBtn;
@property (weak, nonatomic) IBOutlet UIButton *searchBtn;
@property (nonatomic,copy)leftBlock   leftBlock;
@property (nonatomic,copy)mesBlock    mesBlock;
@property (nonatomic,copy)searchBlock searchBlock;
@end
