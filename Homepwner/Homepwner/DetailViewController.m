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
#import "ItemStore.h"
#import "AssetTypeViewController.h"

@interface DetailViewController ()<UINavigationBarDelegate,UIImagePickerControllerDelegate,UITextFieldDelegate,UIPopoverControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *serialNumberField;
@property (weak, nonatomic) IBOutlet UITextField *valueField;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cameraButton;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property(strong,nonatomic)UIPopoverController *imagePickerPopover;

@property(weak,nonatomic)IBOutlet UILabel *nameLabel;
@property(weak,nonatomic)IBOutlet UILabel *serialNumberLabel;
@property(weak,nonatomic)IBOutlet UILabel * valueLabel;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *assetTypeButton;
@end

@implementation DetailViewController

//点击assetType按钮显示分类页面
- (IBAction)showAssetTypePicker:(id)sender {
    [self.view endEditing:YES];
    
    AssetTypeViewController *avc=[[AssetTypeViewController alloc]init];
    avc.item=self.item;
    [self.navigationController pushViewController:avc animated:YES];

}

//调整label和text的文字大小
-(void)updateFonts
{
    UIFont *font=[UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    self.nameLabel.font=font;
    self.serialNumberLabel.font=font;
    self.valueLabel.font=font;
    self.dateLabel.font=font;
    self.nameField.font=font;
    self.serialNumberField.font=font;
    self.valueField.font=font;
}

//实现新的初始化方法，当用户点击tableview界面的添加按钮，DetailViewController就会以模态形式推出一个添加页面
-(instancetype)initForNewItem:(BOOL)isNew
{
    self=[super initWithNibName:nil bundle:nil];
    if (self) {
        if (isNew) {
            UIBarButtonItem *doneItem=[[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                       target:self
                                       action:@selector(save:)];
            self.navigationItem.leftBarButtonItem=doneItem;
            
            UIBarButtonItem *cancelItem=[[UIBarButtonItem alloc]
                                         initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                         target:self
                                         action:@selector(cancel:)];
            self.navigationItem.rightBarButtonItem=cancelItem;
        }
//        用户修改了字体大小之后，引用会受到UIContentSizeCategoryDidChangeNotification通知，可以注册为该通知的接受者，那么当用户改变字体之后，就可以执行一些动作
//        比如调用updatefonts方法来实现在设置里面修改了字体大小，马上就修改DetailViewController界面的控件的字体大小
        NSNotificationCenter *defaultCenter=[NSNotificationCenter defaultCenter];
        [defaultCenter addObserver:self selector:@selector(updateFonts) name:UIContentSizeCategoryDidChangeNotification object:nil];
    }
    return self;
}



-(void)dealloc
{
    NSNotificationCenter *defaultCenter=[NSNotificationCenter defaultCenter];
    [defaultCenter removeObserver:self];
}

// 禁用父类的初始化方法
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    @throw [NSException exceptionWithName:@"wrong initializer" reason:@"use initForItem" userInfo:nil];
    return nil;
}


//实现done按钮的功能（P333)
-(void)save:(id)sender
{
//    completion后面跟的是一个block对象指针，指向的是itemsviewcontroller页面定义的一个block对象，该对象用于刷新tableview
//    这句话的作用：当用户点击save按钮保存的时候，就调用dismissblock属性，该属性指向itemsviewcontroller的一个block对象，该block对象负责刷新tableview
//    所以当用户点击save按钮的时候就刷新了tableview。
    [self.presentingViewController dismissViewControllerAnimated:YES completion:self.dismissBlock];
}


//实现cancle按钮功能
-(void)cancel:(id)sender
{
    [[ItemStore sharedStore]removeItem:self.item];
//    属性presentingVieeController：The view controller that presented this view controller. (read-only)
//    completion后面跟的是一个block对象指针，指向的是itemsviewcontroller页面定义的一个block对象，该对象用于刷新tableview
    [self.presentingViewController dismissViewControllerAnimated:YES completion:self.dismissBlock];
}

/*-------------------------------------------------------------------------------------------------------------------------------------------*/

#pragma keyboardAction - view life cycle

//如果设备是iPhone，那么当设备处于横向界面，就隐藏imageview和toolbar，如果是ipad就不进行此操作
-(void)preparViewForOrientation:(UIInterfaceOrientation)orientation
{
    if ([UIDevice currentDevice].userInterfaceIdiom==UIUserInterfaceIdiomPad)
    {
        return;
    }
    
/*   判断设备是否处于横向位置
    static inline BOOL UIInterfaceOrientationIsLandscape(UIInterfaceOrientation orientation) {
        return ((orientation) == UIInterfaceOrientationLandscapeLeft || (orientation) == UIInterfaceOrientationLandscapeRight);
    }
*/
    if (UIInterfaceOrientationIsLandscape(orientation)) {
        self.imageView.hidden=YES;
        self.cameraButton.enabled=NO;
    }else{
        self.imageView.hidden=NO;
        self.cameraButton.enabled=YES;
    }
}


//当界面旋转到新的方向就执行上面的preparVieworientation方法，第一个参数表示新的界面方向
    -(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
     
        [self preparViewForOrientation:toInterfaceOrientation];
    }

/*
创建一个新的imageview覆盖原来的imageview
-(void)viewDidLoad
{
    [super viewDidLoad];
    UIImageView *iv =[[UIImageView alloc]initWithImage:nil];
    iv.contentMode=UIViewContentModeScaleAspectFit;
    iv.translatesAutoresizingMaskIntoConstraints=NO;
    [self.view addSubview:iv];
    self.imageView=iv;


    [self.imageView setContentHuggingPriority:200 forAxis:UILayoutConstraintAxisVertical];
    [self.imageView setContentCompressionResistancePriority:700 forAxis:UILayoutConstraintAxisVertical];
    
使用VFL语言写约束
    NSDictionary *nameMap=@{@"imageView":self.imageView,
                            @"dateLable":self.dateLabel,
                            @"toolbar":self.toolbar};
    
    NSArray *horizatalContraints=[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[imageView]-0-|"
                                                                         options:0
                                                                         metrics:nil
                                                                           views:nameMap];
    
    NSArray *verticalContraints=[NSLayoutConstraint constraintsWithVisualFormat:@"V:[dateLable]-8-[imageView]-8-[toolbar]"
                                                                        options:0 metrics:nil
                                                                          views:nameMap];
    
    
    把约束添加到父视图也即是DetailViewController中
    [self.view addConstraint:horizatalContraints];
    [self.view addConstraint:verticalContraints];
 
    
    
}
 */



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
    
//    创建选择照片的缩略图
    [self.item setThumbnailFromImage:image];
    
    //用itemkey作为键值，把照片存入imagestore中
    [[ImageStore shareStore]setImage:image forKey:self.item.itemKey];
    
    
    self.imageView.image=image;
    
    //关闭imagepickercontroller
//    [self dismissViewControllerAnimated:YES completion:nil];
    
    //当用户选择了照片之后也要释放popovercontroller对象
//    当UIPopoverController对象存在就释放掉
    if (self.imagePickerPopover) {
        [self.imagePickerPopover dismissPopoverAnimated:YES];
        self.imagePickerPopover=nil;
    }else{
//        关闭用模态形式显示的UIImagePickerController对象
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
    
}



//实现imagepickercontroller的sourcetype属性，让用户选择照片，如果是ipad就用popovercontroller显示照片选择界面，否则使用模态显示
- (IBAction)takePicture:(id)sender {
    UIImagePickerController *imagePicker=[[UIImagePickerController alloc]init];
    //如果设备支持相机，就使用拍照模式，否则让用户从照片库中选择
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePicker.sourceType=UIImagePickerControllerSourceTypeCamera;
    }else{
        imagePicker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    }
    imagePicker.delegate=self;
    
//    创建UIPopoverController对象之前先检查设备是否是ipad
    if ([UIDevice currentDevice].userInterfaceIdiom==UIUserInterfaceIdiomPad )
    {
//        创建UIPopoverController用于显示UIImagePickerController对象
        self.imagePickerPopover=[[UIPopoverController alloc]initWithContentViewController:imagePicker];
        self.imagePickerPopover.delegate=self;
//        显示UIPopoverController对象，sender指向代表相机按钮的UIBarButtonItem对象
        [self.imagePickerPopover presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }else{
//        如果不是iPad，就用模态显示imagePicker
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
    
/*解决当用户连续点击两次拍照按钮程序崩溃的问题（但是我测试的时候没有出现这个问题,而且加了这些代码之后
 点击拍照按钮uipopovercontroller一闪就消失了）
    if ([self.imagePickerPopover isPopoverVisible]) {
        [self.imagePickerPopover dismissPopoverAnimated:YES];
        self.imagePickerPopover=nil;
        return;
    }*/
    
}


//点击屏幕其他区域关闭UIPopoverController之后，会向其委托对象发送popovercontrollerDidDismissPopover消息，
//可以在这个消息中实现当用户点击屏幕其他区域就释放popovercontroller对象
-(void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController{
    NSLog(@"User dismissed popover");
    self.imagePickerPopover=nil;
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
    
    UIInterfaceOrientation io=[[UIApplication sharedApplication]statusBarOrientation];
    [self preparViewForOrientation:io];
    
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
    
    self.dateLabel.text=[dateFormatter stringFromDate:item.dateCreated];
    
    
    //当用户点击tableview的某个表格行进入detailviewcontroller的时候显示图片
    NSString *itemKey=self.item.itemKey;
    UIImage *imageToDisplay=[[ImageStore shareStore]imageForKey:itemKey];
    self.imageView.image=imageToDisplay;
    
//    调用BNRItem对象item的属性assetType,该属性属于的NSManagedObject，表示的是BNRItem实体BNRAssetType
//    实体之间的一对多的关系,使用label作为key调用BNRassetType实体的label属性
    NSString *typeLabel = [self.item.assetType valueForKey:@"label"];
    if (!typeLabel) {
        typeLabel = @"None";
    }
    
    self.assetTypeButton.title = [NSString stringWithFormat:@"Type: %@", typeLabel];

    [self updateFonts];

    
}

@end
