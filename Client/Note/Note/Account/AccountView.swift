//
//  AccountView.swift
//  Note
//
//  Created by 峰 on 2020/5/23.
//  Copyright © 2020 峰. All rights reserved.
//

import SwiftUI

struct AccountView: View {
    @State var showProfile = false
    var body: some View {
        ZStack {
            NavigationView {
                List {
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            
                            Text("恰饭")
                                .lineLimit(1)
                                .font(.system(size: 20))
                            
                            Text("为了恰饭").lineLimit(1)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        }
                        Spacer()
                        Text("¥15")
                    }
                }.navigationBarTitle("账本")
                    .navigationBarItems(
                        leading: Button(action: {
                            self.showProfile.toggle()
                        }) {
                            Image(systemName: "square.grid.2x2")
                                .renderingMode(.original)
                        },
                        trailing: EditButton()
                )
            }
            
            BlurView(style: .regular)
                .frame(width: showProfile ? UIScreen.main.bounds.width : 0, height: showProfile ? UIScreen.main.bounds.height : 0)
                .onTapGesture {
                    self.showProfile.toggle()
            }
            
            MenuView()
                .offset(x: 0, y: showProfile ? 0 : UIScreen.main.bounds.height)
                .animation(.spring())
        }
    }
}


struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
