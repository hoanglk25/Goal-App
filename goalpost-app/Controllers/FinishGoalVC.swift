//
//  FinishGoalVC.swift
//  goalpost-app
//
//  Created by Hoàng Đức on 29/10/2022.
//

import UIKit
import CoreData

class FinishGoalVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var creatGoalBtn: UIButton!
    
    @IBOutlet weak var pointsTextField: UITextField!
    
    var goalDescription: String!
    var goalType: GoalType!
     
    func initData(description: String, type: GoalType) {
        self.goalDescription = description
        self.goalType = type
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pointsTextField.inputAccessoryView = creatGoalBtn
        pointsTextField.delegate = self

    }
    
    @IBAction func creatGoalBtnPressed(_ sender: Any) {
        //Pass data into core Data GoalModel
        if pointsTextField.text != "" {
            self.save { (complete) in
                if complete {
                    dismiss(animated: true, completion: nil)
                }
            }
        }        
    }
    
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismissDetail()
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.pointsTextField.text = ""
    }
    
    func save(completion: (_ finished: Bool) -> ()) {
        guard let managedContex = appDelegate?.persistentContainer.viewContext else {return}
        let goal = Goal(context: managedContex)
        
        goal.goalDescription = goalDescription
        goal.goalType = goalType.rawValue
        goal.goalCompletionValeu = Int32(pointsTextField.text!)!
        goal.goalProgress = Int32(0)
        
        do {
            try managedContex.save()
            print("Successfully save data")
            completion(true)
        } catch {
            debugPrint("could not save: \(error.localizedDescription)")
            completion(false)
        }
    }

}
