//
//  GoalCell.swift
//  goalpost-app
//
//  Created by Hoàng Đức on 27/10/2022.
//

import UIKit

class GoalCell: UITableViewCell {
    
    @IBOutlet weak var goalDescriptionLbl: UILabel!
    
    @IBOutlet weak var goalTypeLbl: UILabel!
    
    @IBOutlet weak var goalProgressLbl: UILabel!
    
    @IBOutlet weak var completionView: UIView!
    func configureCell(goal: Goal) {
        self.goalProgressLbl.text = String(describing: goal.goalProgress)
        self.goalDescriptionLbl.text = goal.goalDescription
        self.goalTypeLbl.text = goal.goalType
        
        if goal.goalProgress == goal.goalCompletionValeu {
            self.completionView.isHidden = false
        } else {
            self.completionView.isHidden = true
        }
    }
}
