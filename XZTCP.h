//
//  XZTCP.h
//  XZTCP
//
//  Created by 谢振 on 16/2/19.
//  Copyright © 2016年 xiez. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    kGetDeviceStatusNetwork = 200,
    kFindDeviceLocation,
    kDeviceReconnect,
    kGetDeviceDisplayData,
    kGetHouseXFCtrlStatus,
    kGetXFCtrlMode,
    kSetXFCtrlAutoModeAvgParam,
    kGetXFCtrlAutoModeAvgParam,
    kSetXFCtrlAutoModeSensorParam,
    kGetXFCtrlAutoModeSensorParam,
    kSetXFCtrlManualModeParam,
    kGetXFCtrlManualModeParam,
    kSetXFCtrlTimerProfile,
    kGetXFCtrlTimerProfile,
    kSetXFCtrlTimerModeEnable,
    kGetXFCtrlTimerModeEnable,
    kGetCtrlBoxDisplay,
    kDistributeNodeList,
} APIKay;

/**
 *  发送数据候回调函数
 */
typedef void(^HttpSendBlock)(NSData * data);
typedef void(^Connect)(BOOL isConnect);
@class GCDAsyncSocket;
@interface XZTCP : NSObject{

    
}

@property (nonatomic, strong) GCDAsyncSocket * socket;
@property (nonatomic, copy) Connect tcpConnect;
/**
 *  批量获取设备网络状态
 */
@property (nonatomic, copy) HttpSendBlock GetDeviceStatusNetwork;
/**
 *  寻找设备
 */
@property (nonatomic, copy) HttpSendBlock FindDeviceLocation;
/**
 *  设备掉线重连
 */
@property (nonatomic, copy) HttpSendBlock DeviceReconnect;
/**
 *  批量获取设备采集展示参数
 */
@property (nonatomic, copy) HttpSendBlock GetDeviceDisplayData;
/**
 *  获取房屋控制盒状态
 */
@property (nonatomic, copy) HttpSendBlock GetHouseXFCtrlStatus;
/**
 *  获取房屋新风控制模式
 */
@property (nonatomic, copy) HttpSendBlock GetXFCtrlMode;
/**
 *  设置自动控制模式平均参数
 */
@property (nonatomic, copy) HttpSendBlock SetXFCtrlAutoModeAvgParam;
/**
 *  获取自动控制模式平均参数
 */
@property (nonatomic, copy) HttpSendBlock GetXFCtrlAutoModeAvgParam;
/**
 *  设置自动控制模式采集器参数
 */
@property (nonatomic, copy) HttpSendBlock SetXFCtrlAutoModeSensorParam;
/**
 *  获取自动控制模式采集器参数
 */
@property (nonatomic, copy) HttpSendBlock GetXFCtrlAutoModeSensorParam;
/**
 *  设置房屋新风手动配置参数
 */
@property (nonatomic, copy) HttpSendBlock SetXFCtrlManualModeParam;
/**
 *  获取房屋新风手动配置参数
 */
@property (nonatomic, copy) HttpSendBlock GetXFCtrlManualModeParam;
/**
 *  设置房屋新风定时模式参数
 */
@property (nonatomic, copy) HttpSendBlock SetXFCtrlTimerProfile;
/**
 *  获取房屋新风定时模式参数
 */
@property (nonatomic, copy) HttpSendBlock GetXFCtrlTimerProfile;
/**
 *  设置房屋定时模式是否启用
 */
@property (nonatomic, copy) HttpSendBlock SetXFCtrlTimerModeEnable;
/**
 *  获取房屋定时模式是否启用
 */
@property (nonatomic, copy) HttpSendBlock GetXFCtrlTimerModeEnable;
/**
 *  获取控制盒显示数据
 */
@property (nonatomic, copy) HttpSendBlock GetCtrlBoxDisplay;
/**
 *  下发节点列表
 */
@property (nonatomic, copy) HttpSendBlock DistributeNodeList;


/**
 *  单例实例化TCP
 *
 *  @return TCP实例
 */
+ (XZTCP *)sharedTCP;

/**
 *  tcp发送数据
 *
 *  @param dict     发送参数
 *  @param api      发送接口
 *  @param resBlock 成功后回调
 */
- (void)sendRequsetWithDict:(NSDictionary *)dict andApi:(NSString *)api andblock:(HttpSendBlock)resBlock;

/**
 *  tcp连接函数
 *
 *  @param hostName ip地址
 *  @param port     端口
 *  @param con      连接状态回调
 *
 *  @return 返回连接结果
 */
- (BOOL)connectWithHost:(NSString *)hostName port:(int)port connect:(Connect)con;
- (void)closeConnect;

- (BOOL)isConnected;

@end
