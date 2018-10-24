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
    
    // score inicial
    var scoreCounter = 0
    
    // Label contador de score
    @IBOutlet weak var score: UILabel!
    
    // Texto GAMEOVER
    @IBOutlet weak var gameOver: UILabel!
    
    // Declaracion cuenta atras contador
    @IBOutlet weak var timerLabel: UILabel!
    var countdownTimer: Timer!
    var totalTime = 30
    
    @IBOutlet weak var contador: UILabel!
    
    @IBOutlet weak var btnone: UIButton!
    @IBOutlet weak var btntwo: UIButton!
    @IBOutlet weak var btnthree: UIButton!
    @IBOutlet weak var btnfour: UIButton!
    @IBOutlet weak var btnfive: UIButton!
    @IBOutlet weak var btnsix: UIButton!
    
    @IBOutlet weak var btnIni: UIButton!
    
    @IBAction func btnReini(_ sender: UIButton) {
        scoreCounter = 0
        score.text = "\(scoreCounter)"
        gameOver.isHidden = true
        totalTime = 30
        timeFormatted(totalTime)
        startTimer()
        for i in 0..<6 {
            number = Int.random(in: -100 ..< 100)
            arrayDesordenado.append(number)
            arrayOrdenado.append(number)
        }
        
        cambiarBotones()
        arrayOrdenado.sort()
        
        mostrarBotones()
        
        
 
    }
    
    
    
    @IBAction func btnController(_ sender: UIButton) {
        if Int(sender.currentTitle!) == arrayOrdenado[0] {
            sender.isHidden = true
            scoreCounter = scoreCounter + 100
            score.text = "\(scoreCounter)"
            arrayOrdenado.removeFirst()
            
            if arrayOrdenado.count == 0 {
                endTimer()
                gameOver.text = "Felicidades sigue jugando"
                arrayDesordenado.removeAll()
                arrayOrdenado.removeAll()
                gameOver.isHidden = false
                btnIni.isHidden = false
                
            }
        } else {
            scoreCounter = scoreCounter - 20
            score.text = "\(scoreCounter)"
            
            if (scoreCounter < 0){
                endTimer()
                finalizarJuego()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        score.text = "\(scoreCounter)"
        startTimer()
        btnIni.isHidden = true
        gameOver.isHidden = true
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
        
        print(scoreCounter)
        if totalTime <= 0{
            finalizarJuego()
        }
        
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
    
    func desaparecerBotones() {
        btnone.isHidden = true
        btntwo.isHidden = true
        btnthree.isHidden = true
        btnfour.isHidden = true
        btnfive.isHidden = true
        btnsix.isHidden = true
        btnIni.isHidden = true
    }
    
    func mostrarBotones() {
        btnone.isHidden = false
        btntwo.isHidden = false
        btnthree.isHidden = false
        btnfour.isHidden = false
        btnfive.isHidden = false
        btnsix.isHidden = false
        btnIni.isHidden = true
    }
    
    func finalizarJuego() {
        endTimer()
        gameOver.text = "GAME OVER"
        gameOver.isHidden = false
        desaparecerBotones()
        btnIni.isHidden = false
        arrayOrdenado.removeAll()
        arrayDesordenado.removeAll()
    }

}

