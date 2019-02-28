//
//  ViewController.swift
//  FirstiOSProject
//
//  Created by admin on 28/02/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        plus.setTitle("+", for: .normal)
    }

    @IBOutlet weak var go: UIButton!
    @IBOutlet weak var compteur: UILabel!
    
    @IBOutlet weak var plus: UIButton!
    
    @IBAction func decrement(_ sender: Any) {
        
        compteur.text = "\((Int(compteur.text ?? "0") ?? 0)-1)"
    }
    @IBOutlet weak var moins: UIButton!
    @IBAction func increment(_ sender: Any) {
        let a = compteur.text //string ou null
        let b = Int(a!)//int?
        let c = (b ?? 0)+1
        let d = "\(c)"
        compteur.text = d
        
        //compteur.text = "\((Int(compteur.text ?? "0") ?? 0)+1)"
    }
    @IBAction func onTappe(_ sender: Any) {
        if let next = self.storyboard?.instantiateViewController(withIdentifier: "deuxieme") as? DeuxiemeViewController{
                next.a = Int(compteur.text ?? "0") ?? 0
            
                self.navigationController?.pushViewController(next, animated: true)
        }
    }
}

class DeuxiemeViewController: UIViewController {

    @IBOutlet weak var aAfficher: UILabel!
    var a: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        aAfficher.text = "\(a)"
        
    }
    
    @IBAction func vaChercher(_ sender: Any) {
        let session = URLSession.shared
        
        let url = URL(string: "http://www.perdu.com")!
        let task = session.dataTask(with: url){ data, response, error in
            guard let d = data else { return }
            guard let html = String(data: d, encoding: .utf8) else{return}
            if let start = html.range(of: "<title>"), let end = html.range(of: "</title"){
                let substring = html[start.upperBound..<end.lowerBound]
                DispatchQueue.main.async {
                    self.aAfficher.text = String(substring)
                }
            }else{
                DispatchQueue.main.async {
                    self.aAfficher.text = "error!"
                }
            }
        }
    }
}
