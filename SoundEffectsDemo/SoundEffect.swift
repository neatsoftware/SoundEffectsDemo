//
//  SoundEffect.swift
//  SoundEffectsDemo
//
//  Created by Garth on 7/22/22.
//

import AudioToolbox

private func getSystemSoundFileEnumerator() -> FileManager.DirectoryEnumerator? {
    guard let libraryDirectory = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .systemDomainMask, true).first,
          let soundsDirectory = NSURL(string: libraryDirectory)?.appendingPathComponent("Sounds"),
          let soundFileEnumerator = FileManager.default.enumerator(at: soundsDirectory, includingPropertiesForKeys: nil) else { return nil }
    return soundFileEnumerator
}

struct SoundEffect: Hashable {
    let id: SystemSoundID
    let name: String

    func play() {
        AudioServicesPlaySystemSoundWithCompletion(id, nil)
    }
}

extension SoundEffect {
    static let systemSoundEffects: [SoundEffect] = {
        guard let systemSoundFiles = getSystemSoundFileEnumerator() else { return [] }
        return systemSoundFiles.compactMap { item in
            guard let url = item as? URL, let name = url.deletingPathExtension().pathComponents.last else { return nil }
            var soundId: SystemSoundID = 0
            AudioServicesCreateSystemSoundID(url as CFURL, &soundId)
            return soundId > 0 ? SoundEffect(id: soundId, name: name) : nil
        }.sorted(by: { $0.name.compare($1.name) == .orderedAscending })
    }()
}
