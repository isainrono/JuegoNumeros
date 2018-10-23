//
//  ViewController.swift
//  JuegoNumeros
//
//  Created by ISAIN RODRIGUEZ on 16/10/18.
//  Copyright © 2018 ISAIN RODRIGUEZ. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Declaracion Array de numeros aleatorios desordenado
    var arrayDesordenado = [Int]()
    
    // Declaracion Array de numeros aleatorios ordenados
    var arrayOrdenado = [Int]()
    
    // numeros Aleatorios
    var number = 0
    
    // Declaracion cuenta atras contador
    @IBOutlet weak var timerLabel: UILabel!
    var countdownTimer: Timer!
    var totalTime = 60
    
    @IBOutlet weak var contador: UILabel!
    
    @IBOutlet weak var btnone: UIButton!
    @IBOutlet weak var btntwo: UIButton!
    @IBOutlet weak var btnthree: UIButton!
    @IBOutlet weak var btnfour: UIButton!
    @IBOutlet weak var btnfive: UIButton!
    @IBOutlet weak var btnsix: UIButton!
    
    @IBOutlet weak var btnIni: UIButton!
    
    @IBAction func btnReini(_ sender: UIButton) {
        timeFormatted(totalTime)
        for i in 0..<6 {
            number = Int.random(in: -100 ..< 100)
            arrayDesordenado.append(number)
            arrayOrdenado.append(number)
        }
        
        btnone.isHidden = false
        btntwo.isHidden = false
        btnthree.isHidden = false
        btnfour.isHidden = false
        btnfive.isHidden = false
        btnsix.isHidden = false
 
    }
    
    
    
    @IBAction func btnController(_ sender: UIButton) {
        if Int(sender.currentTitle!) == arrayOrdenado[0] {
            sender.isHidden = true
            arrayOrdenado.removeFirst()
            if arrayOrdenado.count == 0 {
                print("juego terminado")
                endTimer()
                arrayDesordenado.removeAll()
                btnIni.isHidden = false
                rellenarArray()
                cambiarBotones()
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startTimer()
        btnIni.isHidden = true
        contador.isHidden = false
        
        rellenarArray()
        
        cambiarBotones()
        
        arrayOrdenado.sort()
        
    }

    
    // Funciones
    
    
    func rellenarArray() {
        for i in 0..<6 {
            number = Int.random(in: -100 ..< 100)
            arrayDesordenado.append(number)
            arrayOrdenado.append(number)
        }
    }
    
    func cambiarBotones() {
        btnone.setTitle(String(arrayDesordenado[0]), for: .normal)
        btntwo.setTitle(String(arrayDesordenado[1]), for: .normal)
        btnthree.setTitle(String(arrayDesordenado[2]), for: .normal)
        btnfour.setTitle(String(arrayDesordenado[3]), for: .normal)
        btnfive.setTitle(String(arrayDesordenado[4]), for: .normal)
        btnsix.setTitle(String(arrayDesordenado[5]), for: .normal)
    }
    

    
    func startTimer() {
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    @objc func updateTime() {
        contador.text = "\(timeFormatted(totalTime))"
        
        if totalTime != 0 {
            totalTime -= 1
        } else {
            endTimer()
        }
    }
    
    func endTimer() {
        countdownTimer.invalidate()
    }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        //     let hours: Int = totalSeconds / 3600
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    
    @IBAction func startTimerPressed(_ sender: UIButton) {
        startTimer()
    }

}

