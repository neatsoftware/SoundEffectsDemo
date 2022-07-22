//
//  ContentView.swift
//  SoundEffectsDemo
//
//  Created by Garth on 7/22/22.
//

import SwiftUI

struct ContentView: View {
    @State var soundEffect: SoundEffect?

    var body: some View {
        VStack {
            Text("Sound Effect Picker").font(.title)
            SoundEffectPicker(selection: $soundEffect)
        }.padding().frame(width: 300, height: 200, alignment: .center)
    }
}
