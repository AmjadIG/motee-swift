//
//  AffichageAnswer.swift
//  Motee
//
//  Created by Amjad Menouer on 02/03/2020.
//  Copyright © 2020 groupe3. All rights reserved.
//

import Combine
import SwiftUI
import UserNotifications

struct AnswerView: View {
    
    @Binding var answer : Answer
    let dateFormatter = DateFormatter()
    var currentUser = (UIApplication.shared.delegate as! AppDelegate).currentUser
    
    /*init(answer : Answer){
        self.answer = answer
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
    }*/
        
    var body: some View {
        VStack{
            VStack{
                HStack{
                    Text(answer.owner.pseudo).bold().foregroundColor(.white)
                    Spacer()
                    Text(self.dateFormatter.string(from: answer.datePublication)).bold().foregroundColor(.white)
                }.padding()
                    .padding(.horizontal)
            Spacer()
                Text(answer.contentPub).foregroundColor(.white)
                    .padding(.horizontal)
            Spacer()
                
                if (currentUser != nil){
                    AnswerFooter(answer: answer)
                    Spacer()
                }
                
                }.frame(maxWidth: 380, maxHeight : 150 , alignment: .leading).edgesIgnoringSafeArea(.all)
                .background(Color.black)
            .cornerRadius(20).shadow(radius: 20)
            .padding()
        }
    }
}
/*
struct AnswerView_Previews: PreviewProvider {
    
    static var previews: some View {
        AnswerView(answer: <#Answer#>)
    }
}*/
