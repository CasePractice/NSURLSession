//
//  ViewController.m
//  Session
//
//  Created by mac on 16/5/9.
//  Copyright © 2016年 zhiYou. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    __weak IBOutlet UIButton *vc_button;
    UIImagePickerController*IPC;
    UIImageView*imageView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    imageView=[UIImageView new];
    IPC=[UIImagePickerController new];
    IPC.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    IPC.delegate=self;
    IPC.allowsEditing=YES;
}
#pragma mark-UIImagePickerControllerDelegate代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    imageView.image=[info objectForKey: UIImagePickerControllerEditedImage];
    [vc_button setBackgroundImage:imageView.image forState:UIControlStateNormal];
    [vc_button setTitle:nil forState:UIControlStateNormal];
    [IPC dismissViewControllerAnimated:YES completion:nil];
}
//更换图片按钮
- (IBAction)gengHuanTuPianAnNiu:(UIButton *)sender
{
    [self presentViewController:IPC animated:YES completion:nil];
}
//保存方法按钮
- (IBAction)baoCunAnNiu:(UIButton *)sender
{
    if (imageView.image)
    {
        NSData*data=UIImagePNGRepresentation(imageView.image);
        NSURL*url=[NSURL URLWithString:@"http://localhost:8080/UploadFileServer/up"];
        NSMutableURLRequest*request=[NSMutableURLRequest requestWithURL:url];
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:data];
        NSURLSession*seession=[NSURLSession sharedSession];
        NSURLSessionUploadTask*SUT=[seession uploadTaskWithStreamedRequest:request];
        [SUT resume];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
