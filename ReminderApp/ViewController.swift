//
//  ViewController.swift
//  ReminderApp
//
//  Created by Jaf Crisologo on 2017-03-26.
//  Copyright © 2017 Modium Design. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource {
    
    var habitItems = [Habit]()
    var moc:NSManagedObjectContext!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        moc = appDelegate.persistentContainer.viewContext
        self.tableView.dataSource = self
        
        loadData()
    }
    
    @IBAction func addToDB(_ sender: UIButton) {
        let habitItem = Habit(context: moc)
        habitItem.added = NSDate()
        
        if sender.tag == 0 {
            habitItem.habitType = "Mental"
        } else {
            habitItem.habitType = "Physical"
        }
        
        appDelegate.saveContext()
        
        loadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    func loadData() {
        let habitRequest:NSFetchRequest<Habit> = Habit.fetchRequest()
        
        let sortDescriptor = NSSortDescriptor(key: "added", ascending: false)
        habitRequest.sortDescriptors = [sortDescriptor]
        
        do {
            try habitItems = moc.fetch(habitRequest)
        } catch {
            print("Could not load data")
        }
        
        self.tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return habitItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let habitItem = habitItems[indexPath.row]
        
        let habitType = habitItem.habitType
        cell.textLabel?.text = habitType
        
        let habitDate = habitItem.added as! Date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d yyyy, hh:mm"
        
        cell.detailTextLabel?.text = dateFormatter.string(from: habitDate)
        
        if habitType == "Mental" {
            cell.imageView?.image = UIImage(named: "Brain")
        } else {
            cell.imageView?.image = UIImage(named: "Muscle")
        }
        
        return cell
    }
    
    @IBAction func clearHabitsBtnPressed(_ sender: UIButton) {
        let habitRequest:NSFetchRequest<Habit> = Habit.fetchRequest()
        
        if let result = try? moc.fetch(habitRequest) {
            for object in result {
                moc.delete(object)
            }
        }
        
        loadData()
    }
    
}

