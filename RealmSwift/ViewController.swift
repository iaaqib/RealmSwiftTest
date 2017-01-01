//
//  ViewController.swift
//  RealmSwift
//
//  Created by Aaqib Hussain on 31/12/16.
//  Copyright © 2016 Aaqib Hussain. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
        @IBOutlet weak var nameTextField : UITextField!
        @IBOutlet weak var idTextField : UITextField!
    
    
        @IBOutlet weak var tableView : UITableView!
        var model : Model?
        let realm = try! Realm()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func doneButtonPressed(_sender :UIButton){
        if checkIfEmpty(){

            self.model = Model()
            model!.name = self.nameTextField.text!
            model!.id = self.idTextField.text!
            if let data = model{
                if self.ifIdExists(findID: idTextField.text!) == nil {
                try! self.realm.write {

                    self.realm.add(data)
                    self.tableView.reloadData()
                }
                }
            
            }
            print(self.realm.objects(Model.self))
        
        
        
        }
    
    
    }
    @IBAction func updateButtonPressed(_sender :UIButton){
        if checkIfEmpty(){
           
            var object = self.ifIdExists(findID: self.idTextField.text!)
            if (object != nil){
                try! self.realm.write {
                    print(object)
                    
                    self.model = Model()
                    model!.name = self.nameTextField.text
                    model!.id = object!.id!
                    object = self.model
                    self.realm.add(object!, update: true)
                    
                    print(object)

                    self.tableView.reloadData()
                }
                
            }
            
        }
        
        
    }

    
    @IBAction func deleteButtonPressed(_sender :UIButton){
        if self.checkIfIdIsEmpty(){
            
            let objectToDelete = self.ifIdExists(findID: idTextField.text!)
            print(objectToDelete)
            if objectToDelete != nil{
            try! realm.write{
                realm.delete(objectToDelete!)
                self.tableView.reloadData()
            }
        }
        
        }
        
        
        
        
        
        
    }
    
    func checkIfEmpty()-> Bool{
        if (nameTextField.text == "" ||  idTextField.text == ""){
        return false
        
        }
        return true
    
    }
    func checkIfIdIsEmpty()-> Bool{
        if (idTextField.text == ""){
            return false
            
        }
        return true
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let model = self.realm.objects(Model.self)[indexPath.row]
        cell.textLabel!.text = model.name!
        cell.detailTextLabel!.text = "ID: \(model.id!)"
        
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return realm.objects(Model.self).count
    }
    //Checks if id is contained in Realm
    func ifIdExists(findID: String) -> Model?{
     
     let predicate = NSPredicate(format: "id = %@", findID)
     let object = self.realm.objects(Model.self).filter(predicate).first
        if object?.id == findID {
        
        return object
            
        }
        return nil
        
        
    }
    
}

