//
//  TheBeast.swift
//  BeltExam
//
//  Created by El Capitan on 7/20/18.
//  Copyright © 2018 Carlo Del Mundo. All rights reserved.
//

import Foundation
import UIKit
import CoreData


class TheBeast {
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private var thisBeast: Beast?
    
    var date_created: Date
    var type: String
    var beasted: String
    
    init() {
        self.thisBeast = Beast()
        self.type = ""
        self.beasted = "False"
        self.date_created = Date()
    }
    
    init(leBeast: Beast) {
        
        self.thisBeast = leBeast
        
        self.type = leBeast.beast!
        self.beasted = leBeast.beasted!
        self.date_created = leBeast.date_created!
    }
    
    func DateInString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E MMMM d"

        return formatter.string(from: self.date_created)
    }
    
    func FetchAll() -> [Beast]{
        var tableData:[Beast] = []
        let isBeasted = "False"
        let filter = "beasted==%@"
        
        let request:NSFetchRequest<Beast> = Beast.fetchRequest()
        request.predicate = NSPredicate(format: filter, isBeasted)
        
        do {
            tableData = try context.fetch(request)
        } catch {
            print("couldn't fetchAll from DB", error)
        }
        
        return tableData
    }
    
    func FetchBeasted() -> [Beast] {
        var tableData:[Beast] = []
        let isBeasted = "True"
        let filter = "beasted==%@"
        
        let request:NSFetchRequest<Beast> = Beast.fetchRequest()
        request.predicate = NSPredicate(format: filter, isBeasted)
        
        do {
            tableData = try context.fetch(request)
        } catch {
            print("couldn't fetchAll from DB", error)
        }
        
        return tableData
    }
    
    func Add() {
        let addBeast = Beast(context: context)
        
        addBeast.beast = self.type
        addBeast.beasted = self.beasted
        addBeast.date_created = Date()
        
        appDelegate.saveContext()
    }
    
    func Save() {
        self.thisBeast?.beast = self.type
        self.thisBeast?.beasted = self.beasted
        self.thisBeast?.date_created = self.date_created
        
        appDelegate.saveContext()
    }
    
    func Delete(isBeasted: Bool) -> [Beast] {
        var tableData:[Beast]
        
        if isBeasted {
            tableData = self.FetchBeasted()
        }
        else {
            tableData = self.FetchAll()
        }
        
        self.context.delete(tableData[tableData.index(of: self.thisBeast!)!])
        tableData.remove(at: tableData.index(of: self.thisBeast!)!)
        appDelegate.saveContext()
        
        return tableData
    }
}
