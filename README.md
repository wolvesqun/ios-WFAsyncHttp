# IOS-WFAsyncHttp
  
  此请求框架主要封装了IOS的Http请求，封装了同步请求（WFSyncHttpClient.h）与异步请求(WFAsyncHttpManager.h |          WFAsyncHttpClient.h)，两种请求方式都有POST请求和GET请求,其中WFAsyncHttpClient.h还封装了系统的请求（系统请求是采取队列方式），
当然，此框架还提供设置请求头。最重要的是还提供了缓存策略，目前只提供四种。还有封装了网页缓存功能，和图片缓存功能。
具体使用如下：
    
    注意
      1. 所有的请求都必须传入URLString，以及成功|失败回调，其它参数根据需要引入
      2. 缓存策略：
          2.1. WFAsyncCachePolicyType_Default = 0, // *** 不提供缓存
          2.2. WFAsyncCachePolicyType_ReturnCache_DontLoad = 1, // *** 返回缓存不请求网络
          2.3. WFAsyncCachePolicyType_ReturnCache_DidLoad = 2,  // *** 返回缓存并且加载
          2.4. WFAsyncCachePolicyType_Reload_IgnoringLocalCache = 3,   // *** 忽略本地缓存并加载 （使用在更新缓存）
    
一：引入WFAsyncHttp.h, 并且设置里面的公司名称（最好是英文，中文也没事），此处是做User-agent（不懂百度|google就知道了）用的
  
  1. GET异步请求
  
    [WFAsyncHttpManager GET_WithURLString:@"http://gc.ditu.aliyun.com/regeocoding?l=39.938133,116.395739&type=001"
                               andHeaders:nil
                           andCachePolicy:WFAsyncCachePolicyType_ReturnCache_DontLoad
                               andSuccess:^(id responseObject)
    {
        [AppDelegate showLog:responseObject];
        [AppDelegate showAlert:@"WFAsyncHttpManager - GET异步方式 -> 离线成功"];
    } andFailure:^(NSError *error) {
        [AppDelegate showLog:@"WFAsyncHttpManager - GET异步方式 -> 离线失败"];
    }];

  2. POST异步请求
 
    [WFAsyncHttpManager POST_WithURLString:@"https://www.baidu.com/s?ie=utf-8&f=8&rsv_bp=0&rsv_idx=1&tn=baidu&wd=json%E5%9C%A8%E7%BA%BF%E8%A7%A3%E6%9E%90&rsv_pq=827e6055000126c3&rsv_t=7eef1BgWJhIzUhSdAm%2FO7GzHKx8p3KxecQuAYGRHPE0fih%2FTqSb2L%2FNPLTA&rsv_enter=1&rsv_sug3=4&rsv_sug1=2&sug=json%E5%9C%A8%E7%BA%BF%E8%A7%A3%E6%9E%90&rsv_n=1"
                                 andParams:nil
                                andHeaders:nil
                            andCachePolicy:WFAsyncCachePolicyType_ReturnCache_DontLoad andSuccess:^(id responseObject)
    {
        [AppDelegate showLog:[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]];
        [AppDelegate showAlert:@"WFAsyncHttpManager - POST异步方式 -> 离线成功"];
    } andFailure:^(NSError *error) {
         [AppDelegate showLog:@"WFAsyncHttpManager - POST异步方式 -> 离线失败"];
    }];
  
  3. GET同步请求
  
      [WFSyncHttpClient System_GET_WithURLString:@"http://baike.baidu.com/link?url=KeukH7mzl7OU8wxXdSB9AZZffLqntSE_3y8--JjoPrbIVNTu4InEIKxJ8M-PgOiZOFevStVSM21y7uOh0E8RpK"
                                     andParams:nil
                                    andHeaders:nil
                                andCachePolicy:WFAsyncCachePolicyType_ReturnCache_DontLoad
                                    andSuccess:^(id responseObject)
     {
        [AppDelegate showLog:responseObject];
        [AppDelegate showAlert:@"WFSyncHttpClient - GET同步方式 -> 离线成功"];
    } andFailure:^(NSError *error) {
        [AppDelegate showLog:@"WFSyncHttpClient - GET异步方式 -> 离线失败"];
    }];

  4. POST同步请求
  
     [WFSyncHttpClient System_POST_WithURLString:@"http://baike.baidu.com/link?url=KeukH7mzl7OU8wxXdSB9AZZffLqntSE_3y8--JjoPrbIVNTu4InEIKxJ8M-PgOiZOFevStVSM21y7uOh0E8RpK" andParams:nil
                                     andHeaders:nil
                                 andCachePolicy:WFAsyncCachePolicyType_ReturnCache_DontLoad
                                     andSuccess:^(id responseObject)
    {
        [AppDelegate showLog:[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]];
        [AppDelegate showAlert:@"WFSyncHttpClient - POST同步方式 -> 离线成功"];
        
    } andFailure:^(NSError *error)
    {
        [AppDelegate showLog:@"WFSyncHttpClient - POST同步方式 -> 离线失败"];
    }];

二. 网页缓存功能：只需三步操作就可以了（1-》设置缓存， 2-》加载网页数据， 3-》给webview设置数据），是不是so easy

    1. 在appdelegate didFinishLaunchingWithOptions这个 方法加入 [WFAsyncURLCache setURLCache];
    2. 请求网页数据
        [WFAsyncHttpManager GET_WithURLString:@"http://wiki.mbalib.com/wiki/2015%E5%B9%B4%E8%AF%BA%E8%B4%9D%E5%B0%94%E7%BB%8F%E6%B5%8E%E5%AD%A6%E5%A5%96?app=1" andHeaders:nil
                        andCachePolicy:WFAsyncCachePolicyType_ReturnCache_DontLoad
                            andSuccess:^(id responseObject)
    {
        
        [self.webview loadData:responseObject MIMEType:nil textEncodingName:nil baseURL:[NSURL URLWithString:@"http://wiki.mbalib.com/"]];
        
    } andFailure:^(NSError *error)
     {
         NSLog(@"webview load error ------------------");
    }];
    
三. 图片缓存功能（两步操作）
    1. 引入 #import "UIImageView+WFImageViewCache.h"
    2. 创建UIImageView , 然后调用 
    
        [self.img setImageWithKey:@"http://d.hiphotos.baidu.com/image/w%3D310/sign=d12bf5db19d5ad6eaaf962ebb1cb39a3/b64543a98226cffc1d2771adbb014a90f603eaa4.jpg"
             placeholderImage:nil
                   andSuccess:^(UIImage *image)
     {
        
    } andFailure:^(NSError *error) {
        
    }];
    
