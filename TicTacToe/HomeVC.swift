//
//  HomeVC.swift
//  TicTacToe
//
//  Created by Jonorsky Navarrete on 6/23/22.
//

import UIKit
import PopBounceButton

class HomeVC: UIViewController {

    @IBOutlet weak var tictactoelogo: UIImageView!
    @IBOutlet weak var onevsone: PopBounceButton!
    @IBOutlet weak var onevsai: PopBounceButton!

    @IBOutlet weak var onevsai15: PopBounceButton!
    @IBOutlet weak var undefeatedai: PopBounceButton!
    @IBOutlet weak var tictactoeultimate: PopBounceButton!

    @IBAction func clickOneVsOne(_ sender: PopBounceButton) {
        performSegue(withIdentifier: "goToOneVsOne", sender: nil)
    }

    @IBAction func clickOneVsAI(_ sender: PopBounceButton) {
        performSegue(withIdentifier: "goToOneVsAi", sender: nil)
    }


    private let gradientLayer: CAGradientLayer = {
        let gradient = CAGradientLayer()
        let greenColor = UIColor(red: 39/255, green: 216/255, blue: 91/255, alpha: 1).cgColor
        let tealColor = UIColor(red: 30/255, green: 228/255, blue: 188/255, alpha: 1).cgColor
        gradient.colors = [greenColor, tealColor]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        return gradient
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//            self.tictactoelogo.shakeUp()
//            self.tictactoelogo.shakeUp(0.1)
//        }

        addAnimationInResetButton()
        addGradientButton()
        addAnimationInResetButton1()
        addGradientButton1()

    }

    private func addAnimationInResetButton() {
        onevsone.springSpeed = 15
        onevsone.springBounciness = 19
        onevsone.springVelocity = 5
        onevsone.longPressScaleFactor = 0.9

        onevsone.layer.insertSublayer(gradientLayer, at: 0)
        gradientLayer.frame = onevsone.bounds
    }

    private func addGradientButton() {

        let gradientOrange = CAGradientLayer()
        gradientOrange.colors = [

          UIColor(red: 1, green: 0.757, blue: 0.027, alpha: 1).cgColor,

          UIColor(red: 0.992, green: 0.494, blue: 0.078, alpha: 1).cgColor

        ]
        gradientOrange.frame.size = onevsone.frame.size
        onevsone.layer.addSublayer(gradientOrange)

        onevsone.setTitle("1 VS 1", for: .normal)
        onevsone.setTitleColor(UIColor.white, for: .normal)

        onevsone.layer.cornerRadius = onevsone.bounds.height / 2
        onevsone.clipsToBounds = true
    }

    private func addAnimationInResetButton1() {
        onevsai.springSpeed = 15
        onevsai.springBounciness = 19
        onevsai.springVelocity = 5
        onevsai.longPressScaleFactor = 0.9

        onevsai.layer.insertSublayer(gradientLayer, at: 0)
        gradientLayer.frame = onevsone.bounds
    }

    private func addGradientButton1() {

        let gradientOrange = CAGradientLayer()
        gradientOrange.colors = [

          UIColor(red: 1, green: 0.757, blue: 0.027, alpha: 1).cgColor,

          UIColor(red: 0.992, green: 0.494, blue: 0.078, alpha: 1).cgColor

        ]
        gradientOrange.frame.size = onevsai.frame.size
        onevsai.layer.addSublayer(gradientOrange)

        onevsai.setTitle("1 VS AI", for: .normal)
        onevsai.setTitleColor(UIColor.white, for: .normal)

        onevsai.layer.cornerRadius = onevsai.bounds.height / 2
        onevsai.clipsToBounds = true

        // -
        onevsai15.layer.addSublayer(gradientOrange)

        onevsai15.setTitle("1 VS AI 15 Board", for: .normal)
        onevsai15.setTitleColor(UIColor.white, for: .normal)

        onevsai15.layer.cornerRadius = onevsai.bounds.height / 2
        onevsai15.clipsToBounds = true

        // -
        undefeatedai.layer.addSublayer(gradientOrange)

        undefeatedai.setTitle("Undefeated AI", for: .normal)
        undefeatedai.setTitleColor(UIColor.white, for: .normal)

        undefeatedai.layer.cornerRadius = onevsai.bounds.height / 2
        undefeatedai.clipsToBounds = true

        // -
        tictactoeultimate.layer.addSublayer(gradientOrange)

        tictactoeultimate.setTitle("Tictactoe Ultimate", for: .normal)
        tictactoeultimate.setTitleColor(UIColor.white, for: .normal)

        tictactoeultimate.layer.cornerRadius = onevsai.bounds.height / 2
        tictactoeultimate.clipsToBounds = true
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToOneVsAi" {
            if let nextViewController = segue.destination as? GameVC {
                nextViewController.enableAi = true
            }
        }
    }


}
