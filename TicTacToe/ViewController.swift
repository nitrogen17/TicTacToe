//
//  ViewController.swift
//  TicTacToe
//
//  Created by Jonorsky Navarrete on 6/2/22.
//

import UIKit
import AVKit
import PopBounceButton
import ConfettiView

enum SoundName: String {
    case clickCell = "mixkit-arcade-game-jump-coin-216"
    case clickReset = "mixkit-video-game-mystery-alert-234"
}

class ViewController: UIViewController {

    @IBOutlet weak var tictactoeLogo: UIImageView!

    @IBOutlet weak var board: UIView!
    @IBOutlet weak var labelPosition: UILabel!

    @IBOutlet weak var resetButton: PopBounceButton! {
        didSet {
            resetButton.imageView?.contentMode = .scaleAspectFill
        }
    }

    @IBOutlet weak var confetti: ConfettiView!


    private let gradientLayer: CAGradientLayer = {
        let gradient = CAGradientLayer()
        let greenColor = UIColor(red: 39/255, green: 216/255, blue: 91/255, alpha: 1).cgColor
        let tealColor = UIColor(red: 30/255, green: 228/255, blue: 188/255, alpha: 1).cgColor
        gradient.colors = [greenColor, tealColor]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        return gradient
    }()

    @IBOutlet weak var _00: UIImageView!
    @IBOutlet weak var _01: UIImageView!
    @IBOutlet weak var _02: UIImageView!

    @IBOutlet weak var _10: UIImageView!
    @IBOutlet weak var _11: UIImageView!
    @IBOutlet weak var _12: UIImageView!

    @IBOutlet weak var _20: UIImageView!
    @IBOutlet weak var _21: UIImageView!
    @IBOutlet weak var _22: UIImageView!

    var grid = [[".",".","."],
                [".",".","."],
                [".",".","."]]

    var boardCheck = [[[Int]]]()

    var turn: Bool = false

    var player: AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()

        addGradientButton()
        addViewBoardWithShadow()
        addAnimationInResetButton()

        view.backgroundColor = UIColor(red: 243/255, green: 245/255, blue: 248/255, alpha: 1)

        setupBoard1()

        var tap = UITapGestureRecognizer(target: self, action: #selector(click00))
        _00?.isUserInteractionEnabled = true
        _00?.addGestureRecognizer(tap)

        tap = UITapGestureRecognizer(target: self, action: #selector(click01))
        _01?.isUserInteractionEnabled = true
        _01?.addGestureRecognizer(tap)

        tap = UITapGestureRecognizer(target: self, action: #selector(click02))
        _02?.isUserInteractionEnabled = true
        _02?.addGestureRecognizer(tap)

        tap = UITapGestureRecognizer(target: self, action: #selector(click20))
        _20?.isUserInteractionEnabled = true
        _20?.addGestureRecognizer(tap)

        tap = UITapGestureRecognizer(target: self, action: #selector(click21))
        _21?.isUserInteractionEnabled = true
        _21?.addGestureRecognizer(tap)

        tap = UITapGestureRecognizer(target: self, action: #selector(click22))
        _22?.isUserInteractionEnabled = true
        _22?.addGestureRecognizer(tap)

        tap = UITapGestureRecognizer(target: self, action: #selector(click10))
        _10?.isUserInteractionEnabled = true
        _10?.addGestureRecognizer(tap)

        tap = UITapGestureRecognizer(target: self, action: #selector(click11))
        _11?.isUserInteractionEnabled = true
        _11?.addGestureRecognizer(tap)

        tap = UITapGestureRecognizer(target: self, action: #selector(click12))
        _12?.isUserInteractionEnabled = true
        _12?.addGestureRecognizer(tap)
    }

    private func addAnimationInResetButton() {
        resetButton.springSpeed = 15
        resetButton.springBounciness = 19
        resetButton.springVelocity = 5
        resetButton.longPressScaleFactor = 0.9

        resetButton.layer.insertSublayer(gradientLayer, at: 0)
        gradientLayer.frame = resetButton.bounds
    }

    private func setupBoard1() {
        boardCheck.append([[0, 0], [0, 1], [0, 2]])
        boardCheck.append([[1, 0], [1, 1], [1, 2]])
        boardCheck.append([[2, 0], [2, 1], [2, 2]])
        boardCheck.append([[0, 0], [1, 0], [2, 0]])
        boardCheck.append([[0, 1], [1, 1], [2, 1]])
        boardCheck.append([[0, 2], [1, 2], [2, 2]])
        boardCheck.append([[0, 0], [1, 1], [2, 2]])
        boardCheck.append([[2, 0], [1, 1], [0, 2]])
    }

    func tictactoe(char: String) -> Bool {
        var flag = false
        for line in boardCheck {
            let _a =  grid[ line[0][0] ][ line[0][1] ]
            let _b =  grid[ line[1][0] ][ line[1][1] ]
            let _c =  grid[ line[2][0] ][ line[2][1] ]

            if _a == _b && _b == _c && _a == char {
//                playClickSound(soundName: .clickReset)
                print("Tic Tac Toe \(char) at \(line)")
                flag = true
                break
            } else {
                flag = false
            }
        }
        if flag {
            return true
        } else {
            return false
        }
    }

    private func addGradientButton() {

        let gradientOrange = CAGradientLayer()
        gradientOrange.colors = [

          UIColor(red: 1, green: 0.757, blue: 0.027, alpha: 1).cgColor,

          UIColor(red: 0.992, green: 0.494, blue: 0.078, alpha: 1).cgColor

        ]
        gradientOrange.frame.size = resetButton.frame.size
        resetButton.layer.addSublayer(gradientOrange)

        resetButton.setTitle("RESET", for: .normal)
        resetButton.setTitleColor(UIColor.white, for: .normal)

        resetButton.layer.cornerRadius = resetButton.bounds.height / 2
        resetButton.clipsToBounds = true
    }

    private func addViewBoardWithShadow() {

        var view = UILabel()
        view.frame = CGRect(x: 0, y: 0, width: board.frame.width + 30, height: board.frame.height + 30)

        view.backgroundColor = .white

        var shadows = UIView()
        shadows.frame = view.frame
        shadows.clipsToBounds = false

        view.addSubview(shadows)

        let shadowPath0 = UIBezierPath(roundedRect: shadows.bounds, cornerRadius: 20)

        let layer0 = CALayer()
        layer0.shadowPath = shadowPath0.cgPath
        layer0.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.15).cgColor
        layer0.shadowOpacity = 1
        layer0.shadowRadius = 14
        layer0.shadowOffset = CGSize(width: 4, height: 4)
        layer0.bounds = shadows.bounds
        layer0.position = shadows.center

        shadows.layer.addSublayer(layer0)

        var shapes = UIView()
        shapes.frame = view.frame
        shapes.clipsToBounds = true

        view.addSubview(shapes)

        let layer1 = CALayer()

        layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        layer1.bounds = shapes.bounds
        layer1.position = shapes.center

        shapes.layer.addSublayer(layer1)
        shapes.layer.cornerRadius = 20
        shapes.layer.borderWidth = 1

        shapes.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor

        var parent = self.view!

        board.insertSubview(view, at: 0)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.leadingAnchor.constraint(equalTo: board.leadingAnchor, constant: -15).isActive = true
        view.topAnchor.constraint(equalTo: board.topAnchor, constant: -15).isActive = true
    }

    private func click(imageView: UIImageView, position: [Int], closure: () -> Void) {
        vibrateButton()

        guard let _ = imageView.image else {
            if turn {
                imageView.image = UIImage(named: "imageX-clean.png")
                grid[position[0]][position[1]] = "X"
            } else {
                imageView.image = UIImage(named: "imageO-clean.png")
                grid[position[0]][position[1]] = "O"
            }
            turn.toggle()

            grid.forEach { x in
                print(x)
            }

            if tictactoe(char: grid[position[0]][position[1]]) {
                playClickSound(soundName: .clickReset)
                tictactoeLogo.shakeUp()
                tictactoeLogo.shakeUp(0.1)

                var motivQ = [String]()
                motivQ.append("“A champion is someone who gets up when he can’t.” – Jack Dempsey")
                motivQ.append("“Always bear in mind that your own resolution to success is more important than any other one thing.” – Abraham Lincoln")
                motivQ.append("“What one man can do, another can do!” – Charles Morse")
                motivQ.append("“It is a rough road that leads to the heights of greatness.” – Seneca")
                motivQ.append("“Security is mostly a superstition.  Life is either a daring adventure or nothing.” – Helen Keller")
                motivQ.append(" “Don’t let what you cannot do interfere with what you can do.” – John R. Wooden")
                motivQ.append("“Men of action are favored by the goddess of good luck.” – George S. Clason")
                motivQ.append("“Strength and growth come only through continuous effort and struggle.” – Napoleon Hill")
                motivQ.append("“It’s not whether you get knocked down, it’s whether you get up.” – Vince Lombardi")
                motivQ.append("“If you can dream it, you can do it.” – Walt Disney")

                if grid[position[0]][position[1]] == "X" {
                    /// motivQ[Int.random(in: 0 ..< motivQ.count)]
                    showAlert(title: "X win!", message: "")
                } else {
                    showAlert(title: "O win!", message: "")
                }
//                _01.shakeUp()
//                _01.shakeUp(0.1)
                return
            } else {
                playClickSound(soundName: .clickCell)
            }

            closure()

            return
        }
        grid.forEach { x in
            print(x)
        }
        playClickSound(soundName: .clickCell)
        closure()
    }

    @objc func click00() {
        print("Imageview Clicked", #function)
        click(imageView: _00, position: [0,0]) {
            _00.shake()
            _00.shake(0.1)
        }
    }

    @objc func click01() {
        print("Imageview Clicked", #function)
        click(imageView: _01, position: [0,1]) {
            _01.shake()
            _01.shake(0.1)
        }
    }

    @objc func click02() {
        print("Imageview Clicked", #function)
        click(imageView: _02, position: [0,2]) {
        _02.shake()
        _02.shake(0.1)
        }
    }

    @objc func click20() {
        print("Imageview Clicked", #function)
        click(imageView: _20, position: [2,0]) {
        _20.shake()
        _20.shake(0.2)
        }
    }

    @objc func click21() {
        print("Imageview Clicked", #function)
        click(imageView: _21, position: [2,1]) {
        _21.shake()
        _21.shake(0.2)
        }
    }

    @objc func click22() {
        print("Imageview Clicked", #function)
        click(imageView: _22, position: [2,2]) {
        _22.shake()
        _22.shake(0.2)
        }
    }

    @objc func click10() {
        print("Imageview Clicked", #function)
        click(imageView: _10, position: [1,0]) {
        _10.shake()
        _10.shake(0.2)
        }
    }

    @objc func click11() {
        print("Imageview Clicked", #function)
        click(imageView: _11, position: [1,1]) {
        _11.shake()
        _11.shake(0.2)
        }
    }

    @objc func click12() {
        print("Imageview Clicked", #function)
        click(imageView: _12, position: [1,2]) {
        _12.shake()
        _12.shake(0.2)
        }
    }

    private func setupBoard() {
        guard let viewShadow = board else { return }
        viewShadow.center = self.view.center
        viewShadow.backgroundColor = UIColor.black
        viewShadow.layer.shadowColor = UIColor.gray.cgColor
        viewShadow.layer.shadowOpacity = 1
        viewShadow.layer.shadowOffset = CGSize.zero
        viewShadow.layer.shadowRadius = 5
    }

    func vibrateButton() {
        let feedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
        feedbackGenerator.impactOccurred()
    }

    func playClickSound(soundName: SoundName) {
        guard let url = Bundle.main.url(forResource: soundName.rawValue, withExtension: "wav") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            /* iOS 10 and earlier require the following line:
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */

            guard let player = player else { return }

            player.play()
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                player.play()
//            }

        } catch let error {
            print(error.localizedDescription)
        }
    }

    @IBAction func clickReset(_ sender: UIButton) {
        playClickSound(soundName: .clickReset)
        _00.image = nil
        _01.image = nil
        _02.image = nil

        _10.image = nil
        _11.image = nil
        _12.image = nil

        _20.image = nil
        _21.image = nil
        _22.image = nil

        grid = [[".",".","."],
                   [".",".","."],
                   [".",".","."]]

        grid.forEach { x in
            print(x)
        }
    }

}


extension UIView {
    func shake(_ duration: Double? = 0.4) {
        self.transform = CGAffineTransform(translationX: 20, y: 0)
        UIView.animate(withDuration: duration ?? 0.4, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.transform = CGAffineTransform.identity
        }, completion: nil)
    }

    func shakeUp(_ duration: Double? = 0.4) {
        self.transform = CGAffineTransform(translationX: 0, y: 20)
        UIView.animate(withDuration: duration ?? 0.4, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.transform = CGAffineTransform.identity
        }, completion: nil)
    }
}

extension ViewController {

    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        confetti.emit(with: [
          .text("🌟"),
          .text("✨"),
          .shape(.circle, .purple),
          .shape(.triangle, .lightGray)
        ]) {_ in
         print("$$ Execute confetti")
        }


        let action = UIAlertAction(title: "OK", style: .cancel) {_ in
            self.clickReset(UIButton())
        }
        alert.addAction(action)

        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }

}
