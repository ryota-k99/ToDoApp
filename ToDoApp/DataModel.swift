//
//  DataModel.swift
//  ToDoApp
//
//  Created by Kato Ryota  on 13/01/20.
//  Copyright © 2020 Kato Ryota . All rights reserved.
//

import Foundation
import RealmSwift

class DataModel: Object{
    @objc dynamic var toDoThing = ""
}
