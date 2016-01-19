//
//  TomAndJerryEpisode.m
//  weChat
//
//  Created by Mia on 16/1/15.
//  Copyright © 2016年 Mia. All rights reserved.
//

#import "TomAndJerryEpisode.h"


@implementation TomAndJerryEpisode


-(void)TomsendMessageToFriends
{
    self.client=[[AVIMClient alloc]init];

    [self.client openWithClientId:@"Tom" callback:^(BOOL succeeded, NSError *error) {
        NSArray *frieds=@[@"Jerry",@"Bob",@"Harry",@"William"];
        [self.client createConversationWithName:@"Tom and Friends" clientIds: frieds callback:^(AVIMConversation *conversation, NSError *error) {
            [conversation sendMessage:[AVIMTextMessage messageWithText:@"我是tom，你们在哪里？" attributes:nil] callback:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    NSLog(@"Tom的群聊消息发送成功");
                }
            }];
        }];
    }];
}


-(void)BobsendMessageToFriends
{
    self.client=[[AVIMClient alloc]init];

    [self.client openWithClientId:@"Bob" callback:^(BOOL succeeded, NSError *error) {
        NSArray *frieds=@[@"Jerry",@"Bob",@"Harry",@"William"];
        [self.client createConversationWithName:@"Tom and Friends" clientIds: frieds callback:^(AVIMConversation *conversation, NSError *error) {
            [conversation sendMessage:[AVIMTextMessage messageWithText:@"我是Bob，你们在哪里？" attributes:nil] callback:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    NSLog(@"Bob的群聊消息发送成功");
                }
            }];
        }];
    }];
}


- (void)BobReceiveMessageFromFriends
{
    self.client.delegate = self;
    [self.client openWithClientId:@"Bob" callback:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"Bob接受群聊消息成功");
        }
    }];
}

- (void)TomReceiveMessageFromFriends {
    self.client.delegate = self;
    [self.client openWithClientId:@"Tom" callback:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"tom接受群聊消息成功");
        }

    }];
}

- (void)HarryReceiveMessageFromFriends {
    self.client = [[AVIMClient alloc] init];
    self.client.delegate = self;
    [self.client openWithClientId:@"Harry" callback:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"harry接受群聊消息成功");
        }

    }];
}


#pragma mark - AVIMClientDelegate

- (void)conversation:(AVIMConversation *)conversation didReceiveTypedMessage:(AVIMTypedMessage *)message
{
    self.viewcontroller=[[ViewController alloc]init];
    _viewcontroller.textview.text=message.text;
    NSLog(@"%@",message.text);

}


-(void)jerryReceiveMessageFromTom
{
    _client=[[AVIMClient alloc]init];
    self.client.delegate=self;

    [self.client openWithClientId:@"Jerry" callback:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"Jerry接受消息成功");
        }
    }];
}


-(void)tomSendMessageToJerry
{
    [self.client openWithClientId:@"tom" callback:^(BOOL succeeded, NSError *error) {
        [self.client createConversationWithName:@"tom和jerry的单聊" clientIds:@[@"Jerry"] callback:^(AVIMConversation *conversation, NSError *error) {
            [conversation sendMessage:[AVIMTextMessage messageWithText:@"耗子，我今天一定要抓到你" attributes:nil] callback:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    NSLog(@"tom发送消息成功");
                }
            }];
        }];
    }];
}

@end
