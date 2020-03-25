//
//  RegisterForm.swift
//  Motee
//
//  Created by Rayan Bahroun on 02/03/2020.
//  Copyright © 2020 groupe3. All rights reserved.
//

import SwiftUI

struct RegisterForm: View {
    @EnvironmentObject var fk : FilterKit
    @State var pseudo : String = ""
    @State var mdp : String = ""
    @State var mdp2 : String = ""
    @State var mail : String = ""
    var body: some View {
        
        NavigationView{
            VStack{
                Title(myTitle: "Inscription")
                FieldGenerator.plain(label: "Pseudo :",field: "Pseudo", text: $pseudo)
                if !isAvailablePseudo(pseudo: pseudo) && pseudo.count>0{
                    Text("Pseudo déjà utilisé").foregroundColor(Color.red)
                }
                FieldGenerator.plain(label: "Mail :",field: "mail", text: $mail)
                if !isAvailableMail(mail: mail) && mail.count>0{
                    Text("Mail déjà utilisé").foregroundColor(Color.red)
                }
                FieldGenerator.secure(label: "Mot de passe :",field: "Mot de passe", text: $mdp)
                if !isAvailablePassword(mdp: mdp) && mdp.count>0{
                    Text("minimum 6 caractères").foregroundColor(Color.red)
                }
                if !isSamePasword(mdp1: mdp, mdp2: mdp2) && mdp.count>0 && mdp2.count>0{
                    Text("les mot de passe ne sont pas identiques").foregroundColor(Color.red)
                }
                FieldGenerator.secure(label: "Confirmation mot de passe :",field: "Confirmation du mot de passe", text: $mdp2)
                if availableRegistration(pseudo: pseudo, mail: mail, mdp: mdp, mdp2: mdp2){
                    Button( action : {
                        UserModel.register(pseudo: self.pseudo, password: self.mdp, mail: self.mail)
                        self.fk.currentPage = "login"
            
                    }){
                    ButtonGenerator(myText: "S'inscrire", myColor: "green")
                    }
                }else{
                    ButtonGenerator(myText: "S'inscrire", myColor: "red")
                }
            }
        }
    }
    func availableRegistration(pseudo : String, mail : String, mdp : String, mdp2 : String ) -> Bool {
        return(isAvailablePseudo(pseudo : pseudo)
            && isSamePasword(mdp1: mdp, mdp2: mdp2) && isAvailablePassword(mdp : mdp)
            && isAvailableMail(mail : mail)
        )
    }
    
    func isAvailablePseudo(pseudo : String) -> Bool{
        if pseudo.count == 0 {
            return false
        }
        for (_,value) in UserModel.getAll() {
            if value.pseudo == pseudo {
                return false
            }
        }
        return true
    }
    func isAvailableMail(mail : String) -> Bool {
        if mail.count == 0 {
            return false
        }
        for (_,value) in UserModel.getAll() {
            if value.email == mail {
                return false
            }
        }
        return true
    }
    func isAvailablePassword(mdp : String)->Bool {
        return mdp.count>5
    }
    func isSamePasword(mdp1 : String ,mdp2 : String) -> Bool{
        return (mdp1 == mdp2)
    }

}
struct RegisterForm_Previews: PreviewProvider {
    static var previews: some View {
        RegisterForm()
    }
}
