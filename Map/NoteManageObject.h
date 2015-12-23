//
//  NoteManageObject.h
//  
//
//  Created by Mia on 15/12/21.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface NoteManageObject : NSManagedObject

@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSDate * date;
@property(nonatomic,strong)NSManagedObjectModel *model;

@end
