//
//  ViewController.swift
//  memo
//
//  Created by Anton Ni on 19/11/23.
//

import UIKit

class ViewController: UIViewController {

    var winstate = [Int]()
    var counter = 0
    var shadow = [0,0]
    var closeshadow = [0,0]
    var timer = Timer()
    var onemorecounter = 0
    
    // стейт - полесвободное или уже играли?
    var state = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupGameField()
        print(winstate)
        
    }

    @IBAction func game(_ sender: UIButton) {
        if state[sender.tag - 1] != 0 {
        
            return
            
        }
        //поле уже нажимали
        state[sender.tag - 1] = 1
        print(state)
        
        sender.setBackgroundImage(UIImage(named: "\(winstate[sender.tag-1])"), for: .normal)
        
        shadow[counter] = winstate[sender.tag-1]
        closeshadow[counter] = sender.tag
            counter += 1
        print(state)
        if shadow[1] > 0 {
            
                if shadow[0] == shadow[1] {
                    
                    print("Match")
                    counter = 0
                    shadow = [0,0]
                    closeshadow = [0,0]
                    onemorecounter += 1
                    

                } else {
                    
                    
                    timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(closecards), userInfo: nil, repeats: false)

                    
                }
            }
            
        if onemorecounter == 8 {
            let alert = UIAlertController(title: "Конец", message: "игра пройдена", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {
                UIAlertAction in
                self.clear()
            }))
            
            present(alert, animated: true)
            
        }
    }
    
    func clear(){
        onemorecounter = 0
        setupGameField()
        counter = 0
        shadow = [0,0]
        closeshadow = [0,0]
        state = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        for i in 0...15 {
            
            let button  = view.viewWithTag(i + 1) as! UIButton
            button.setBackgroundImage(UIImage(named: "0"), for: .normal)
        }
    }
    
    @objc func closecards() {
        print("щас будем закрывать картинки")
        //  обращаемся к двум кнопкам и возвращаем им закрытую картинку
        if let button1 = self.view.viewWithTag(closeshadow[0]) as? UIButton{
            button1.setBackgroundImage(UIImage(named: "0"), for: .normal)
            state[closeshadow[0] - 1] = 0
        }
        
        
        if let button2 = self.view.viewWithTag(closeshadow[1]) as? UIButton{
            button2.setBackgroundImage(UIImage(named: "0"), for: .normal)
            state[closeshadow[1] - 1] = 0
        }
        print(state)
        print(closeshadow)
        counter = 0
        shadow = [0,0]
        closeshadow = [0,0]

    }
    
  
    func setupGameField() {
        let pairs = [1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8]
        
        winstate = pairs.shuffled()
    }
}

