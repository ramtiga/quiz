//
//  QuestionViewController.swift
//  MyQuiz
//
//  Created by Dai Haneda on 2017/10/18.
//  Copyright © 2017年 Dai Haneda. All rights reserved.
//

import UIKit
import AudioToolbox

class QuestionViewController: UIViewController {
  
  var questionData: QuestionData!
  
  @IBOutlet weak var questionNoLabel: UILabel!
  @IBOutlet weak var questionTextView: UITextView!
  @IBOutlet weak var answer1Button: UIButton!
  @IBOutlet weak var answer2Button: UIButton!
  @IBOutlet weak var answer3Button: UIButton!
  @IBOutlet weak var answer4Button: UIButton!
  
  @IBOutlet weak var correctImageView: UIImageView!
  @IBOutlet weak var incorrectImageView: UIImageView!
  

    override func viewDidLoad() {
      super.viewDidLoad()
      
      questionNoLabel.text = "Q.\(questionData.questionNumber)"
      questionTextView.text = questionData.question
      answer1Button.setTitle(questionData.answer1, for: UIControlState.normal)
      answer2Button.setTitle(questionData.answer2, for: UIControlState.normal)
      answer3Button.setTitle(questionData.answer3, for: UIControlState.normal)
      answer4Button.setTitle(questionData.answer4, for: UIControlState.normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

  @IBAction func tapAnswer1Button(_ sender: Any) {
    questionData.userSelectNumber = 1
    goNextQuestionWithAnimation()
  }
  
  @IBAction func tapAnswer2Button(_ sender: Any) {
    questionData.userSelectNumber = 2
    goNextQuestionWithAnimation()
  }
  
  @IBAction func tapAnswer3Button(_ sender: Any) {
    questionData.userSelectNumber = 3
    goNextQuestionWithAnimation()
  }
  
  
  @IBAction func tapAnswer4Button(_ sender: Any) {
    questionData.userSelectNumber = 4
    goNextQuestionWithAnimation()
  }
  
  func goNextQuestionWithAnimation() {
    if questionData.isCorrect() {
      goNextQuestionWithCorrectAnimation()
    } else {
      goNextQuestionWithInCorrectAnimation()
    }
  }
  
  func goNextQuestionWithCorrectAnimation() {
    //正解音
    AudioServicesPlayAlertSound(1025)
    
    //アニメーション
    UIView.animate(withDuration: 2.0, animations: {
      self.correctImageView.alpha = 1.0
    }) { (Bool) in
      self.goNextQuestion()
    }
  }
  
  func goNextQuestionWithInCorrectAnimation() {
    //不正解音
    AudioServicesPlayAlertSound(1006)
    
    //アニメーション
    UIView.animate(withDuration: 2.0, animations: {
      self.incorrectImageView.alpha = 1.0
    }) { (Bool) in
      self.goNextQuestion()
    }
  }
  
  //次の問題へ
  func goNextQuestion() {
    //次があるかどうか
    guard let nextQuestion = QuestionDataManager.sharedInstance.nextQuestion() else {
      if let resultViewController = storyboard?.instantiateViewController(withIdentifier: "result") as? ResultViewController {
        present(resultViewController, animated: true, completion: nil)
      }
      return
    }
    
    if let nextQuestionViewController = storyboard?.instantiateViewController(withIdentifier: "question") as? QuestionViewController {
      nextQuestionViewController.questionData = nextQuestion
      
      present(nextQuestionViewController, animated: true, completion: nil)
    }
    
  }
}
