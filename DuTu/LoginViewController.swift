//
//  LoginViewController.swift


import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    var model: LoginViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        model = LoginViewModel(client: self)
        
        loginButton.layer.cornerRadius = 10
        email.delegate = self
        password.delegate = self
    }
    
    @IBAction func loginAction(_ sender: Any) {
        if currentUser!.canSignIn(withEmail: email.text!, password: password.text!) {
            self.performSegue(withIdentifier: "loginToHome", sender: self)
        }
        else{
            let alertController = UIAlertController(title: "Error", message: "error?.localizedDescription", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
        return true
    }
    
}
