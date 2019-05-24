//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // variables
    let allQuestions = QuestionBank()
    var pickedAnswer: Bool = false
    var questionNumber: Int = 0
    var rightAnswerCount: Int = 0
    var score: Int = 0
    
    // outlets
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let firstQuestion = allQuestions.questionList[0]
        
        questionLabel.text = firstQuestion.questionText
        
        progressLabel.text = "\(rightAnswerCount) / 13"
        
        scoreLabel.text = "Score: 0 / 65"
    }

    
    // answer pressed
    @IBAction func answerPressed(_ sender: AnyObject) {
        if sender.tag == 1 {
            pickedAnswer = true
        } else if sender.tag == 2 {
            pickedAnswer = false
        }
        
        checkAnswer()
        questionNumber += 1
        nextQuestion()
  
    }
    
    
    func updateUI() {
        scoreLabel.text = "Score: \(score) / 65"
        progressLabel.text = "\(rightAnswerCount) / 13"
        questionLabel.text = allQuestions.questionList[questionNumber].questionText
        progressBar.frame.size.width = (view.frame.size.width / 13) * CGFloat(questionNumber + 1)
    }
    

    func nextQuestion() {
        
        if questionNumber < 13 {
            updateUI()
            
        } else {
            
            let alert = UIAlertController(title: "Finish", message: "Do you want to start over?", preferredStyle: .alert)
            print("End of quiz")
            
            let restart = UIAlertAction(title: "Let's start over", style: .default) { (UIAlertAction) in
                self.startOver()
            }
            
            alert.addAction(restart)
            
            present(alert, animated: true, completion: nil)
        }
        
    }
    
    
    func checkAnswer() {
        
        let correctAnswer = allQuestions.questionList[questionNumber].answer
        
        if correctAnswer == pickedAnswer {
            rightAnswerCount += 1
            score += 5
            print("You got it")
            updateUI()
            
            progressLabel.text = "\(rightAnswerCount) / 13"
            
        } else {
            print("wrong")
        }
    }
    
    
    func startOver() {
        questionNumber = 0
        rightAnswerCount = 0
        score = 0
        
        nextQuestion()
    }
    

    
}
