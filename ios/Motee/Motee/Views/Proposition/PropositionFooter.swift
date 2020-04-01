//
//  PublicationFooter.swift
//  Motee
//
//  Created by Rayan Bahroun on 06/03/2020.
//  Copyright © 2020 groupe3. All rights reserved.
//

import SwiftUI

struct PropositionFooter : View {
    @EnvironmentObject var fk : FilterKit
    @Binding var proposition : Proposition
    @State var isNotHide :Bool = false
    @State var comment = ""
    @Binding var editing : Bool
    @Binding var editProposition : String
    @Binding var editAnonymous : Bool
    var body: some View {
        VStack{
            VStack{
                HStack {
                    PropositionLiked(proposition: $proposition)
                    Spacer()
                    if(fk.currentUser != nil && !editing){
                        Button(action:{
                            self.isNotHide.toggle()
                        }){
                            HStack{
                                Text("Contribuer")
                                Image(systemName: "message.fill")
                            }
                            .padding(7)
                            .foregroundColor(.white)
                            .background(LinearGradient(gradient: Gradient(colors: [.yellow, .pink]), startPoint: .leading, endPoint: .trailing)).cornerRadius(20)
                        }
                    }else if self.editing{
                        Button(action: {
                            if PropositionModel.updateProp(idProp: self.proposition.idPublication, contentProp: self.editProposition, isAnonymous: self.proposition.anonymous, idUser: self.fk.currentUser!.idUser, token: self.fk.token) {
                                print("Proposition updated")
                            }
                            self.editing.toggle()
                        }){
                            HStack{
                                Text("Editer")
                                Image(systemName: "message.fill")
                            }.padding(7)
                                .foregroundColor(.green)
                                .background(Color.white).cornerRadius(20)
                        }
                    }
                    else{
                        HStack{
                            Text("Connexion requise")
                            Image(systemName: "message.fill")
                        }.padding(7)
                            .foregroundColor(.white)
                            .background(Color.gray).cornerRadius(20)
                    }
                    Spacer()
                    
                    if (self.fk.currentUser?.idUser == proposition.owner){
                        Button(action: {
                            self.editing.toggle()
                            self.editProposition = self.proposition.contentPub
                            self.editAnonymous = self.proposition.anonymous
                        }){
                            Image(systemName: "square.and.pencil").foregroundColor(Color.gray).padding()
                        }
                        Button( action :  {
                            if PropositionModel.deleteProposition(idProp: self.proposition.idPublication, token: self.fk.token){
                                self.fk.currentPage = self.fk.currentPage
                                print("Proposition supprimé : \(self.proposition.contentPub)")
                            }
                        }){
                            Image(systemName: "trash.fill").foregroundColor(Color.red).padding()
                        }
                    }else{
                        ReportProposition(proposition: $proposition)
                    }
                }.padding()
            }
            if isNotHide {
                HStack{
                    TextField("Commentaire...", text: $comment).cornerRadius(20)
                    Button(action:{
                        if AnswerModel.addAnswer(contentPub: self.comment, isAnonymous: false, tagsAns: PropositionModel.getAllTags(proposition: self.proposition), idProposition: self.proposition.id, token: self.fk.token){
                            print("Answer added")
                        }
                        self.comment = ""
                    }){
                        Image(systemName: "arrowtriangle.right.circle.fill").padding(5).foregroundColor(Color.pink)
                    }
                }.padding()
            }
        }.padding()
    }
}

struct PropositionFooter_Previews: PreviewProvider {
    @State static var proposition = PropositionModel.getAll()[2]
    @State static var editing = false
    @State static var editProposition = ""
    @State static var editAnonymous = false
    static var previews: some View {
        PropositionFooter(proposition: $proposition, editing: $editing, editProposition : $editProposition, editAnonymous: $editAnonymous).environmentObject(FilterKit())
    }
}
