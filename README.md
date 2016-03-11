# IOS-WFAsyncHttp
  
  此请求框架主要封装了ios的Http请求，适配了ios9请求，当然，此框架还提供设置请求头。最重要的是还提供了缓存策略，目前只提供四种。还有封装了网页缓存功能，和图片缓存功能。
具体使用如下：
    
    注意
      1. 所有的请求都必须传入URLString，以及成功|失败回调，其它参数根据需要引入
      2. 缓存策略：
          typedef NS_ENUM(NSUInteger,WFStorageCachePolicy)
          {
              WFStorageCachePolicyType_Default,                     // *** 不提供缓存
              WFStorageCachePolicyType_ReturnCache_ElseLoad,        // ***如果有缓存则返回缓存不加载网络，否则加载网络数据并且缓存数据
              WFStorageCachePolicyType_ReturnCache_DontLoad,        // *** 如果有缓存则返回缓存并且不加载网络
              WFStorageCachePolicyType_ReturnCache_DidLoad,         // *** 如果有缓存则返回缓存并且都加载网络
              WFStorageCachePolicyType_ReturnCacheOrNil_DidLoad,    // *** 如果有缓存则返回缓存,没有缓存就返回空的,并且都加载网络
              WFStorageCachePolicyType_Reload_IgnoringLocalCache,   // *** 忽略本地缓存并加载 （使用在更新缓存）
          };

          #pragma mark - 内存缓存策略
          typedef NS_ENUM(NSUInteger,WFMemCachePolicy)
          {
              WFMemCachePolicyType_Default,                     // *** 不提供缓存
              WFMemCachePolicyType_ReturnCache_ElseLoad,        // *** 如果内存有缓存缓存不加载网络，否则加载网络数据并且缓存数据
              WFMemCachePolicyType_Reload_IgnoringLocalCache,   // *** 忽略内存缓存并加载 （使用在更新缓存）
          };
    
一：引入WFAsyncHttp.h
  
    1. GET异步请求
    
     [WFRequestManager GET_UsingMemCache_WithURLString:@"http://imgsrc.baidu.com/baike/pic/item/b13fd4808a7d68eb9123d9a7.jpg"
                                            andHeader:nil
                                         andUserAgent:nil
                                     andStoragePolicy:WFStorageCachePolicyType_Default
                                        andExpireTime:10 // 设置内存缓存时间10秒
                                    andMemCachePolicy:WFMemCachePolicyType_ReturnCache_ElseLoad
                                           andSuccess:^id(id responseDate, NSURLResponse *response, WFDataFromType fromType)
    {
        NSTimeInterval time = [[NSDate date] timeIntervalSinceDate:self.startDate];
        
        NSString *timeText = [NSString stringWithFormat:@"用时 ：%f",time];
        
        NSLog(@"======== 第%2d次请求用时： %@",index,  timeText);
        index ++;
        
        self.view.userInteractionEnabled = YES;
        
        return responseDate; // 返回要缓存的数据, 如果是json数据，请处理后的数据返回来

    } andFailure:^(NSError *error) {
        
    }];
  
    2. POST异步请求
   
     [WFRequestManager POST_UsingMemCache_WithURLString:@"http://imgsrc.baidu.com/baike/pic/item/b13fd4808a7d68eb9123d9a7.jpg"
                                             andHeader:nil
                                          andUserAgent:nil
                                              andParam:nil
                                         andExpireTime:60 * 10
                                        andCachePolicy:WFMemCachePolicyType_ReturnCache_ElseLoad andSuccess:^id(id responseDate, NSURLResponse *response, BOOL isCache)
    {
        return responseDate;
    } andFailure:^(NSError *error)
    {
        
    }];
    
   

二. 网页缓存功能：只需三步操作就可以了（1-》设置缓存， 2-》加载网页数据， 3-》给webview设置数据），是不是so easy

    1. 在appdelegate didFinishLaunchingWithOptions这个 方法加入 [WFAsyncURLCache setURLCache];
    2. 请求网页数据
       [WFRequestManager GET_UsingMemCache_WithURLString:@"http://www.baidu.com"
                                            andHeader:nil
                                         andUserAgent:nil
                                        andExpireTime:10 // 设置内存缓存时间10秒
                                       andCachePolicy:WFMemCachePolicyType_ReturnCache_ElseLoad
                                           andSuccess:^id(id responseData, NSURLResponse *response, BOOL isCache)
     {
        
         
         NSTimeInterval time = [[NSDate date] timeIntervalSinceDate:self.startDate];
         
         dispatch_async(dispatch_get_main_queue(), ^{
             NSString *timeText = [NSString stringWithFormat:@"用时 ：%f",time];
             
             NSLog(@"======== 第%2d次请求用时： %@",index,  timeText);
             index ++;
             
             self.view.userInteractionEnabled = YES;
         });
         
         return responseData; // 返回要缓存的数据, 如果是json数据，请处理后的数据返回来
    } andFailure:^(NSError *error) {
        
    }];
    
三：性能测试

          2016-03-10 14:21:49.724 WFAsyncHttp[29786:1571275] ======== 第 1次请求用时： 用时 ：0.035650
          2016-03-10 14:21:51.457 WFAsyncHttp[29786:1571275] ======== 第 2次请求用时： 用时 ：0.000020
          2016-03-10 14:21:52.808 WFAsyncHttp[29786:1571275] ======== 第 3次请求用时： 用时 ：0.000009
          第二次以后的请求都比第一次高好几百倍

    
