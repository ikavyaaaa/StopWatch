//
//  TimerVC.swift
//  StopWatch
//
//  Created by Kavya on 05/09/22.
//

import UIKit

class TimerVC: UIViewController {

    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startOrpauseBtn: UIButton!
    @IBOutlet weak var stopOrResetBtn: UIButton!
    
    var timer:Timer = Timer()
    var count:Int = 0
    var timerCounting:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startOrpauseBtn.setTitle("START", for: .normal)
        stopOrResetBtn.isHidden = true
       
    }
    
    @IBAction func startOrpauseAction(_ sender: UIButton) {
        if(timerCounting) {
            timerCounting = false
            timer.invalidate()
            if sender.titleLabel?.text == "Pause" {
                startOrpauseBtn.setTitle("Resume", for: .normal)
            } else {
                startOrpauseBtn.setTitle("Start", for: .normal)
            }
        } else  {
            timerCounting = true
            startOrpauseBtn.setTitle("Pause", for: .normal)
            stopOrResetBtn.isHidden = false
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
        }
        
    }
    

    @IBAction func stopOrResetAction(_ sender: Any) {
        self.count = 0
        self.timer.invalidate()
        self.timerLabel.text = self.makeTimeString(hours: 0, minutes: 0, seconds: 0)
        startOrpauseBtn.setTitle("Start", for: .normal)
        timerLabel.text = "00:00:00"
    }
    
    @objc func timerCounter() -> Void {
        count = count + 1
        let time = secondsToHoursMinutesSeconds(seconds: count)
        let timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
        timerLabel.text = timeString
    }
    
    func secondsToHoursMinutesSeconds(seconds: Int) -> (Int, Int, Int) {
        return ((seconds / 3600), ((seconds % 3600) / 60),((seconds % 3600) % 60))
    }
    
    func makeTimeString(hours: Int, minutes: Int, seconds : Int) -> String {
        var timeString = ""
        timeString += String(format: "%02d", hours)
        timeString += " : "
        timeString += String(format: "%02d", minutes)
        timeString += " : "
        timeString += String(format: "%02d", seconds)
        return timeString
    }
}
