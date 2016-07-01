//
//  ViewController.m
//  Python-iOS-app
//
//  Created by Fancyzero on 13-8-21.
//  Copyright (c) 2013年 Fancyzero. All rights reserved.
//

#import "ViewController.h"
#import "AsyncSocket.h"

@interface ViewController ()
@property (nonatomic,strong)AsyncSocket * socket;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    
}
//必须在view appear之后，不能放在viewDidLoad中。具体原因可能因为server还未建立。
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //创建socket对象
    _socket = [[AsyncSocket alloc] initWithDelegate:self];
    [_socket connectToHost:@"127.0.0.1" onPort:8000 withTimeout:-1 error:nil];
}
- (void)sendMessage
{
    
    
    NSDictionary *dict = @{
                           @"from":@"local",
                           @"to":@"Server",
                           @"message":@"This is My book!"
                           };
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    

    [_socket writeData:data withTimeout:-1 tag:100];
    
}
- (IBAction)SendMsg:(id)sender {
    [self sendMessage];
}
- (void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
{
    [_socket readDataWithTimeout:-1 tag:100];
    NSLog(@"didConnectToHost");
}

- (void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    
    NSLog(@"from:%@ message:%@", dict[@"from"], dict[@"message"]);
    
    [_socket readDataWithTimeout:-1 tag:100];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
