//
//  KmoocListItemTableViewCellViewModel.swift
//  K-MOOC
//
//  Created by Sam Sung on 2023/05/18.
//

import Foundation

struct KmoocListItemTableViewCellViewModel {
    
    var thumbnail: String
    var name: String
    var orgName: String
    var duration: String
    
    init(lecture: Lecture) {
        self.thumbnail = lecture.courseImage
        self.name = lecture.name
        self.orgName = lecture.orgName
        
        let startDate = DateUtil.formatDate(lecture.start)
        let endDate = DateUtil.formatDate(lecture.end)
        self.duration = "\(startDate) ~ \(endDate)"
    }
    
}
