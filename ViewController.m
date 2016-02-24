//
//  ViewController.m
//  XZTCP
//
//  Created by 谢振 on 16/2/19.
//  Copyright © 2016年 xiez. All rights reserved.
//

#import "ViewController.h"
#import "XZTCP.h"

@interface ViewController (){

    XZTCP * tcp;
    BOOL isTcpConncect;
    NSTimer * timer;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    tcp = [XZTCP sharedTCP];
    timer = [NSTimer scheduledTimerWithTimeInterval:15.0f target:self selector:@selector(runloop) userInfo:nil repeats:YES];
    BOOL res;
    [tcp closeConnect];
     res = [tcp connectWithHost:@"192.168.0.100" port:10306 connect:^(BOOL isConnect) {
        
        isTcpConncect = isConnect;
    }];
    
    if (res) {
        //NSLog(@"连接成功");
    }
    
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 60, 60)];
    [self.view addSubview:button];
    
    button.backgroundColor = [UIColor greenColor];
    [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)runloop{

    [self sendMessage];
}

- (void)click{

    [self sendMessage2];
}

- (void)sendMessage{

    NSLog(@"%d",[tcp isConnected]);
    
    if (![tcp isConnected]) {
        
    }
    
    [tcp sendRequsetWithDict:nil andApi:@"GetDeviceStatusNetwork" andblock:^(NSData *data) {
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dict);
    }];
    
    double delayInSeconds = 7.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        // code to be executed on the main queue after delay
        NSLog(@"%d",[tcp isConnected]);
        [tcp sendRequsetWithDict:nil andApi:@"GetDeviceDisplayData" andblock:^(NSData *data) {
            NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"%@",dict);
        }];
    });
    
}

- (void)sendMessage2{

    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"ABJLAAYptXw=",@"DeviceMacB64", nil];
    [tcp sendRequsetWithDict:dic andApi:@"FindDeviceLocation" andblock:^(NSData *data) {
       NSLog(@"。。。。。。。。。。。");
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if ([dict[@"SendCommandSuccess"] boolValue]) {
            NSLog(@"下发成功");
        } else {
        
           NSLog(@"下发失败");
        }
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
