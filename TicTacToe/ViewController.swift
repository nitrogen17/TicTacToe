//
//  ViewController.swift
//  TicTacToe
//
//  Created by Jonorsky Navarrete on 6/2/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var board: UIView!

    @IBOutlet weak var _00: UIImageView!
    @IBOutlet weak var _01: UIImageView!
    @IBOutlet weak var _02: UIImageView!

    @IBOutlet weak var _10: UIImageView!
    @IBOutlet weak var _11: UIImageView!
    @IBOutlet weak var _12: UIImageView!

    @IBOutlet weak var _20: UIImageView!
    @IBOutlet weak var _21: UIImageView!
    @IBOutlet weak var _22: UIImageView!

    var turn: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
//        setupBoard(

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

    private func click(imageView: UIImageView, closure: () -> Void) {
        vibrateButton()
        guard let _ = imageView.image else {
            if turn {
                imageView.image = UIImage(named: "imageX.png")
            } else {
                imageView.image = UIImage(named: "imageO.png")
            }
            turn.toggle()
            closure()

            return
        }
        closure()
    }

    @objc func click00() {
        print("Imageview Clicked", #function)
        click(imageView: _00) {
            _00.shake()
            _00.shake(0.1)
        }
    }

    @objc func click01() {
        print("Imageview Clicked", #function)
        click(imageView: _01) {
            _01.shake()
            _01.shake(0.1)
        }
    }

    @objc func click02() {
        print("Imageview Clicked", #function)
        click(imageView: _02) {
        _02.shake()
        _02.shake(0.1)
        }
    }

    @objc func click20() {
        print("Imageview Clicked", #function)
        click(imageView: _20) {
        _20.shake()
        _20.shake(0.2)
        }
    }

    @objc func click21() {
        print("Imageview Clicked", #function)
        click(imageView: _21) {
        _21.shake()
        _21.shake(0.2)
        }
    }

    @objc func click22() {
        print("Imageview Clicked", #function)
        click(imageView: _22) {
        _22.shake()
        _22.shake(0.2)
        }
    }

    @objc func click10() {
        print("Imageview Clicked", #function)
        click(imageView: _10) {
        _10.shake()
        _10.shake(0.2)
        }
    }

    @objc func click11() {
        print("Imageview Clicked", #function)
        click(imageView: _11) {
        _11.shake()
        _11.shake(0.2)
        }
    }

    @objc func click12() {
        print("Imageview Clicked", #function)
        click(imageView: _12) {
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

    @IBAction func clickReset(_ sender: UIButton) {
        _00.image = nil
        _01.image = nil
        _02.image = nil

        _10.image = nil
        _11.image = nil
        _12.image = nil

        _20.image = nil
        _21.image = nil
        _22.image = nil
    }

}


extension UIView {
    func shake(_ duration: Double? = 0.4) {
        self.transform = CGAffineTransform(translationX: 20, y: 0)
        UIView.animate(withDuration: duration ?? 0.4, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.transform = CGAffineTransform.identity
        }, completion: nil)
    }
}

