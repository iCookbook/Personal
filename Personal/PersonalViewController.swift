//
//  PersonalViewController.swift
//  Personal
//
//  Created by Егор Бадмаев on 27.10.2022.
//  
//

import UIKit
import Resources

final class PersonalViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private let output: PersonalViewOutput
    
    // MARK: - Init
    
    init(output: PersonalViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Texts.Personal.title
        view.backgroundColor = Colors.systemBackground
    }
}

extension PersonalViewController: PersonalViewInput {
}
