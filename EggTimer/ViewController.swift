import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    let eggTimes = ["Soft":3, "Medium":5, "Hard":8]
    @IBOutlet weak var eggsTitle: UILabel!
    var player: AVAudioPlayer!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    
    var secondsPassed = 0
    var totalTime = 0
    var timer = Timer()
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        let hardness = sender.currentTitle!
        timer.invalidate()
        totalTime = eggTimes[hardness]!
        
        progressBar.progress = 0.0
        secondsPassed = 0;
        eggsTitle.text = hardness
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self,selector: #selector(updateTimer),userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer(){
        if secondsPassed <= totalTime{
            let percentageProgress = Float(secondsPassed)/Float(totalTime)
            secondsPassed += 1;
            print(Float(secondsPassed) / Float(totalTime))
            progressBar.progress = percentageProgress
        }else{
            timer.invalidate()
            eggsTitle.text = "eggs done!"
            playSound()
        }
    }
    func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
    
}
