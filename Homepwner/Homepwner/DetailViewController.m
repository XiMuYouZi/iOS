//
//  DetailViewController.m
//  Homepwner
//
//  Created by Mia on 15/10/19.
//  Copyright (c) 2015年 Mia. All rights reserved.
//

#import "DetailViewController.h"
#import "BNRItem.h"
#import "ImageStore.h"

@interface DetailViewController ()<UINavigationBarDelegate,UIImagePickerControllerDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *serialNumberField;
@property (weak, nonatomic) IBOutlet UITextField *valueField;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@end

@implementation DetailViewController

#pragma keyboardAction - view life cycle


//当用户点击textfield以外的屏幕区域时也可以关闭键盘
- (IBAction)backgroundTapped:(id)sender {
    [self.view endEditing:YES];
}


//当用户按下键盘的return键就关闭键盘
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}



#pragma mark - imageAction

//实现imagePickerController的委托的方法，在detailviewcontroller界面把用户选择的照片赋予imageview来显示
//当uiimagePickerController选择了一张照片，委托就会收到imagePickerControll:didFinishPickingMediaWithInfo:消息
//委托是需要获取照片的对象，也即是DetailViewControllerR
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //通过info字典选择用户点击的照片
    UIImage *image=info[UIImagePickerControllerOriginalImage];
    
    //用itemkey作为键值，把照片存入imagestore中
    [[ImageStore shareStore]setImage:image forKey:self.item.itemKey];
    
    
    self.imageView.image=image;
    
    //关闭imagepickercontroller
    [self dismissViewControllerAnimated:YES completion:nil];
    
}





//实现imagepickercontroller的sourcetype属性，让用户选择照片
- (IBAction)takePicture:(id)sender {
    UIImagePickerController *imagePicker=[[UIImagePickerController alloc]init];
    //如果设备支持相机，就使用拍照模式，否则让用户从照片库中选择
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePicker.sourceType=UIImagePickerControllerSourceTypeCamera;
    }else{
        imagePicker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    }
    imagePicker.delegate=self;
    [self presentViewController:imagePicker animated:YES completion:nil];
}



#pragma mark -  操作导航栏
//为detailviewcontroller设置navigation标题，修改默认的item的设置方法，加上显示导航标题的功能，因为只有在这个时候item属性才不是nil
-(void)setItem:(BNRItem *)item
{
    _item=item;
    self.navigationItem.title=_item.itemName;
}



#pragma mark - viewAction

//修改了BNRitem对象的属相之后，点击back按钮，显示修改后的tableview的表格行显示的内容
//调用viewwilldisppear消息在关闭detailviewcontroller之前把修改了的textfield
//赋给相应地BNRitem属性
-(void)viewWillDisappear:(BOOL)animated
{
    //detailviewcontroller继承自viewcontroller类，那么也会继承viewcontroller
    //类的所有方法，包括viwewilldisppear，在这里我们要覆盖该方法来增加我们自己的功能
    //但是又要使用父类viewcontroller的viewwilldisappear方法的已有功能
    //那么就可以先调用父类的viewWillDisappear方法来继承该方法的所有功能，然后再在下面实现我们自己的功能
    [super viewWillDisappear:animated];
    
    //关闭键盘
    [self.view endEditing:YES];
    
    BNRItem *item=self.item;
    item.itemName=self.nameField.text;
    item.serialNumber=self.serialNumberField.text;
    item.valueInDollars=[self.valueField.text intValue];
    
    
    
}



//将BNRitem对象的各个属性赋给相应的textfield控件
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    BNRItem *item=self.item;
    
    self.nameField.text=item.itemName;
    self.serialNumberField.text=item.serialNumber;
    self.valueField.text=[NSString stringWithFormat:@"%d",item.valueInDollars];
    //把nsdate对象转化成简单的日期字符串
    static NSDateFormatter *dateFormatter =nil;
    if(!dateFormatter){
        dateFormatter=[[NSDateFormatter alloc]init];
        dateFormatter.dateStyle=NSDateIntervalFormatterMediumStyle;
        dateFormatter.timeStyle=NSDateFormatterNoStyle;
    }
    
    self.dateLabel.text=[dateFormatter stringFromDate:item.dateCreate];
    
    
    //当用户点击tableview的某个表格行进入detailviewcontroller的时候显示图片
    NSString *itemKey=self.item.itemKey;
    UIImage *imageToDisplay=[[ImageStore shareStore]imageForKey:itemKey];
    self.imageView.image=imageToDisplay;

    
}

@end
