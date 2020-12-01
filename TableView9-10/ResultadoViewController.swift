//
//  ResultadoViewController.swift
//  TableView9-10
//
//  Created by Mac16 on 03/11/20.
//  Copyright © 2020 oscar. All rights reserved.
//

import UIKit

class ResultadoViewController: UIViewController {

    var recibirPromedio : Double = 0.0
    @IBOutlet var fondo: UIView!
    @IBOutlet weak var resultadoLabel: UILabel!
    @IBOutlet weak var imagenResultado: UIImageView!
    @IBOutlet weak var promedio: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        promedio.text = String(format: "%.2f",recibirPromedio)
        
        if recibirPromedio < 70 {
            fondo.backgroundColor = UIColor.red
            resultadoLabel.text = "REPROBADO"
            resultadoLabel.textColor = UIColor.white
            imagenResultado.image = #imageLiteral(resourceName: "fracaso")
        } else {
            fondo.backgroundColor = UIColor.green
            resultadoLabel.text = "APROBADO"
            resultadoLabel.textColor = UIColor.white
            imagenResultado.image = #imageLiteral(resourceName: "Como-obtener-el-exito-en-la-vida")
            
        }
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
