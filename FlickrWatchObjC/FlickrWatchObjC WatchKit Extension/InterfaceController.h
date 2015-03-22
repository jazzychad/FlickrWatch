//
//  InterfaceController.h
//  FlickrWatchObjC WatchKit Extension
//
//  Created by Chad Etzel on 3/15/15.
//  Copyright (c) 2015 Charles Etzel. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>

@interface InterfaceController : WKInterfaceController

@property (nonatomic, weak) IBOutlet WKInterfaceLabel *mainLabel;
@property (nonatomic, weak) IBOutlet WKInterfaceButton *settingsButton;

@end
