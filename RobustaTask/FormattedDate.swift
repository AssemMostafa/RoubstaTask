//
//  FormattedDate.swift
//  RobustaTask
//
//  Created by Assem on 16/10/2022.
//

import Foundation

struct FormattedDate {
    var dayname: String!
    var day: String!
    var month: String!
    var year: String!

    init? (dateString: String) {

        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        let dateFormatteryears = DateFormatter()
        dateFormatteryears.dateFormat = "yyyy"
        let dateFormatterMonths = DateFormatter()
        dateFormatterMonths.dateFormat = "MMM"
        let dateFormatterdayname = DateFormatter()
        dateFormatterdayname.dateFormat = "EEEE"
        let dateFormatterday = DateFormatter()
        dateFormatterday.dateFormat = "dd"

        if let date = dateFormatterGet.date(from: dateString) {
            self.year = dateFormatteryears.string(from: date)
            self.month = dateFormatterMonths.string(from: date)
            self.dayname = dateFormatterdayname.string(from: date)
            self.day = dateFormatterday.string(from: date)
        } else {
            print("There was an error decoding the string")
        }
    }
}
