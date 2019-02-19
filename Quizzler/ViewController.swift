//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Place your instance variables here
    let allQuestions = QuestionBank()
    var pickedAnswer : Bool = false
    var currentQuestionIndex : Int = 0
    var score : Int = 0
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextQuestion()
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
        if(sender.tag == 1){
            pickedAnswer = true
        }else{
            pickedAnswer = false
        }
        checkAnswer()
    }
    
    
    func updateUI() {
      questionLabel.text = allQuestions.list[currentQuestionIndex].questionText
      scoreLabel.text = "Score: \(score)"
      progressLabel.text = "\(currentQuestionIndex+1) / 13"
      progressBar.frame.size.width = (view.frame.size.width / 13) * CGFloat(currentQuestionIndex+1)
    }
    

    func nextQuestion() {
        if(currentQuestionIndex != allQuestions.list.count ){
            updateUI()
        }else{
            let alert = UIAlertController(title: "Awesome", message: "You've finished all the questions, do you want to start over?", preferredStyle: .alert)
            let actionRestart = UIAlertAction(title: "Restart", style: .default, handler: { (actionRestart) in
                self.startOver()
            })
            let actionCancel = UIAlertAction(title: "Cancel", style: .default, handler: { (actionCancel) in
                self.currentQuestionIndex = self.allQuestions.list.count - 2
                alert.dismiss(animated: true, completion: nil)
            })
            alert.addAction(actionCancel)
            alert.addAction(actionRestart)
            present(alert, animated: true, completion: nil)
        }
    }
    
    
    func checkAnswer() {
        let ans = allQuestions.list[currentQuestionIndex].answer
        if(pickedAnswer == ans){
            ProgressHUD.showSuccess("Correct")
            score += 1
        }else{
            ProgressHUD.showError("Wrong!")
        }
        currentQuestionIndex += 1
        nextQuestion()
    }
    
    
    func startOver() {
       currentQuestionIndex = 0
       score = 0
       nextQuestion()
    }
    

    
}
