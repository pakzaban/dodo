//
//  Item.swift
//  dodo
//
//  Created by Peyman PAKZABAN on 4/29/18.
//  Copyright © 2018 Peyman PAKZABAN. All rights reserved.
//

import Foundation
// create a class that conforms to the encodable protocol so item instances  and itemArray can be encoded and persistently saved in a plist.  In addition they can be decoded and conform to the Decodable protocol.
class Item: Codable {
    var title : String = ""
    var done : Bool = false
    
}
