//
//  AnnouncementModel.swift
//  TeamUP
//
//  Created by Jaemin Hong on 11/17/24.
// 

import Foundation

struct InformationModel: Identifiable {
    let id: String = UUID().uuidString
    var title: String
    var content: String
    var createAt: String
}
