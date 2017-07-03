//
//  MoneySelectView.h
//  BicycleApp
//
//  Created by 雨停 on 2017/5/21.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^hunBlock)();
typedef void (^halfhunBlock)();
typedef void (^twotenBlock)();
typedef void (^tenBlock)();

@interface MoneySelectView : UIView
@property (weak, nonatomic) IBOutlet UIButton *hundredBtn;
@property (weak, nonatomic) IBOutlet UIButton *halfHunBtn;
@property (weak, nonatomic) IBOutlet UIButton *twoTenBtn;
@property (weak, nonatomic) IBOutlet UIButton *tenBtn;
@property (nonatomic,copy) hunBlock hunBlock;
@property (nonatomic,copy) halfhunBlock halfhunBlock;
@property (nonatomic,copy) twotenBlock twotenBlock;
@property (nonatomic,copy) tenBlock tenBlock;
@end
