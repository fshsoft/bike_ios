//
//  StopVC.m
//  BicycleApp
//
//  Created by 雨停 on 2017/5/24.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "StopVC.h"
#import "stopView.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
#import "PushBikeNumVC.h"
@interface StopVC ()<UITextViewDelegate,UIScrollViewDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property  (nonatomic,strong)stopView    *stopvc;
@property (nonatomic,strong)  UIImagePickerController *imagePickerController;

@end

@implementation StopVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSubPhotos];
    [self setSubView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setSubView{
    self.stopvc  =[[NSBundle mainBundle]loadNibNamed:@"stop" owner:self options:nil].lastObject;
    [self.view addSubview:self.stopvc];
    self.stopvc.frame=CGRectMake(0, 64, SCREEN_WIDTH, SCREENH_HEIGHT-64);
    ;
    __block StopVC *weakself=self;
    self.stopvc.photoBlock = ^{
        [weakself getPhoto];
        
       
    };
    self.stopvc.cheakNumBlock = ^{
        [weakself   setNotation];
        PushBikeNumVC *vc = [[PushBikeNumVC alloc]init];
        [weakself absPushViewController:vc animated:YES];

    };
    
    self.stopvc.textView.delegate   = self;
    [self setNaivTitle:@"客户服务"];
}
-(void)setNotation{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setNotationFoundation:) name:@"cheakcenter" object:nil];
    
}

-(void)setNotationFoundation :(NSNotification *)notion{
    
    [self.stopvc.cheakBtn setTitle:notion.object forState:UIControlStateNormal];
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    }


-(void)leftFoundation{
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];

    [self.navigationController   popViewControllerAnimated:YES];
}
- (void)textViewDidChange:(UITextView *)textView
{
    NSString  *nsTextContent = textView.text;
    NSInteger existTextNum = nsTextContent.length;
    
    if (existTextNum >140)
    {
        //截取到最大位置的字符
        NSString *s = [nsTextContent substringToIndex:140];
        
        [textView setText:s];
    }
    
    //不让显示负数
    self.stopvc.lenghCount.text = [NSString stringWithFormat:@"还可输入%d字",MAX(0,140 - existTextNum)
                                    ];
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text

{
    if (![text isEqualToString:@""])
    {
        self.stopvc.palceholder .hidden = YES;
    }
    if ([text isEqualToString:@""] && range.location == 0 && range.length == 1)
    {
        self.stopvc.palceholder .hidden = NO;
    }
    
    
    NSString *comcatstr = [textView.text stringByReplacingCharactersInRange:range withString:text];
    
    NSInteger caninputlen = 140 - comcatstr.length;
    
    if (caninputlen >= 0)
    {
        return YES;
    }
    else
    {
        NSInteger len = text.length + caninputlen;
        //防止当text.length + caninputlen < 0时，使得rg.length为一个非法最大正数出错
        NSRange rg = {0,MAX(len,0)};
        
        if (rg.length > 0)
        {
            NSString *s = [text substringWithRange:rg];
            
            [textView setText:[textView.text stringByReplacingCharactersInRange:range withString:s]];
        }
        return NO;
    }
    
    
    return YES;
}
-(void)setSubPhotos{
    _imagePickerController = [[UIImagePickerController alloc] init];
    _imagePickerController.delegate = self;
    _imagePickerController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    _imagePickerController.allowsEditing = YES;
}

#pragma 相机
- (void)selectImageFromCamera
{
    _imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    //录制视频时长，默认10s
    _imagePickerController.videoMaximumDuration = 15;
    
    _imagePickerController.mediaTypes = @[(NSString *)kUTTypeImage];
    
    _imagePickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
    [self presentViewController:_imagePickerController animated:YES completion:nil];
}
#pragma 相册
- (void)selectImageFromAlbum
{
    //NSLog(@"相册");
    _imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:_imagePickerController animated:YES completion:nil];
}
-(void)getPhoto {
    UIAlertController *alert =[UIAlertController alertControllerWithTitle:nil message:nil preferredStyle: UIAlertControllerStyleActionSheet];
    UIAlertAction *act1 = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self selectImageFromAlbum];
    }];
    UIAlertAction *act2 = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self selectImageFromCamera];
    }];
    UIAlertAction *act3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:act1];
    [alert addAction:act2];
    [alert addAction:act3];
    [self presentViewController:alert animated:YES completion:^{
        
    }];
}

#pragma 代理方法

//适用获取所有媒体资源，只需判断资源类型
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    NSString *mediaType=[info objectForKey:UIImagePickerControllerMediaType];
    //判断资源类型
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]){
        //  [  setImage:info[UIImagePickerControllerEditedImage] forState:UIControlStateNormal];
        //如果是图片
        UIImage * image = info[UIImagePickerControllerEditedImage];
        [self.stopvc.photoSelect setImage:image forState:UIControlStateNormal];
        //压缩图片
        //NSData *fileData = UIImageJPEGRepresentation(image, 1.0);
        
        //保存图片至相册
        //  UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
        //上传图片
        //  [self uploadImageWithData:fileData];
        
    }

    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
