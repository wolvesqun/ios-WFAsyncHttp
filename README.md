# IOS-WFAsyncHttp
  
  此请求框架主要封装了IOS的Http请求，封装了同步请求（WFSyncHttpClient.h）与异步请求(WFAsyncHttpManager.h |          WFAsyncHttpClient.h)，两种请求方式都有POST请求和GET请求,其中WFAsyncHttpClient.h还封装了系统的请求（系统请求是采取队列方式），
当然，此框架还提供设置请求头。最重要的是还提供了缓存策略，目前只提供也三种。具体使用如下：

    注意所有的请求都必须传入URLString，以及成功|失败回调，其它参数根据需要引入
    缓存策略：
    1. WFAsyncCachePolicyType_Default = 0, // *** 不提供缓存
    2. WFAsyncCachePolicyType_ReturnCache_DontLoad = 1, // *** 返回缓存
    3. WFAsyncCachePolicyType_ReturnCache_DidLoad = 2,  // *** 返回缓存并且加载
    4. WFAsyncCachePolicyType_ReturnCache_WhenNotConnectedInternet = 3,  // *** 返回缓存并且加载
    
一：引入WFAsyncHttp.h, 并且设置里面的公司名称（最好是英文，中文也没事），此处是做User-agent（不懂百度|google就知道了）用的
  
  1. GET异步请求
    [WFAsyncHttpManager POST_WithURLString:@"https://www.baidu.com"
                                 andParams:nil
                                andHeaders:nil
                            andCachePolicy:WFAsyncCachePolicyType_ReturnCache_WhenNotConnectedInternet
                                andSuccess:^(id responseObject)
     {
         NSLog(@"%@", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
     } andFailure:^(NSError *error) {
         
     }];

 2. POST异步请求
    [WFAsyncHttpManager POST_WithURLString:@"http://www.baidu.com"
                                     andParams:@{@"pp":@"pp"}
                                    andHeaders:@{@"uu":@"uu"}
                                    andSuccess:^(id responseObject)
        {
            NSLog(@"%@", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
        } andFailure:^(NSError *error) {
    
        }];
  
  3. GET同步请求
  
      [WFAsyncHttpClient System_GET_WithURLString:@"http://www.baidu.com/"
                                     andHeaders:nil
                                 andCachePolicy:WFAsyncCachePolicyType_ReturnCache_DontLoad
                                     andSuccess:^(id responseObject)
      {
        
       } andFailure:^(NSError *error) {
        
      }];
  4. POST同步请求
      [WFSyncHttpClient System_POST_WithURLString:URLString
                                      andParams:nil
                                   andUserAgent:@"sadfa;sdjfa;sdjk"
                                     andSuccess:^(id responseObject) {
        NSLog(@"%@", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
    } andFailure:^(NSError *error) {
        
    }];
