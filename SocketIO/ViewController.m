//
//  ViewController.m
//  SocketTesterARC
//
//  Created by Kyeck Philipp on 01.06.12.
//  Copyright (c) 2012 beta_interactive. All rights reserved.
//

#import "ViewController.h"
#import "SocketIO-Bridging-Header.h"
@import SocketIO;

@interface ViewController ()
{
  SocketIOClient *socketIO;
  SocketManager* manager;
}
@end

@implementation ViewController

- (void) viewDidLoad
{
  [super viewDidLoad];
 
  NSURL* url = [[NSURL alloc] initWithString:@"http://132.148.135.160:3201"];
  manager = [[SocketManager alloc] initWithSocketURL:url config:@{@"log": @YES}];
  socketIO = [manager socketForNamespace:@"/test"];

  socketIO = manager.defaultSocket;
  
}

- (IBAction)btnConnect:(id)sender {
  
  [socketIO on:@"connect" callback:^(NSArray* data, SocketAckEmitter* ack) {
    NSLog(@"socket connected");
  }];
  
  [socketIO connect];

  NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
  [dict setValue:@"123" forKey:@"userid"];
  [dict setValue:@"622e9a1b89ef35efae175be5b8637977" forKey:@"token"];
  [dict setValue:@"21.20608148" forKey:@"latitude"];
  [dict setValue:@"72.84762654" forKey:@"longitude"];
  [dict setValue:@"Sundaram Building, Laxman Nagar Rd, Laxman Nagar, Varachha, Surat, Gujarat 395006, India" forKey:@"address"];

  NSMutableArray *array = [[NSMutableArray alloc]init];
  [array addObject:dict];

  [socketIO emit:@"get_lat_lng" with:array];
  
  
  [socketIO on:@"message" callback:^(NSArray* data, SocketAckEmitter* ack) {
    NSLog(@"Recieve...!");
  }];


}



@end
