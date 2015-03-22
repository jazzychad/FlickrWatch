//
//  InterfaceController.swift
//  FlickrWatchSwift WatchKit Extension
//
//  Created by Chad Etzel on 3/15/15.
//  Copyright (c) 2015 Charles Etzel. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet weak var mainLabel: WKInterfaceLabel!
    @IBOutlet weak var digitImage0: WKInterfaceImage!
    @IBOutlet weak var digitImage1: WKInterfaceImage!
    @IBOutlet weak var digitImage2: WKInterfaceImage!
    @IBOutlet weak var digitImage3: WKInterfaceImage!

    var _dateFormatter : NSDateFormatter?
    var _timer : NSTimer?


    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        NSLog("%@ awakeWithContext", self)

        FlickrKit.sharedFlickrKit().initializeWithAPIKey("FLICKR_KEY_HERE", sharedSecret: "FLICKR_SECRET_HERE")

        mainLabel.setText("FlickrWatch Swift")
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        NSLog("%@ will activate", self)

        var hourMode = NSUserDefaults.standardUserDefaults().integerForKey("FlickrWatchHourModeKey")
        _dateFormatter = NSDateFormatter()

        if hourMode == 0 {
            _dateFormatter!.dateFormat = "hh:mm"
        } else {
            _dateFormatter!.dateFormat = "HH:mm"
        }
        _updateTimeDigits()

        _timer = NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: Selector("_updateTimeDigits"), userInfo: nil, repeats: true)
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        NSLog("%@ did deactivate", self)
        super.didDeactivate()

        _timer?.invalidate()
    }

    func _updateTimeDigits() {

        var timeString = _dateFormatter!.stringFromDate(NSDate())

        var hourMode = NSUserDefaults.standardUserDefaults().integerForKey("FlickrWatchHourModeKey")

        var digit = timeString.substringWithRange(Range<String.Index>(start: advance(timeString.startIndex, 0), end: advance(timeString.startIndex, 1)))
        if hourMode == 0 && digit == "0" {
            digitImage0.setAlpha(0)
        } else {
            digitImage0.setAlpha(1)
            _updateImage(digitImage0, withDigit: digit)
        }

        digit = timeString.substringWithRange(Range<String.Index>(start: advance(timeString.startIndex, 1), end: advance(timeString.startIndex, 2)))
        _updateImage(digitImage1, withDigit: digit)

        digit = timeString.substringWithRange(Range<String.Index>(start: advance(timeString.startIndex, 3), end: advance(timeString.startIndex, 4)))
        _updateImage(digitImage2, withDigit: digit)

        digit = timeString.substringWithRange(Range<String.Index>(start: advance(timeString.startIndex, 4), end: advance(timeString.startIndex, 5)))
        _updateImage(digitImage3, withDigit: digit)

    }

    func _updateImage(digitImage : WKInterfaceImage, withDigit digit : String) {

        var tag = digit
        if tag == "0" {
            tag = "00"
        }

        FlickrKit.sharedFlickrKit().call("flickr.groups.pools.getPhotos", args: ["tags": tag, "group_id": "54718308@N00", "extras": "url_sq"]) { (response, error) -> Void in
            var photos = (response["photos"] as! [NSObject : AnyObject])["photo"] as! [[NSObject : AnyObject]]
            NSLog("photos: %@", photos)

            var randIndex = arc4random_uniform(UInt32(photos.count))
            var photoDict = photos[Int(randIndex)]

            var urlString = photoDict["url_sq"] as! String

            var url = NSURL(string: urlString)

            var imgData = NSURLConnection.sendSynchronousRequest(NSURLRequest(URL: url!), returningResponse: nil, error: nil)

            if let data = imgData {
                NSLog("data length: %lu", data.length)
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    digitImage.setImageData(data)
                });
            }



        }

    }

}
