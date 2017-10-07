//
//  StartViewController.swift
//  MyQuiz
//
//  Created by Dai Haneda on 2017/10/05.
//  Copyright © 2017年 Dai Haneda. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //問題読み込み
    QuestionDataManager.sharedInstance.loadQuestion()
    
    guard let nextViewController = segue.destination as? QuestionViewController else {
      return
    }
    //問題とりだし
    guard let guestionData = QuestionDataManager.sharedInstance.nextQuestion() else {
      return
    }
    //問題文セット
    nextViewController.questionData = questionData
  }
  
  @IBAction func goToTitle(_ segue: UIStoryboard) {
  }
}
