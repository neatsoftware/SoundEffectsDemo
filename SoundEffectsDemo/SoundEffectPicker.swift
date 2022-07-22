//
//  SoundEffectPicker.swift
//  SoundEffectsDemo
//
//  Created by Garth on 7/22/22.
//

import SwiftUI

struct SoundEffectPicker: View {
    @Binding var selection: SoundEffect?

    var body: some View {
        Picker(selection: $selection, label: Text("Sound:")) {
            Text("None").tag(nil as SoundEffect?)
            ForEach(SoundEffect.systemSoundEffects, id: \.self) { sound in
                Text(sound.name).tag(sound as SoundEffect?)
            }
        }.onChange(of: selection) { sound in
            sound?.play()
        }
    }
}
