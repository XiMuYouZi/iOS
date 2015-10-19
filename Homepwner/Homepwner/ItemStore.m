
#import "ItemStore.h"
#import "ImageStore.h"


//把变量privateitems放在类扩展中声明是为了保证该变量只能被这个类使用
@interface ItemStore()
@property (nonatomic)NSMutableArray *privateItems;
@end


@implementation ItemStore

//实现itemstore里面的item位置互换功能
- (void)moveItemAtIndex:(NSInteger)fromIndex
                toIndex:(NSInteger)toIndex
{
    if (fromIndex == toIndex) {
        return;
    }
    // Get pointer to object being moved so you can re-insert it
    BNRItem *item = self.privateItems[fromIndex];
    
    // Remove item from array
    [self.privateItems removeObjectAtIndex:fromIndex];
    
    // Insert item in array at new location
    [self.privateItems insertObject:item atIndex:toIndex];
}




//从Itermstore和ImageStore中删除想用的对象
-(void)removeItem:(BNRItem *)item
{
    //如果用户删除了BNRitem对象，那么也需要删除imagestore中对应的UIImage对象
    NSString *key=item.itemKey;
    [[ImageStore shareStore]deleteImageForKey:key];
    
//    删除ItemStore中的对象
    [self.privateItems removeObjectIdenticalTo:item];
}



//sharestore的初始值是nil，程序第一次运行会创建一个itemstore对象，并将对象的内存地址赋予sharestore
//当程序再次执行无论多少次，sharestore会一直指向最初的itemstore对象的地址，并且不断在原来的基础上存储新的值
+(instancetype)shareStore
{
    
    static ItemStore *shareStore =nil;
    if (!shareStore) {
        shareStore=[[self alloc]initPrivate];
    }
    return shareStore;
}


//如果调用系统的init方法，就抛出异常
-(instancetype)init
{
    @throw [NSException exceptionWithName:@"Singleton" reason:@"use+[ItemStore shareStore" userInfo:nil];
    return nil;
}


//必须使用自定义的init方法
-(instancetype)initPrivate
{
    self=[super init];
    if (self) {
        _privateItems=[[NSMutableArray alloc]init];
    }
    return self;
}

//覆盖allitem变量的取方法
-(NSArray *)allItems
{
    return self.privateItems;
}


-(BNRItem *)createItem
{
    //调用BNRitem的类方法randomItem生成随机数组赋给变量item
    BNRItem *item=[BNRItem randonItem];
    [self.privateItems addObject:item];
    return item;
    
}



















@end
