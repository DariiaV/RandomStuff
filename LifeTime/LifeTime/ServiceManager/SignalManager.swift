//
//  SignalManager.swift
//  LifeTime
//
//  Created by Дария Григорьева on 11.08.2023.
//

import Foundation
import AVKit

class SignalManager {
    
    static let shared = SignalManager()
    
    private var player: AVAudioPlayer?
    
    func playSound() {
        guard let path = Bundle.main.path(forResource: "alarm", ofType:"mp3") else {
            return
        }
        
        let url = URL(fileURLWithPath: path)
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
