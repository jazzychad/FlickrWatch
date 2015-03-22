//
//  SettingsInterfaceController.m
//  FlickrWatchObjC
//
//  Created by Chad Etzel on 3/15/15.
//  Copyright (c) 2015 Charles Etzel. All rights reserved.
//

#import "SettingsInterfaceController.h"
#import "SettingsRowController.h"


@interface SettingsInterfaceController()

@property (nonatomic, weak) IBOutlet WKInterfaceTable *table;

@end


@implementation SettingsInterfaceController

- (void)awakeWithContext:(id)context
{
    [self.table setRowTypes:@[@"HourType1224Row"]];
    [self.table setNumberOfRows:2 withRowType:@"HourType1224Row"];
    //[self _reloadTableData];

    for (NSInteger i = 0; i < self.table.numberOfRows; i++) {
        if (i == 0) {
            SettingsRowController *row = [self.table rowControllerAtIndex:0];
            [row.label setText:@"12hr"];
            [row.checkImage setImageNamed:@"bluecheckcached"];
            if ([[NSUserDefaults standardUserDefaults] integerForKey:@"FlickrWatchHourModeKey"] == 0) {
                [row.checkImage setHidden:NO];
            } else {
                [row.checkImage setHidden:YES];
            }
        } else if (i == 1) {
            SettingsRowController *row = [self.table rowControllerAtIndex:1];
            [row.label setText:@"24hr"];
            [row.checkImage setImageNamed:@"bluecheckcached"];
            if ([[NSUserDefaults standardUserDefaults] integerForKey:@"FlickrWatchHourModeKey"] == 1) {
                [row.checkImage setHidden:NO];
            } else {
                [row.checkImage setHidden:YES];
            }
        }
    }
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    NSLog(@"%@ will activate", self);
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    NSLog(@"%@ did deactivate", self);
}

- (void)table:(WKInterfaceTable *)table didSelectRowAtIndex:(NSInteger)rowIndex
{
    NSLog(@"selected row!");

    NSInteger previousMode = [[NSUserDefaults standardUserDefaults] integerForKey:@"FlickrWatchHourModeKey"];

    [[NSUserDefaults standardUserDefaults] setObject:@(rowIndex) forKey:@"FlickrWatchHourModeKey"];
    [[NSUserDefaults standardUserDefaults] synchronize];

    if (previousMode != rowIndex) {
        [self _reloadTableData];
    }

}

- (void)_reloadTableData
{
    for (NSInteger i = 0; i < self.table.numberOfRows; i++) {
        if (i == 0) {
            SettingsRowController *row = [self.table rowControllerAtIndex:0];
            if ([[NSUserDefaults standardUserDefaults] integerForKey:@"FlickrWatchHourModeKey"] == 0) {
                [row.checkImage setHidden:NO];
            } else {
                [row.checkImage setHidden:YES];
            }
        } else if (i == 1) {
            SettingsRowController *row = [self.table rowControllerAtIndex:1];
            if ([[NSUserDefaults standardUserDefaults] integerForKey:@"FlickrWatchHourModeKey"] == 1) {
                [row.checkImage setHidden:NO];
            } else {
                [row.checkImage setHidden:YES];
            }
        }
    }
}


@end



