//
//  ViewController.swift
//  goalpost-app
//
//  Created by Hoàng Đức on 27/10/2022.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as? AppDelegate
class GoalsVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var goals: [Goal] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
//
//        let nib = UINib(nibName: "GoalCell", bundle: .main)
//        tableView.register(nib, forCellReuseIdentifier: "cell")
        tableView.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()

        fetchCoreDataOjects()

    }
    
    func fetchCoreDataOjects() {
        self.fetch { (complete) in
            if complete {
                if goals.count >= 1 {
                    tableView.isHidden = false
                             } else {
                    tableView.isHidden = true
                }
            }
        }
    }
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        tableView.reloadData()
//    }
   

    @IBAction func addGoalBtnWasPressed(_ sender: Any) {
        guard let creatGoalVC = storyboard?.instantiateViewController(withIdentifier: "CreatGoalVC") else { return}
        presentDetail(creatGoalVC)
        tableView.reloadData()
    }
    
}
extension GoalsVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GoalCell", for: indexPath) as? GoalCell
        else {
            return UITableViewCell()
        }
        let goal = goals[indexPath.row]
        cell.configureCell(goal: goal)
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (rowAction, indexPath) in
            self.removeGoal(atIndexPath: indexPath)
            self.fetchCoreDataOjects()
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
            
          }
        
        let addAction = UITableViewRowAction(style: .normal, title: "Add") { (rowAction, indexPath) in
            self.setProgress(indexpath: indexPath)
            tableView.reloadRows(at: [indexPath], with: .fade)
        }
        addAction.backgroundColor = #colorLiteral(red: 1, green: 0.8, blue: 0, alpha: 1)
        deleteAction.backgroundColor = #colorLiteral(red: 0.7555531779, green: 0.24408716, blue: 0.1800064691, alpha: 1)
        return [deleteAction, addAction]
    }
}

// yeu cau lay du lieu
extension GoalsVC {
    
    func fetch(completion: (_ complete: Bool) -> ()) {
        guard let managedContex = appDelegate?.persistentContainer.viewContext else {return}
        
        let fetchRequest = NSFetchRequest<Goal>(entityName: "Goal")
        
        do{
          goals =  try managedContex.fetch(fetchRequest)
          completion(true)
            
        } catch {
            debugPrint("Could not fetch \(error.localizedDescription)")
            completion(false)
        }
    }
    
    // remove data
    func removeGoal(atIndexPath indexPath: IndexPath){
        guard let managedContex = appDelegate?.persistentContainer.viewContext else {return}
        
        managedContex.delete(goals[indexPath.row])
        
        do {
            try managedContex.save()
            print("Successfully remove Goal")
        } catch {
            debugPrint("could not save: \(error.localizedDescription)")
        }
        
    }
        
        func setProgress(indexpath: IndexPath) {
            guard let managedContex = appDelegate?.persistentContainer.viewContext else {return}
            
            let chosenGoal = goals[indexpath.row]
            if chosenGoal.goalProgress < chosenGoal.goalCompletionValeu{
                chosenGoal.goalProgress = chosenGoal.goalProgress + 1
            } else {
                return
            }
            do {
                try managedContex.save()
                print("Completion")
            }catch {
                debugPrint("Could not save progress \(error.localizedDescription)")
            }
        }
    }


