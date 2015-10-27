
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>



@interface BNRItem : NSObject<NSCoding>

@property NSString *itemName;
@property NSString *serialNumber;
@property int valueInDollars;
@property NSDate *dateCreate;
@property (nonatomic,copy)NSString *itemKey;
@property(nonatomic,strong)UIImage *thumbnail;

-(instancetype)initWithItemName:(NSString*)name   valueInDollars:(int)value   serialNumber:(NSString*)sNumber;
-(instancetype) initWithItemName:(NSString *)name ;
+(instancetype) randonItem;
-(void)setThumbnailFromImage:(UIImage *)image;



@end
