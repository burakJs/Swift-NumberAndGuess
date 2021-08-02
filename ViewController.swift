//
//  ViewController.swift
//  NumberAndGuess
//
//  Created by Burak İmdat on 2.08.2021.
//

import UIKit

class ViewController: UIViewController {

   
    @IBOutlet weak var txtSaveNumber: UITextField!
    @IBOutlet weak var imgSaveNumberState: UIImageView!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var txtGuess: UITextField!
    @IBOutlet weak var imgGuessState: UIImageView!
    @IBOutlet weak var btnGuess: UIButton!
    @IBOutlet weak var lblResult: UILabel!
    @IBOutlet weak var imgStar1: UIImageView!
    @IBOutlet weak var imgStar2: UIImageView!
    @IBOutlet weak var imgStar3: UIImageView!
    @IBOutlet weak var imgStar4: UIImageView!
    @IBOutlet weak var imgStar5: UIImageView!
    
    var stars : [UIImageView] = [UIImageView]()
    var maxRemainingAttempts : Int = 5
    var remainingAttempts : Int = 0
    var savedNumber = -1
    var isSuccess : Bool = false
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stars = [imgStar1, imgStar2, imgStar3, imgStar4, imgStar5]
        imgSaveNumberState.isHidden = true
        imgGuessState.isHidden = true
        btnGuess.isEnabled = false
        txtSaveNumber.isSecureTextEntry = true
        lblResult.text = ""
    }

    @IBAction func saveNumberClicked(_ sender: Any) {
        imgSaveNumberState.isHidden = false
        
        if let number = Int(txtSaveNumber.text!) {
            savedNumber = number
            btnGuess.isEnabled = true
            txtSaveNumber.isEnabled = false
            txtGuess.isEnabled = true
            btnSave.isEnabled = false
            imgSaveNumberState.image = UIImage(named: "tick")
        }else {
            imgSaveNumberState.image = UIImage(named: "error")
        }
        
    }
    
    @IBAction func guessClicked(_ sender: Any) {
        if isSuccess || remainingAttempts > maxRemainingAttempts {
            return
        }
        imgGuessState.isHidden = false
        
        if let userNumber = Int(txtGuess.text!) {
            remainingAttempts += 1
            stars[maxRemainingAttempts - remainingAttempts].image = UIImage(named: "emptyStar")
            
            if userNumber > savedNumber {
                setImageState(image: "down")
            }else if userNumber < savedNumber {
                setImageState(image: "up")
            } else {
                winGame()
                return
            }
        } else {
            imgGuessState.image = UIImage(named: "error")
        
        }
        if remainingAttempts == maxRemainingAttempts {
            lostGame()
            return
        }
    }
    
    func setImageState(image : String) {
        imgGuessState.image = UIImage(named: image)
        txtGuess.backgroundColor = .red
    }
    
    func winGame(){
        imgGuessState.image = UIImage(named: "ok")
        btnSave.isEnabled = true
        lblResult.text = "GUESS IS TRUE"
        txtGuess.backgroundColor = .systemBlue
        txtSaveNumber.isSecureTextEntry = false
        isSuccess = true
        
        showAlert(title: "SUCCESS", message: "Your guess is true, well done", actionTitle: "OK")
    }
    
    func lostGame() {
        btnGuess.isEnabled = true
        imgGuessState.image = UIImage(named: "error")
        lblResult.text = "GAME OVER \n\(savedNumber) is true"
        txtSaveNumber.isSecureTextEntry = false
        showAlert(title: "UNSUCCESS", message: "All remaining attempts is finish, True Number is \(savedNumber)", actionTitle: "OK")
    }
    
    func showAlert(title : String, message : String, actionTitle : String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: actionTitle, style: .default, handler: nil)
        alertController.addAction(okAction)
        let gameOverAction = UIAlertAction(title: "PLAY AGAIN", style: .default) { (action : UIAlertAction) in
            self.resetGame()
        }
        alertController.addAction(gameOverAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func resetGame() {
        remainingAttempts = 0
        savedNumber = -1
        isSuccess = false
        txtSaveNumber.isEnabled = true
        txtGuess.isEnabled = false
        for star in stars {
            star.image = UIImage(named: "star")
        }
        imgGuessState.isHidden = true
        imgSaveNumberState.isHidden = true
        lblResult.text = ""
        btnSave.isEnabled = true
        btnGuess.isEnabled = false
        txtGuess.backgroundColor = .white
        txtSaveNumber.isSecureTextEntry = true
        txtGuess.text = ""
        txtSaveNumber.text = ""
    }
}

