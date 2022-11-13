//
//  CreatGoalVC.swift
//  goalpost-app
//
//  Created by Hoàng Đức on 28/10/2022.
//

import UIKit

class CreatGoalVC: UIViewController, UITextViewDelegate {

    @IBOutlet weak var goalTextView: UITextView!
    
    @IBOutlet weak var shortTermBtn: UIButton!
    
    @IBOutlet weak var longTermBtn: UIButton!
    
    @IBOutlet weak var nextBtn: UIButton!
    
    var goalType:GoalType = .shortTerm
    override func viewDidLoad() {
        super.viewDidLoad()
        goalTextView.inputAccessoryView = nextBtn
        shortTermBtn.setSelectedColor()
        longTermBtn.setDeSelectedColor()
        
        goalTextView.delegate = self

    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
         dismissDetail()
    }
    
    @IBAction func nextBtnPressed(_ sender: Any) {
        view.endEditing(true)
        if goalTextView.text != "" && goalTextView.text != "What is your Goal?" {
            guard let finishGoalVC = storyboard?.instantiateViewController(withIdentifier: "FinishGoalVC") as? FinishGoalVC else { return}
            finishGoalVC.initData(description: goalTextView.text!, type: goalType)
            presentingViewController?.presentSecondaryDetail(finishGoalVC)
        }
    }
    
    @IBAction func shortTermBtnPressed(_ sender: Any) {
        goalType = .shortTerm
        shortTermBtn.setSelectedColor()
        longTermBtn.setDeSelectedColor()
    }
    
    @IBAction func longTermBtnPressed(_ sender: Any) {
        goalType = .longTerm
        shortTermBtn.setDeSelectedColor()
        longTermBtn.setSelectedColor()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.goalTextView.textColor = .label
        self.goalTextView.text = ""
    }
    
}

