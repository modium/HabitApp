//
//  ViewController.swift
//  ReminderApp
//
//  Created by Jaf Crisologo on 2017-03-26.
//  Copyright © 2017 Modium Design. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    var habitItems = [Habit]()
    var moc:NSManagedObjectContext!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        moc = appDelegate.persistentContainer.viewContext
    }
    
    @IBAction func addToDB(_ sender: UIButton) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


}

