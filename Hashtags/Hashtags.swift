import SwiftUI

/**
 Extract an array of all the hashtags from `string`.
 */
func getHashtags(string: String) -> [String] {
    let delimiters = [".", ":", ",", "?", "!", "\n"]
    var delimited = string
    for i in 0 ..< delimiters.count {
        delimited = delimited.replacingOccurrences(of: delimiters[i], with: " ")
    }
    let separated = delimited.components(separatedBy: " ")
    let hashtags = separated.filter { $0.hasPrefix("#") }
    let unique = Array(Set(hashtags))
    let sorted = unique.sorted {
        $0.lowercased() < $1.lowercased()
    }
    return sorted
}

/**
 Extract an array of all the hashtags from an array of `brainDumps`.
 */
func getHashtags(brainDumps: [BrainDumpStruct]) -> [String] {
    var bigString: String = ""

    for brainDump in brainDumps {
        bigString += " " + brainDump.notes.lowercased()
        bigString += " " + brainDump.event.lowercased()
    }

    let hashtags: [String] = getHashtags(string: bigString)
    return hashtags
}

/**
 Count the number of `brainDumps` that contain a given `hashtag`.
 */
func countHashtagOccurrences(hashtag: String, brainDumps: [BrainDumpStruct]) -> Int {
    var occurrences = 0

    for brainDump in brainDumps {
        if containsHashtag(string: brainDump.notes, hashtag: hashtag) || containsHashtag(string: brainDump.event, hashtag: hashtag) {
        //if brainDump.notes.contains(hashtag) || brainDump.event.contains(hashtag) {
            occurrences += 1
        }
    }

    return occurrences
}

/**
 Count the number of occurrences of an array of `hashtags` in an array of `brainDumps`.
 */
func countHashtagOccurrences(hashtags: [String], brainDumps: [BrainDumpStruct]) -> [Int] {
    var occurrences: [Int] = []

    for hashtag in hashtags {
        let thisCount = countHashtagOccurrences(hashtag: hashtag, brainDumps: brainDumps)
        occurrences.append(thisCount)
    }

    return occurrences
}
