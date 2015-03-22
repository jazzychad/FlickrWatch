//
//  SettingsRowController.h
//  FlickrWatchObjC
//
//  Created by Chad Etzel on 3/15/15.
//  Copyright (c) 2015 Charles Etzel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WatchKit/WatchKit.h>

@interface SettingsRowController : NSObject

@property (nonatomic, weak) IBOutlet WKInterfaceLabel *label;
@property (nonatomic, weak) IBOutlet WKInterfaceImage *checkImage;

@end
