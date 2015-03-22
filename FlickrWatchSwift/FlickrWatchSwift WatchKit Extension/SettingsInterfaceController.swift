//
//  SettingsInterfaceController.swift
//  FlickrWatchSwift
//
//  Created by Chad Etzel on 3/15/15.
//  Copyright (c) 2015 Charles Etzel. All rights reserved.
//

import WatchKit
import Foundation


class SettingsInterfaceController: WKInterfaceController {

    @IBOutlet weak var settingsTable: WKInterfaceTable!

    override func awakeWithContext(context: AnyObject!) {
        NSLog("settings did awake")

        settingsTable.setRowTypes(["HourType1224Row"])
        settingsTable.setNumberOfRows(2, withRowType: "HourType1224Row")

        for i in 0..<settingsTable.numberOfRows {
            if i == 0 {
                var row: SettingsRowController = settingsTable.rowControllerAtIndex(0) as! SettingsRowController
                row.label.setText("12hr")
                row.checkImage.setImageNamed("bluecheckcached");
                if NSUserDefaults.standardUserDefaults().integerForKey("FlickrWatchHourModeKey") == 0 {
                    row.checkImage.setHidden(false)
                } else {
                    row.checkImage.setHidden(true)
                }

            } else if i == 1 {
                var row: SettingsRowController = settingsTable.rowControllerAtIndex(1)as! SettingsRowController
                row.label.setText("24hr")
                row.checkImage.setImageNamed("bluecheckcached")
                if NSUserDefaults.standardUserDefaults().integerForKey("FlickrWatchHourModeKey") == 1 {
                    row.checkImage.setHidden(false)
                } else {
                    row.checkImage.setHidden(true)
                }
            }
        }

    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        NSLog("%@ will activate", self)
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        NSLog("%@ did deactivate", self)
        super.didDeactivate()
    }

    override func table(table: WKInterfaceTable, didSelectRowAtIndex rowIndex: Int) {
        NSLog("selected row!")

        var previousMode = NSUserDefaults.standardUserDefaults().integerForKey("FlickrWatchHourModeKey")

        NSUserDefaults.standardUserDefaults().setInteger(rowIndex, forKey: "FlickrWatchHourModeKey")
        NSUserDefaults.standardUserDefaults().synchronize()

        if previousMode != rowIndex {
            _reloadTableData()
        }
    }

    func _reloadTableData() {
        for i in 0..<settingsTable.numberOfRows {
            if i == 0 {
                var row: SettingsRowController = settingsTable.rowControllerAtIndex(0) as! SettingsRowController
                if NSUserDefaults.standardUserDefaults().integerForKey("FlickrWatchHourModeKey") == 0 {
                    row.checkImage.setHidden(false)
                } else {
                    row.checkImage.setHidden(true)
                }

            } else if i == 1 {
                var row: SettingsRowController = settingsTable.rowControllerAtIndex(1)as! SettingsRowController
                if NSUserDefaults.standardUserDefaults().integerForKey("FlickrWatchHourModeKey") == 1 {
                    row.checkImage.setHidden(false)
                } else {
                    row.checkImage.setHidden(true)
                }
            }
        }
    }

}
