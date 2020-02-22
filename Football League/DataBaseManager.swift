//
//  DataBaseManager(.swift
//  Football League
//
//  Created by Arabia-IT on 11/18/18.
//  Copyright © 2018 Arabia-IT. All rights reserved.
//

import Foundation
import RealmSwift

struct DataBaseManager {
    static let shared  = DataBaseManager.init()
    private init() {}
    func getObjects<T> (ofType type: T.Type) -> [T] where T: Object {
        do {
            let realm = try Realm()
            return Array(realm.objects(type))
        }
        catch {
            return []
        }
    }
    
    func addOrUpdateObject(object: Object) {
        do {
            let realm = try Realm()
            realm.safeWrite(code: {
                realm.add(object, update: Realm.UpdatePolicy.modified)
            })
        }
            
        catch {
            print("error in safing data")
        }
    }
}


extension Realm {
    func safeWrite (code:()->()) {
        if !isInWriteTransaction {
       try? write {
           code()
            }
        }
        else {
            code()
        }
    }
}
