//
//  ViewController.swift
//  Log In Demo
//
//  Created by Arlen Peña Tolentino on 10/24/17.
//  Copyright © 2017 Arlen Peña. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet var textFiel: UITextField!
    
    @IBOutlet var label: UILabel!
    @IBOutlet var logInButton: UIButton!
    @IBAction func logInButton(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let newValue = NSEntityDescription.insertNewObject(forEntityName: "Users",into: context)
        newValue.setValue(textFiel.text, forKey: "name")
        do {
            try context.save()
            textFiel.alpha = 0
            logInButton.alpha = 0
            label.alpha = 1
            label.text = "Hola " + textFiel.text! + "!"
        } catch  {
            print("Fallo guardar")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        
        request.returnsObjectsAsFaults = false
        do {
            let results = try context.fetch(request)
                for result in results as! [NSManagedObject]{
                    if let username = result.value(forKey: "name") as? String {
                    textFiel.alpha = 0
                    logInButton.alpha = 0
                    label.alpha = 1
                    label.text = "Hola " + username + "!"
                }
            }
        } catch  {
            print("Fallo respuesta")
        }
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

