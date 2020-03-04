//
//  FactsModel.swift
//  Srujan_Project
//
//  Created by Srujan k on 04/03/20.
//  Copyright © 2020 Srujan k. All rights reserved.
//

import Foundation

struct FactsList: Decodable{
    let title: String?
    let rows: [Fact]?
}


struct Fact: Decodable{
    let title: String?
    let description: String?
    let imageHref: String?
}
