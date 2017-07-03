//
//  HomeBottomView.h
//  BicycleApp
//
//  Created by 雨停 on 2017/5/11.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIButton+TitleImgEdgeInsets.h"
typedef void(^cheakViewBlock)();
typedef void(^refreshBlock)();
typedef void(^mapcenterBlock)();
typedef void(^helpcenterBlock)();

@interface HomeBottomView : UIView
@property  (nonatomic,strong) UIButton   *refreshButton;
@property  (nonatomic,strong) UIButton   *mapcenterButton;
@property  (nonatomic,strong) UIButton   *helpcenterButton;
@property  (nonatomic,strong) UIButton   *cheakcodeButton;
 

@property (nonatomic, copy)   cheakViewBlock    cheakBlock;
@property (nonatomic, copy)   refreshBlock      freshBlock;
@property (nonatomic, copy)   mapcenterBlock    mapBlock;
@property (nonatomic, copy)   helpcenterBlock   helpBlock;
@end
