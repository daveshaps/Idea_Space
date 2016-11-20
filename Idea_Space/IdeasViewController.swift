//
//  IdeasViewController.swift
//  Idea_Space
//
//  Created by Wish Carr on 11/16/16.
//  Copyright © 2016 David Shapiro. All rights reserved.
//

import UIKit

class IdeasViewController: UIViewController {

    //MARK: Properties
    
    @IBOutlet weak var questionTextView: UITextView!
    
    @IBOutlet weak var askAQuestionButton: UIButton!
    
    @IBOutlet weak var responseTableView: UITableView!
    
    
    
    //MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: Memory

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
