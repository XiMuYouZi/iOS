//
//  TomAndJerryEpisode.h
//  weChat
//
//  Created by Mia on 16/1/15.
//  Copyright © 2016年 Mia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVOSCloud/AVOSCloud.h>
#import <AVOSCloudIM.h>
#import "ViewController.h"



@interface TomAndJerryEpisode : NSObject<AVIMClientDelegate>
@property(nonatomic)ViewController *viewcontroller;

@property(nonatomic,strong)AVIMClient *client;
-(void)tomSendMessageToJerry;
-(void)jerryReceiveMessageFromTom;
-(void)TomsendMessageToFriends;
-(void)BobsendMessageToFriends;
- (void)BobReceiveMessageFromFriends;
- (void)TomReceiveMessageFromFriends;
- (void)HarryReceiveMessageFromFriends;


@end
