//
//  ViewController.swift
//  TableView9-10
//
//  Created by Mac16 on 25/10/20.
//  Copyright © 2020 oscar. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    var alumnos = ["Oscar", "Fernando", "Ulises", "Martín"]
    var alumnoSeleccionado : String = ""
    let defaults = UserDefaults.standard //CREAR ARCHIVO DEFAULTS

    @IBOutlet weak var tabla: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // implementar delegados
        //tabla.dataSource = self
        //tabla.delegate = self
        
        //registrar la nueva celda personalizada
        tabla.register(UINib(nibName: "AlumnoCell", bundle: nil), forCellReuseIdentifier: "celda")
        
    
        //Extrae los datos del defaults
        if let alumnosGuardados = defaults.array(forKey: "AlumnosProgra") as? [String]{
            self.alumnos = alumnosGuardados
        }
    }
    
    //MARK: - METODOS DEL TABLE VIEW
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alumnos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //creamos objeto de tipo UITableViewCell
        //método convencional
        ////let ObjetoCelda = UITableViewCell(style: .default, reuseIdentifier: "celda")
       
        //metodo para celdas personalizadas
        let ObjetoCElda = tabla.dequeueReusableCell(withIdentifier: "celda") as! AlumnoCell
        
        //modificar el texto de nuestro objeto celda
        //método convencional
        ////ObjetoCelda.textLabel?.text = alumnos[indexPath.row]
        
        //metodo para celdas personalizadas
        ObjetoCElda.alumnoLabel.text = alumnos[indexPath.row]
        return ObjetoCElda
    }
    
    //ACCIÓN PARA ENVIAR DATOS AL SIGUIENTE VIEW CONTROLLER
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        alumnoSeleccionado = alumnos[indexPath.row]
        performSegue(withIdentifier: "enviarNombre", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "enviarNombre" {
            let destino = segue.destination as! InicioViewController
            destino.recibirAlumno = alumnoSeleccionado
            
        }
    }
    
    //FUNCION PARA ELIMINAR UN ELEMENTO DE LA TABLA
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //eliminar elemento de un array
            alumnos.remove(at: indexPath.row)
            self.guardarDefaults()
            //actualizar los datos de la tabla
            tabla.reloadData()
        }
    }
    
    //ACCIÓN PARA GUARDAR UN ALUMNOS
    @IBAction func AddAlumnoButton(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        //SE CREA OBJETO ALERTA
        let alert = UIAlertController(title: "Agregar nuevo alumno", message: "Ingresa el nombre", preferredStyle: .alert)
        //SE CREA UN BOTÒN DE ACCIÒN aceptar
        let accionAceptar = UIAlertAction(title: "Aceptar", style: .default){
            (_) in // ACCIÒN QUE REALIZARÀ EL CLOUSURE
            print("Usuario Agregado")
            //SE AGREGA EL ALUMNO AL ARREGLO DE ALUMNOS
            self.alumnos.append(textField.text ?? "Alumno generico")
            //SE GUARDA EL ARREGLO EN EL ARCHIVO DEFAULTS
            self.guardarDefaults()
            //ACTUALIZA LOS DATOS DE LA TABLA
            self.tabla.reloadData()
        }
        //SE CREA UN BOTÒN PARA CANCELAR LA ACCIÒN QUE NO HACE NADA
        let accionCancelar = UIAlertAction(title: "Cancelar", style: .default, handler: nil)
        
        alert.addAction(accionAceptar)
        alert.addAction(accionCancelar)
        
        //AGREAGAR TextField AL ALERT
        alert.addTextField{
            (alertTextField) in
            alertTextField.placeholder = "Nombre alumno"
            textField = alertTextField
            //LA VERDAD NO ENTIENDO BIEN LA SINTAXIS PERO BUENO
        }
        
        present(alert, animated: true, completion: nil)
    }
    
    func guardarDefaults(){
        self.defaults.set(self.alumnos, forKey: "AlumnosProgra")
    }
    
   
}

