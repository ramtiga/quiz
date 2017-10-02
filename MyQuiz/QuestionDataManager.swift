//
//  QuestionDataManager.swift
//  MyQuiz
//
//  Created by Dai Haneda on 2017/10/02.
//  Copyright © 2017年 Dai Haneda. All rights reserved.
//

import Foundation

class QuestionData {
  var question: String
  
  var answer1: String
  var answer2: String
  var answer3: String
  var answer4: String
  
  var correctAnswerNumber: Int
  
  //問題文番号
  var questionNumber: Int = 0
  
  //ユーザ選択番号
  var userSelectNumber: Int?
  
  init(questionSourceDataArray: [String]) {
    question = questionSourceDataArray[0]
    answer1 = questionSourceDataArray[1]
    answer2 = questionSourceDataArray[2]
    answer3 = questionSourceDataArray[3]
    answer4 = questionSourceDataArray[4]
    correctAnswerNumber = Int(questionSourceDataArray[5])!
  }
  
  func isCorrect() -> Bool {
    if correctAnswerNumber == userSelectNumber {
      return true
    } else {
      return false
    }
  }
}

class QuestionDataManager {
  static let sharedInstance = QuestionDataManager()
  
  var questionDataArray = [QuestionData]()
  
  var nowQuestionIndex: Int = 0
  
  private init() {
  }
  
  //csv読み込み
  func loadQuestion() {
    questionDataArray.removeAll()
    
    nowQuestionIndex = 0
    
    guard let csvPath = Bundle.main.path(forResource: "question", ofType: "csv") else {
      print("csvファイルが見つかりません")
      return
    }
    
    do {
      let csvStringData = try String(contentsOfFile: csvPath, encoding: String.Encoding.utf8)
      
      csvStringData.enumerateLines(invoking: { (line, stop) in
        let questionSourceDataArray = line.components(separatedBy: ",")
        let questionData = QuestionData(questionSourceDataArray: questionSourceDataArray)
        
        self.questionDataArray.append(questionData)
        questionData.questionNumber = self.questionDataArray.count
      })
      
    } catch let error {
      print("エラーが発生しました。\(error)")
      return
    }
  }
  
  //次の問題取得
  func nextQuestion() -> QuestionData? {
    if nowQuestionIndex < questionDataArray.count {
      let nextQuestion = questionDataArray[nowQuestionIndex]
      nowQuestionIndex += 1
      return nextQuestion
    }
    return nil
  }
}
