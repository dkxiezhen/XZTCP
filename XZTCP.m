//
//  XZTCP.m
//  XZTCP
//
//  Created by 谢振 on 16/2/19.
//  Copyright © 2016年 xiez. All rights reserved.
//

#import "XZTCP.h"
#import "GCDAsyncSocket.h"
@interface XZTCP()<GCDAsyncSocketDelegate>{
    
    NSString * myHost;
    int myPort;
    BOOL isClose;
}

@end

@implementation XZTCP

- (instancetype)init{
    
    if (self = [super init]) {
        
        [self socketInit];
        
    }
    return self;
}

- (void)socketInit{
    
    dispatch_queue_t dQueue = dispatch_queue_create("tcp_dSocket_queue", NULL);
    //dispatch_queue_t sQueue = dispatch_queue_create("tcp_sSocket_queue", NULL);
    _socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dQueue socketQueue:nil];
    [_socket performBlock:^{
        
        [_socket enableBackgroundingOnSocket];
    }];
    _socket.autoDisconnectOnClosedReadStream = NO;
}

+ (XZTCP *)sharedTCP{
    
    static XZTCP * TCP;
    @synchronized(self) {
        
        if (TCP == nil) {
            TCP = [[[self class] alloc] init];
        }
    }
    return TCP;
}

- (void)sendRequsetWithCommand:(NSString *)command andApi:(NSString *)api andSendBlock:(HttpSendBlock)sendBlock andFail:(SendFailBlock)fail{
    
    if (![_socket isConnected]) {
        [_socket connectToHost:myHost onPort:myPort error:nil];
    }
    
    NSData * data = [command dataUsingEncoding:NSUTF8StringEncoding];
    [_socket writeData:data withTimeout:20.0 tag:0];
    [_socket readDataWithTimeout:-1 tag:0];
    self.sendBlock = sendBlock;
    self.sendFail = fail;
    
}

- (BOOL)connectWithHost:(NSString *)hostName port:(int)port connect:(Connect)con{
    
    NSError * error;
    BOOL res = [_socket connectToHost:hostName onPort:port withTimeout:-1 error:&error];
    if (![myHost isEqualToString:hostName]) {
        myHost = hostName;
    }
    if (myPort != port) {
        myPort = port;
    }
    if (!res) {
        NSLog(@"%@",error);
    }
    self.tcpConnect = con;
    return res;
}

- (void)closeConnect{
    [_socket setDelegate:nil];
    [_socket disconnect];
    [_socket setDelegate:self];
}

- (BOOL)isConnected{
    
    return [_socket isConnected];
}




- (void)socketDidCloseReadStream:(GCDAsyncSocket *)sock{
    
    NSLog(@"连接断开");
}

- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port{
    
    //连接成功
    if (self.tcpConnect != nil) {
        self.tcpConnect(YES);
    }
    
    
    NSLog(@"连接成功");
}
- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err{
    
    //BOOL con = self.tcpConnect(NO);
    //连接失败
    if (self.tcpConnect != nil) {
        self.tcpConnect(YES);
    }
    NSLog(@"连接。。。。");
}

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    
    [_socket setDelegate:nil];
    [_socket disconnect];
    [_socket setDelegate:self];
    
    self.sendBlock(data);
    
}

- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag{
    
    //发送数据成功
    NSLog(@"发送成功");
}

- (NSTimeInterval)socket:(GCDAsyncSocket *)sock shouldTimeoutReadWithTag:(long)tag
                 elapsed:(NSTimeInterval)elapsed
               bytesDone:(NSUInteger)length {
    
    self.sendFail();
    return elapsed;
}

- (NSTimeInterval)socket:(GCDAsyncSocket *)sock shouldTimeoutWriteWithTag:(long)tag
                 elapsed:(NSTimeInterval)elapsed
               bytesDone:(NSUInteger)length {
    
    self.sendFail();
    return elapsed;
}

@end
