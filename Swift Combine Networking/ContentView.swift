//
//  ContentView.swift
//  Swift Combine Networking
//
//  Created by Thibault Klein on 7/2/19.
//  Copyright © 2019 Thibault Klein. All rights reserved.
//

import SwiftUI

struct ContentView : View {
    @EnvironmentObject var viewModel: SearchUserRepository

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.users) { user in
                    Text(user.login)
                }
            }
            .navigationBarTitle(Text("Github Users"))
        }
        .onAppear {
            self.viewModel.search(name: "Thibault")
        }
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
