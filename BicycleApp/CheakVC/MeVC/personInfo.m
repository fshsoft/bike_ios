//
//  personInfo.m
//  BicycleApp
//
//  Created by 雨停 on 2017/5/8.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "personInfo.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "personInfoCell.h"
#import "ChangeName.h"
#import "ChangePhoneNumberVC.h"
@interface personInfo ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic,strong)  UIImagePickerController *imagePickerController;
@property (nonatomic,strong) UITableView *tabView;
@property (nonatomic,strong) NSMutableArray *arrTitle;
@property (nonatomic,strong) NSMutableArray *arrInfo;
@property (nonatomic,strong)UIImage  * photo;
@property (nonatomic,copy)  NSString * name;
@end

@implementation personInfo

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSubPhotos];
    self.title  =@"个人中心";
    [self initUI];
    // Do any additional setup after loading the view.
}
-(void)leftFoundation{
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)initUI{
    
    self.tabView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREENH_HEIGHT-64) style:UITableViewStylePlain];
    self. tabView.delegate = self;
    
    self.tabView.backgroundColor =gary221;
    self.tabView.dataSource = self;
    self.tabView.bounces =NO;
    self.tabView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tabView];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.arrTitle.count;
}
-(NSMutableArray *)arrTitle{
    if(!_arrTitle){
        _arrTitle = [NSMutableArray arrayWithObjects:@"头像",@"昵称",@"姓名",@"实名认证",@"手机号", nil];
    }
    return _arrTitle;
}
-(NSMutableArray *)arrInfo{
    if(!_arrInfo){
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *path = [paths objectAtIndex:0];
        NSString *name = [[NSString alloc]init];
        NSString *phone = [[NSString alloc]init];
        NSString *IDname = [[NSString alloc]init];
        NSString * cheak = [[NSString alloc]init];
        //设置一个图片的存储路径
        if([DB getStringById:@"name" fromTable:tabName]){
            name = [DB getStringById:@"name" fromTable:tabName];
        }else{
            name=@"小樱";
        }
        NSString *imagePath = [path stringByAppendingString:@"/pic.png"];
        if([DB getStringById:@"truename" fromTable:tabName]){
            IDname = [DB getStringById:@"truename" fromTable:tabName];
        }else{
            IDname =@"小樱单车";
        }
        if([DB getStringById:@"phone" fromTable:tabName]){
            phone =[DB getStringById:@"phone" fromTable:tabName];
        }else{
            phone =@"";
        }
        
        if([DB getStringById:@"certify" fromTable:tabName]){
            cheak =@"已认证";
            
        }else{
            cheak =@"未认证";

        }
        _arrInfo = [NSMutableArray arrayWithObjects:imagePath,name,IDname,cheak,phone, nil];
    }
    return _arrInfo;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==0){
        return 60;
    }
    return 40;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self setNotation];
    if(indexPath.row==0){
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (status == AVAuthorizationStatusDenied || status == AVAuthorizationStatusRestricted) {
            Toast(@"请允许app访问你的相机和相册");
        } else {
            [self getPhoto];
        }

      
    }else if(indexPath.row==1){
        ChangeName *nameVc = [[ChangeName alloc]init];
        nameVc.arr = self.arrInfo;
        nameVc.tag=indexPath.row;
    [self absPushViewController:nameVc animated:YES];
        
    }else if(indexPath.row==4){
        ChangePhoneNumberVC *vc = [[ChangePhoneNumberVC alloc]init];
        vc.arr = self.arrInfo;
        vc.tag=indexPath.row;
        
        [self absPushViewController:vc animated:YES];
    }else{
        
    }
}
-(void)setNotation{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setNotationFoundation:) name:@"personcenter" object:nil];
    
}

-(void)setNotationFoundation :(NSNotification *)notion{

    self.arrInfo =notion.object;
    [self.tabView reloadData];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId =@"cellID";
    personInfoCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if(cell==nil){
        cell =[[ personInfoCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
      }
     cell.title.text=self.arrTitle[indexPath.row];
     cell.detailtitle.text =self.arrInfo[indexPath.row];
    if(indexPath.row==0){
        cell.personPhoto.hidden=NO;
        cell.detailtitle.hidden =YES;
        cell.personPhoto.image= [UIImage imageWithContentsOfFile:self.arrInfo[0]];
    }
    if(indexPath.row==2){
        cell.prompt.hidden =YES;
        cell.detailtitle.hidden =YES;
        cell.unselectedLab.text =self.arrInfo[2];
        cell.unselectedLab.hidden =NO;
    }
    if(indexPath.row==3){
        cell.prompt.hidden =YES;
        cell.detailtitle.hidden =YES;
        cell.unselectedLab.text =self.arrInfo[3];
        cell.unselectedLab.hidden =NO;
    }

    return  cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    //相机类型（拍照、录像...）字符串需要做相应的类型转换
    //_imagePickerController.mediaTypes = @[(NSString *)kUTTypeMovie,(NSString *)kUTTypeImage];
    _imagePickerController.mediaTypes = @[(NSString *)kUTTypeImage];
    //视频上传质量
    //UIImagePickerControllerQualityTypeHigh高清
    //UIImagePickerControllerQualityTypeMedium中等质量
    //UIImagePickerControllerQualityTypeLow低质量
    //UIImagePickerControllerQualityType640x480
    // _imagePickerController.videoQuality = UIImagePickerControllerQualityTypeHigh;
    
    //设置摄像头模式（拍照，录制视频）为录像模式
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
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *path = [paths objectAtIndex:0];
        //设置一个图片的存储路径
        NSString *imagePath = [path stringByAppendingString:@"/pic.png"];
        //把图片直接保存到指定的路径（同时应该把图片的路径imagePath存起来，下次就可以直接用来取）
        [UIImagePNGRepresentation(image) writeToFile:imagePath atomically:YES];
        [self.tabView reloadData];
       
        //压缩图片
        //NSData *fileData = UIImageJPEGRepresentation(image, 1.0);
        
        //保存图片至相册
        //  UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
        //上传图片
        //  [self uploadImageWithData:fileData];
        
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    //移除通知
    //«\\[[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
