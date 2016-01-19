//
//  ViewController.m
//  weChat
//
//  Created by Mia on 16/1/15.
//  Copyright © 2016年 Mia. All rights reserved.
//

#import "ViewController.h"
#import <AVOSCloud/AVOSCloud.h>
#import <AVOSCloudIM.h>
#import "TomAndJerryEpisode.h"


@interface ViewController ()
@property(nonatomic,strong)AVIMClient *client;
@property(nonatomic)TomAndJerryEpisode *TomAndJerry;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.TomAndJerry=[[TomAndJerryEpisode alloc]init];

    
}



- (IBAction)JerryReceiveMessageFromTom:(id)sender {
    [self.TomAndJerry jerryReceiveMessageFromTom];

}



- (IBAction)tomSendMessageToJerry:(id)sender {
    [self.TomAndJerry tomSendMessageToJerry];

}


- (IBAction)Tomfriends:(id)sender {
    [self.TomAndJerry TomsendMessageToFriends];
}

- (IBAction)BobToFriends:(id)sender {
    [self.TomAndJerry BobsendMessageToFriends];
}

- (IBAction)tomReceiveFriends:(id)sender {
    [self.TomAndJerry TomReceiveMessageFromFriends];
}

- (IBAction)HerryReceiveFriends:(id)sender {
    [self.TomAndJerry HarryReceiveMessageFromFriends];
}






-(id)init
{
    self=[super init];
    if (self) {
        self.client=[[AVIMClient alloc]init];

    }
    return self;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
