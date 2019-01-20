
import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var passwordConfirm: UITextField!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        signUpButton.layer.cornerRadius = 10
        email.delegate = self
        password.delegate = self
        passwordConfirm.delegate = self
        firstName.delegate = self
        lastName.delegate = self
    }
  
    @IBAction func signUpAction(_ sender: Any) {
        
        if password.text != passwordConfirm.text{
            let alertController = UIAlertController(title: "Password Incorrect", message: "Please re-type password", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else{
//            Auth.auth().createUser(withEmail: email.text!, password: password.text!){ (user, error) in
//                if error == nil
            if (currentUser?.canSignUp(withEmail: email.text! , password: password.text!, firstName: firstName.text!, lastName: lastName.text! ))!
                {
                   self.performSegue(withIdentifier: "signupToHome", sender: self)
                } else {
//                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let alertController = UIAlertController(title: "Error", message: "error?.localizedDescription", preferredStyle: .alert)
                
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)

                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                }
//            }
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
        return true
    }
}


