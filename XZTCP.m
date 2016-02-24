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

- (void)sendRequsetWithDict:(NSMutableDictionary *)dict andApi:(NSString *)api{

    if(!dict){
    
        dict = [[NSMutableDictionary alloc] init];
    }
    [dict setObject:api forKey:@"InterFace"];
    NSData * data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    [_socket writeData:data withTimeout:20.0f tag:200];
}

- (void)sendRequsetWithDict:(NSMutableDictionary *)dict andApi:(NSString *)api andblock:(HttpSendBlock)resBlock{
    
    if (![_socket isConnected]) {
        [_socket connectToHost:myHost onPort:myPort error:nil];
    }
    if(!dict){
        
        dict = [[NSMutableDictionary alloc] init];
    }
    [dict setObject:api forKey:@"InterFace"];
    NSData * data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    
    if ([api isEqualToString:@"GetDeviceStatusNetwork"]) {
        
        [_socket writeData:data withTimeout:20.0 tag:kGetDeviceStatusNetwork];
        [_socket readDataWithTimeout:-1 tag:kGetDeviceStatusNetwork];
        self.GetDeviceStatusNetwork = resBlock;
    } else if ([api isEqualToString:@"FindDeviceLocation"]){
        [_socket writeData:data withTimeout:20.0 tag:kFindDeviceLocation];
        [_socket readDataWithTimeout:-1 tag:kFindDeviceLocation];
        self.FindDeviceLocation = resBlock;
    } else if ([api isEqualToString:@"DeviceReconnect"]){
        [_socket writeData:data withTimeout:20.0 tag:kDeviceReconnect];
        [_socket readDataWithTimeout:-1 tag:kDeviceReconnect];
        self.DeviceReconnect = resBlock;
    } else if ([api isEqualToString:@"GetDeviceDisplayData"]){
        [_socket writeData:data withTimeout:20.0 tag:kGetDeviceDisplayData];
        [_socket readDataWithTimeout:-1 tag:kGetDeviceDisplayData];
        self.GetDeviceDisplayData = resBlock;
    } else if ([api isEqualToString:@"GetHouseXFCtrlStatus"]){
        [_socket writeData:data withTimeout:20.0 tag:kGetHouseXFCtrlStatus];
        [_socket readDataWithTimeout:-1 tag:kGetHouseXFCtrlStatus];
        self.GetHouseXFCtrlStatus = resBlock;
    } else if ([api isEqualToString:@"GetXFCtrlMode"]){
        [_socket writeData:data withTimeout:20.0 tag:kGetXFCtrlMode];
        [_socket readDataWithTimeout:-1 tag:kGetXFCtrlMode];
        self.GetXFCtrlMode = resBlock;
    } else if ([api isEqualToString:@"SetXFCtrlAutoModeAvgParam"]){
        [_socket writeData:data withTimeout:20.0 tag:kSetXFCtrlAutoModeAvgParam];
        [_socket readDataWithTimeout:-1 tag:kSetXFCtrlAutoModeAvgParam];
        self.SetXFCtrlAutoModeAvgParam = resBlock;
    } else if ([api isEqualToString:@"GetXFCtrlAutoModeAvgParam"]){
        [_socket writeData:data withTimeout:20.0 tag:kGetXFCtrlAutoModeAvgParam];
        [_socket readDataWithTimeout:-1 tag:kGetXFCtrlAutoModeAvgParam];
        self.GetXFCtrlAutoModeAvgParam = resBlock;
    } else if ([api isEqualToString:@"SetXFCtrlAutoModeSensorParam"]){
        [_socket writeData:data withTimeout:20.0 tag:kSetXFCtrlAutoModeSensorParam];
        [_socket readDataWithTimeout:-1 tag:kSetXFCtrlAutoModeSensorParam];
        self.SetXFCtrlAutoModeSensorParam = resBlock;
    } else if ([api isEqualToString:@"GetXFCtrlAutoModeSensorParam"]){
        [_socket writeData:data withTimeout:20.0 tag:kGetXFCtrlAutoModeSensorParam];
        [_socket readDataWithTimeout:-1 tag:kGetXFCtrlAutoModeSensorParam];
        self.GetXFCtrlAutoModeSensorParam = resBlock;
    } else if ([api isEqualToString:@"SetXFCtrlManualModeParam"]){
        [_socket writeData:data withTimeout:20.0 tag:kSetXFCtrlManualModeParam];
        [_socket readDataWithTimeout:-1 tag:kSetXFCtrlManualModeParam];
        self.SetXFCtrlManualModeParam = resBlock;
    } else if ([api isEqualToString:@"GetXFCtrlManualModeParam"]){
        [_socket writeData:data withTimeout:20.0 tag:kGetXFCtrlManualModeParam];
        [_socket readDataWithTimeout:-1 tag:kGetXFCtrlManualModeParam];
        self.GetXFCtrlManualModeParam = resBlock;
    } else if ([api isEqualToString:@"SetXFCtrlTimerProfile"]){
        [_socket writeData:data withTimeout:20.0 tag:kSetXFCtrlTimerProfile];
        [_socket readDataWithTimeout:-1 tag:kSetXFCtrlTimerProfile];
        self.SetXFCtrlTimerProfile = resBlock;
    } else if ([api isEqualToString:@"GetXFCtrlTimerProfile"]){
        [_socket writeData:data withTimeout:20.0 tag:kGetXFCtrlTimerProfile];
        [_socket readDataWithTimeout:-1 tag:kGetXFCtrlTimerProfile];
        self.GetXFCtrlTimerProfile = resBlock;
    } else if ([api isEqualToString:@"SetXFCtrlTimerModeEnable"]){
        [_socket writeData:data withTimeout:20.0 tag:kSetXFCtrlTimerModeEnable];
        [_socket readDataWithTimeout:-1 tag:kSetXFCtrlTimerModeEnable];
        self.SetXFCtrlTimerModeEnable = resBlock;
    } else if ([api isEqualToString:@"GetXFCtrlTimerModeEnable"]){
        [_socket writeData:data withTimeout:20.0 tag:kGetXFCtrlTimerModeEnable];
        [_socket readDataWithTimeout:-1 tag:kGetXFCtrlTimerModeEnable];
        self.GetXFCtrlTimerModeEnable = resBlock;
    } else if ([api isEqualToString:@"GetCtrlBoxDisplay"]){
        [_socket writeData:data withTimeout:20.0 tag:kGetCtrlBoxDisplay];
        [_socket readDataWithTimeout:-1 tag:kGetCtrlBoxDisplay];
        self.GetCtrlBoxDisplay = resBlock;
    } else if ([api isEqualToString:@"DistributeNodeList"]){
        [_socket writeData:data withTimeout:20.0 tag:kDistributeNodeList];
        [_socket readDataWithTimeout:-1 tag:kDistributeNodeList];
        self.DistributeNodeList = resBlock;
    }
    
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
    self.tcpConnect(YES);
    NSLog(@"连接成功");
}
- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err{
    
    NSLog(@"连接。。。。");
}

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{

    [_socket setDelegate:nil];
    [_socket disconnect];
    [_socket setDelegate:self];
    //NSLog(@"%@",data);
    NSString * str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSData * mydata = [str dataUsingEncoding:NSUTF8StringEncoding];
    //收到数据
    NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:mydata options:NSJSONReadingMutableContainers error:nil];
    //NSLog(@"%@",dict);
    NSString * apiName = dict[@"InterFace"];
    if (apiName) {
        
        if ([apiName isEqualToString:@"GetDeviceStatusNetwork"]) {
            if (_GetDeviceStatusNetwork) {
                self.GetDeviceStatusNetwork(mydata);
            }
        } else if ([apiName isEqualToString:@"FindDeviceLocation"]){
        
            self.FindDeviceLocation(mydata);
        } else if ([apiName isEqualToString:@"DeviceReconnect"]){
            
            self.DeviceReconnect(mydata);
        } else if ([apiName isEqualToString:@"GetDeviceDisplayData"]){
            
            self.GetDeviceDisplayData(mydata);
        } else if ([apiName isEqualToString:@"GetHouseXFCtrlStatus"]){
            
            self.GetHouseXFCtrlStatus(mydata);
        } else if ([apiName isEqualToString:@"GetXFCtrlMode"]){
            
            self.GetXFCtrlMode(mydata);
        } else if ([apiName isEqualToString:@"SetXFCtrlAutoModeAvgParam"]){
            
            self.SetXFCtrlAutoModeAvgParam(mydata);
        } else if ([apiName isEqualToString:@"GetXFCtrlAutoModeAvgParam"]){
            
            self.GetXFCtrlAutoModeAvgParam(mydata);
        } else if ([apiName isEqualToString:@"SetXFCtrlAutoModeSensorParam"]){
            
            self.SetXFCtrlAutoModeSensorParam(mydata);
        } else if ([apiName isEqualToString:@"GetXFCtrlAutoModeSensorParam"]){
            
            self.GetXFCtrlAutoModeSensorParam(mydata);
        } else if ([apiName isEqualToString:@"SetXFCtrlManualModeParam"]){
            
            self.SetXFCtrlManualModeParam(mydata);
        } else if ([apiName isEqualToString:@"GetXFCtrlManualModeParam"]){
            
            self.GetXFCtrlManualModeParam(mydata);
        } else if ([apiName isEqualToString:@"SetXFCtrlTimerProfile"]){
            
            self.SetXFCtrlTimerProfile(mydata);
        } else if ([apiName isEqualToString:@"GetXFCtrlTimerProfile"]){
            
            self.GetXFCtrlTimerProfile(mydata);
        } else if ([apiName isEqualToString:@"SetXFCtrlTimerModeEnable"]){
            
            self.SetXFCtrlTimerModeEnable(mydata);
        } else if ([apiName isEqualToString:@"GetXFCtrlTimerModeEnable"]){
            
            self.GetXFCtrlTimerModeEnable(mydata);
        } else if ([apiName isEqualToString:@"GetCtrlBoxDisplay"]){
            
            //接口弃用
            self.GetCtrlBoxDisplay(mydata);
        } else if ([apiName isEqualToString:@"DistributeNodeList"]){
            
            self.DistributeNodeList(mydata);
        }
    }
    
}

- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag{

    //发送数据成功
    NSLog(@"发送成功");
}
@end
