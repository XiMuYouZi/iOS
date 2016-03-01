//
//  main.m
//  command-test
//
//  Created by Mia on 16/1/31.
//  Copyright © 2016年 Mia. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        dispatch_queue_t queue1= dispatch_queue_create("并行队列", DISPATCH_QUEUE_CONCURRENT);
        dispatch_queue_t queue11= dispatch_queue_create("并行队列", DISPATCH_QUEUE_CONCURRENT);
        
        dispatch_queue_t queue2= dispatch_queue_create("串行行队列", DISPATCH_QUEUE_SERIAL);
        dispatch_queue_t queue22= dispatch_queue_create("串行行队列", DISPATCH_QUEUE_SERIAL);
        
        
        dispatch_async(queue1, ^{
            //        小任务2
            NSLog(@"1---%@",[NSThread currentThread]);
        });
        dispatch_async(queue1, ^{
            //        小任务2
            
            static int num = 0;
            for (int i = 0; i < 1111111111; i++) {
                num+=i;
            }
            NSLog(@"2---%@",[NSThread currentThread]);
        });
        
        dispatch_async(queue1, ^{
            //        小任务2
            NSLog(@"3---%@",[NSThread currentThread]);
        });
        dispatch_async(queue1, ^{
            //        小任务2
            NSLog(@"4---%@",[NSThread currentThread]);
        });

    }
    return 0;
}
