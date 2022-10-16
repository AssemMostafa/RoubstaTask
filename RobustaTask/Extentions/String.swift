//
//  String.swift
//  RobustaTask
//
//  Created by Assem on 16/10/2022.
//

import Foundation

extension String {

    var months: String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        let dateOfRepo = dateFormatter.date(from: self)!
        let today = Date()
        let gregorian = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        let age = gregorian.components([.month], from: dateOfRepo, to: today, options: [])
         let repoMonth = "\(age.month ?? 0)"
        return repoMonth
    }

    func isRepoDateMoreThan6Months() -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        let dateOfRepo = dateFormatter.date(from: self)!
        let today = Date()
        let gregorian = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        let age = gregorian.components([.month], from: dateOfRepo, to: today, options: [])
        guard let repoMonth = age.month else {return false}
        if  repoMonth < 6 {
            // repo date is under 6
            return false
        }
        return true
    }
}
