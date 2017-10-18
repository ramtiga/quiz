//
//  ResultViewController.swift
//  MyQuiz
//
//  Created by Dai Haneda on 2017/10/18.
//  Copyright © 2017年 Dai Haneda. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

  @IBOutlet weak var correctPercentLabel: UILabel!
  
  override func viewDidLoad() { super.viewDidLoad()
    
    let questionCount = QuestionDataManager.sharedInstance.questionDataArray.count
    
    var correctCount: Int = 0
    
    //正解数
    for questionData in QuestionDataManager.sharedInstance.questionDataArray {
      if questionData.isCorrect() {
        correctCount += 1
      }
    }
    
    //正解率
    let correctPercent: Float = (Float(correctCount) / Float(questionCount)) * 100
    
    //正解率表示
    correctPercentLabel.text = String(format: "%.lf", correctPercent) + "%"
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}
