//
//  XZTCP.h
//  XZTCP
//
//  Created by 谢振 on 16/2/19.
//  Copyright © 2016年 xiez. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  发送数据候回调函数
 */
typedef void(^HttpSendBlock)(NSData * data);
typedef void(^SendFailBlock)(void);
typedef BOOL(^Connect)(BOOL isConnect);
@class GCDAsyncSocket;
@interface XZTCP : NSObject{
    
    
}

@property (nonatomic, strong) GCDAsyncSocket * socket;
@property (nonatomic, copy) Connect tcpConnect;
/**
 *  发送数据
 */
@property (nonatomic, copy) HttpSendBlock sendBlock;
@property (nonatomic, copy) SendFailBlock sendFail;

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
- (void)sendRequsetWithCommand:(NSString *)command andApi:(NSString *)api andSendBlock:(HttpSendBlock)sendBlock andFail:(SendFailBlock)fail;

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
