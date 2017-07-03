//
//  ChangeName.m
//  BicycleApp
//
//  Created by 雨停 on 2017/5/21.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "ChangeName.h"

@interface ChangeName ()
@property (nonatomic,strong)UITextField *name;
@end

@implementation ChangeName
-(id)init{
    if(self =[super init  ]){
        self.arr  =[NSMutableArray array];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
     UIView *textView = [[UIView alloc]initWithFrame:CGRectMake(0, 84, SCREEN_WIDTH, 40)];
    textView.backgroundColor = [UIColor whiteColor];
    [textView addSubview:self.name];
    [self.view addSubview:textView];
    [self setNaivTitle:@"昵称"];
    self.view.backgroundColor = RGBColor(245, 245, 245);
    [self.navi .leftBtn setImage:[UIImage  new] forState:UIControlStateNormal];
    [self.navi.leftBtn setTitle:@"取消" forState:UIControlStateNormal];
    self.navi.leftBtn.titleLabel.font = FontSize(13);
    self.navi.leftBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    
    [self.navi.rightBtn setTitle:@"保存" forState:UIControlStateNormal];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UITextField *)name{
    
    if(!_name){
        _name = [[UITextField alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-20, 40)];
        _name.clearButtonMode =UITextFieldViewModeWhileEditing;
        _name.font = FontSize(14);
        _name.placeholder = @"请输入昵称";
    }
    return _name;
}
-(void)leftFoundation{
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)rightFoundation{
    
    if(_name.text.length==0){
        Toast(@"未输入昵称");
    }else{
        
        [self postNotation];
        [DB putString:_name.text withId:@"name" intoTable:tabName];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)postNotation{
    [self.arr replaceObjectAtIndex:self.tag withObject:_name.text];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"personcenter" object:self.arr];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
