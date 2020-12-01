//
//  InicioViewController.swift
//  TableView9-10
//
//  Created by Mac16 on 27/10/20.
//  Copyright © 2020 oscar. All rights reserved.
//

import UIKit

class InicioViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var recibirAlumno : String = ""
    var promedioSeleccionado = 85.0
    
    @IBOutlet weak var promedioLabel: UILabel!
    
    @IBOutlet weak var imagenPerfil: UIImageView!
    @IBOutlet weak var nombreAlumnoLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        nombreAlumnoLabel.text = recibirAlumno
    }
    

   
    @IBAction func cambiarPromedio(_ sender: UISlider) {
        print(sender.value)
        let promedio = String(format: "%.2f", sender.value)
        promedioSeleccionado = (Double(sender.value))
        promedioLabel.text = "\(promedio) Pts"
    }
   
    @IBAction func elegirFoto(_ sender: UIButton) {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        
        present(vc, animated: true)
    }
 
    
    //MARK:-Metodos de los delegados para el pickerController
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print(info)
        let imagen = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage
        imagenPerfil.image = imagen

        picker.dismiss(animated: true, completion: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "enviaPromedio" {
            //crea un objeto de tipo ResultadoViewController para acceder a sus valores
            let destino = segue.destination as! ResultadoViewController
            
            //cambia el atributo recibirUsuario con el valor del textField
            
            destino.recibirPromedio = Double(promedioSeleccionado) 
        }
        
    }
}
