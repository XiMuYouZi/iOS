//
//  ViewController.m
//  test
//
//  Created by Mia on 16/1/22.
//  Copyright © 2016年 Mia. All rights reserved.
//

#import "ViewController.h"
#import "buttonView.h"
#import "nextViewController.h"


#define Dlog(...) (NSLog(__VA_ARGS__))
#define DLog(fmt, ...) {NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);}

@interface ViewController ()
@property(nonatomic,strong)NSString *firstName;

@end

@implementation ViewController

- (void)viewDidLoad {

    [super viewDidLoad];
//    buttonView *Button=[[buttonView alloc]init];
//    [self.view addSubview:Button];
//    [Button.button addTarget:self action:@selector(log) forControlEvents:UIControlEventTouchUpInside];
   
    _firstName=@"zhang";
//    [self  setValue:@"wang" forKey:@"firstName"];
    NSLog(@"%@",[self valueForKey:@"firstName"]);
    


}



-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if (context==@"传递到viewcontroller") {
        NSLog(@"%@---%@--%@--%@",object, keyPath,change[NSKeyValueChangeNewKey],context);

    }
}

- (void)dealloc
{
    // 移除观察者
    [self removeObserver:self forKeyPath:@"musicName"];
    
}

-(void)log

{
    NSLog(@"ds");
    
    nextViewController *next=[[nextViewController alloc]init];

    [self.navigationController pushViewController:next animated:YES ];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
}

@end
