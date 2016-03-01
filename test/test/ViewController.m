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
    dispatch_queue_t queue1= dispatch_queue_create("并行队列", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t queue2= dispatch_queue_create("串行队列", DISPATCH_QUEUE_SERIAL);
    
//    大任务1
    NSLog(@"1---%@",[NSThread currentThread]);
    
//    大任务2
    dispatch_sync(queue2, ^{
//        小任务2
        NSLog(@"2---%@",[NSThread currentThread]);
        
    
//        小任务3
        dispatch_sync(queue2, ^{
//            小小任务33
            static int num = 0;
            for (int i = 0; i < 10; i++) {
                num+=i;
                NSLog(@"小小任务33：%d---%@", num,[NSThread currentThread]);
            }
            

        });
        
//        小任务4
        static int num = 0;
        for (int i = 0; i < 10; i++) {
            num+=i;
            NSLog(@"小任务4：%d---%@", num,[NSThread currentThread]);
            
        }
    });
    
//     大任务3
    static int num = 0;
    for (int i = 0; i < 10; i++) {
        num+=i;
        NSLog(@"大任务3：%d---%@", num,[NSThread currentThread]);
        
    }



    
    
    
    
//    任务一
    dispatch_async(queue2, ^{
            NSLog(@"%@---%d",[NSThread currentThread],1);
            NSLog(@"%@---%d",[NSThread currentThread],2);
            NSLog(@"%@---%d",[NSThread currentThread],3);
        });

    
//    任务三
    dispatch_async(queue2, ^{
        NSLog(@"%@---%d",[NSThread currentThread],5);
        NSLog(@"%@---%d",[NSThread currentThread],6);
        NSLog(@"%@---%d",[NSThread currentThread],7);

    });
    
    //    任务二
    dispatch_async(queue2, ^{
        NSLog(@"%@---%d",[NSThread currentThread],8);
        NSLog(@"%@---%d",[NSThread currentThread],9);
        
    });


//

    
}



-(void)printlog
{
    NSLog(@"dsd");
}
-(void)printName:(NSString *)name
{
    NSAssert(name==nil, @"name is not allowed null");
    NSLog(@"%@",name);
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

}

- (void)getseil:(NSInteger)num {
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
}

@end
