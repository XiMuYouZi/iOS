//
//  QuizViewController.m
//  Quiz
//
//  Created by Mia on 15/9/14.
//  Copyright (c) 2015年 Mia. All rights reserved.
//

#import "QuizViewController.h"
#import "myframework.h"

@interface QuizViewController ()
@property (nonatomic,weak) IBOutlet UILabel *questionLabel;
@property (nonatomic,weak) IBOutlet UILabel *answerLabel;
@property(nonatomic)int currentQuestionIndex;
@property(nonatomic,copy)NSArray *questions;
@property(nonatomic,copy)NSArray *answers;




@end

@implementation QuizViewController

-(IBAction)ShowQuestion:(id)sender
{
    self.currentQuestionIndex++;
    if(self.currentQuestionIndex==[self.questions count])
    {
        self.currentQuestionIndex=0;
    }
    
    NSString *question=self.questions[self.currentQuestionIndex];
    self.questionLabel.text=question;
    self.answerLabel.text=@"???";
}




-(IBAction)showAnswer:(id)sender
{
    NSString *answer=self.answers[self.currentQuestionIndex];
    self.answerLabel.text=answer;
    
    
}



-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self){
        self.questions=@[@"from what is cognac made?",
                        @"what is 7+7?",
                        @"what is the capital of vermont?"];
        self.answers=@[
                       @"garpes",
                       @"14",
                       @"montpelier"];
        
    }
    return self;
}


@end
