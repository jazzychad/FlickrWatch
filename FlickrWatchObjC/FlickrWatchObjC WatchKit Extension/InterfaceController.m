//
//  InterfaceController.m
//  FlickrWatchObjC WatchKit Extension
//
//  Created by Chad Etzel on 3/15/15.
//  Copyright (c) 2015 Charles Etzel. All rights reserved.
//

#import "InterfaceController.h"
#import <FlickrKit.h>


@interface InterfaceController()

@property (nonatomic, weak) IBOutlet WKInterfaceImage *digitImage0;
@property (nonatomic, weak) IBOutlet WKInterfaceImage *digitImage1;
@property (nonatomic, weak) IBOutlet WKInterfaceImage *digitImage2;
@property (nonatomic, weak) IBOutlet WKInterfaceImage *digitImage3;

@end


@implementation InterfaceController
{
    NSDateFormatter *_dateFormatter;
    NSTimer *_timer;
}

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    [[FlickrKit sharedFlickrKit] initializeWithAPIKey:@"FLICKR_KEY_HERE" sharedSecret:@"FLICKR_SECRET_HERE"];

    // Configure interface objects here.
    NSLog(@"%@ awakeWithContext", self);

    [self.mainLabel setText:@"Flickr Watch"];

}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    NSLog(@"%@ will activate", self);

    NSInteger hourMode = [[NSUserDefaults standardUserDefaults] integerForKey:@"FlickrWatchHourModeKey"];
    _dateFormatter = [[NSDateFormatter alloc] init];

    if (hourMode == 0) {
        _dateFormatter.dateFormat = @"hh:mm";
    } else if (hourMode == 1) {
        _dateFormatter.dateFormat = @"HH:mm";
    }
    NSLog(@"time: %@", [_dateFormatter stringFromDate:[NSDate date]]);
    [self _updateTimeDigits];

    _timer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(_updateTimeDigits) userInfo:nil repeats:YES];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    NSLog(@"%@ did deactivate", self);
    [_timer invalidate];
}

- (IBAction)_settingsButtonTapped:(id)sender
{
    NSLog(@"tapped!");
}

- (void)_updateTimeDigits
{
    NSString *timeString = [_dateFormatter stringFromDate:[NSDate date]];

    NSString *digit = nil;
    NSInteger hourMode = [[NSUserDefaults standardUserDefaults] integerForKey:@"FlickrWatchHourModeKey"];


    digit = [timeString substringWithRange:NSMakeRange(0, 1)];
    if (hourMode == 0 && [digit isEqualToString:@"0"]) {
        [self.digitImage0 setAlpha:0.0f];
    } else {
        [self.digitImage0 setAlpha:1.0f];
        [self _updateImage:self.digitImage0 withDigit:digit];
    }


    digit = [timeString substringWithRange:NSMakeRange(1, 1)];
    [self _updateImage:self.digitImage1 withDigit:digit];


    digit = [timeString substringWithRange:NSMakeRange(3, 1)];
    [self _updateImage:self.digitImage2 withDigit:digit];


    digit = [timeString substringWithRange:NSMakeRange(4, 1)];
    [self _updateImage:self.digitImage3 withDigit:digit];

}

- (void)_updateImage:(WKInterfaceImage *)digitImage withDigit:(NSString *)digit;
{
    NSString *tag = digit;
    if ([tag isEqualToString:@"0"]) {
        tag = @"00";
    }

    [[FlickrKit sharedFlickrKit] call:@"flickr.groups.pools.getPhotos" args:@{@"tags": tag, @"group_id": @"54718308@N00", @"extras": @"url_sq"}  completion:^(NSDictionary *response, NSError *error) {
        //NSLog(@"response: %@", response);

        if ([response objectForKey:@"photos"]) {
            NSArray *photos = [[response objectForKey:@"photos"] objectForKey:@"photo"];
            NSInteger randIndex = arc4random_uniform((u_int32_t)(photos.count));
            NSDictionary *dict = [photos objectAtIndex:randIndex];

            NSURL *url = [NSURL URLWithString:[dict objectForKey:@"url_sq"]];

            NSData *imgData = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:url] returningResponse:nil error:nil];
            if (imgData) {
                NSLog(@"imgData size: %lu", imgData.length);
                dispatch_async(dispatch_get_main_queue(), ^{
                    [digitImage setImageData:imgData];
                });
            }

        }
    }];
}

@end



