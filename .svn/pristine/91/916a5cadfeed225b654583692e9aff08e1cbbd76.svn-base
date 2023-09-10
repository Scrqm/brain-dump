import SwiftUI

/**
 Get a `[Date]` array for all instances of a `hashtag`.
 */
@inline(__always) func getDatesForHashtag(hashtag: String, brainDumps: [BrainDumpStruct]) -> [Date] {
    var dates: [Date] = []
    for brainDump in brainDumps {
        if containsHashtag(string: brainDump.notes, hashtag: hashtag) || containsHashtag(string: brainDump.event, hashtag: hashtag) {
        //if brainDump.notes.lowercased().contains(hashtag) || brainDump.event.lowercased().contains(hashtag) {
            dates.append(brainDump.timestamp)
        }
    }
    return dates
}

/**
 Get a `[Date]` array for all instances of a `type` and type `item`.
 */
@inline(__always) func getDatesForType(type: InfluenceTypeEnum, item: Int, data: DataStoreClass) -> [Date] {
    var dates: [Date] = []
    let brainDumps = data.brainDumps

    if type == .event {
        let event = getEventsList(brainDumps: brainDumps)[item]
        dates.append(event.1)
        return dates
    }

    if type == .hashtag {
        dates = getDatesForHashtag(hashtag: data.hashtagList[item], brainDumps: brainDumps)
        return dates
    }
    
    for brainDump in brainDumps {
        switch type {
        case .activity:
            if brainDump.activities[item] {
                dates.append(brainDump.timestamp)
            }
        case .social:
            if brainDump.social[item] {
                dates.append(brainDump.timestamp)
            }
        case .symptom:
            if brainDump.symptoms[item] {
                dates.append(brainDump.timestamp)
            }
        default:
            break
        }
    }

    return dates
}

/**
 Get a `[Date]` array for all instances of a `type` and type `item`.
 */
@inline(__always) func getDatesForType(type: InfluenceTypeEnum, activity: Int, social: Int, symptom: Int, event: Int, hashtag: Int, data: DataStoreClass) -> [Date] {
    var dates: [Date] = []
    var item = 0
    let brainDumps = data.brainDumps
    
    switch type {
    case .activity:
        item = activity
    case .symptom:
        item = symptom
    case .social:
        item = social
    case .event:
        item = event
    case .hashtag:
        item = hashtag
    }

    if type == .event {
        let event = getEventsList(brainDumps: brainDumps)[item]
        dates.append(event.1)
        return dates
    }

    if type == .hashtag {
        dates = getDatesForHashtag(hashtag: data.hashtagList[item], brainDumps: brainDumps)
        return dates
    }
    
    for brainDump in brainDumps {
        switch type {
        case .activity:
            if brainDump.activities[item] {
                dates.append(brainDump.timestamp)
            }
        case .social:
            if brainDump.social[item] {
                dates.append(brainDump.timestamp)
            }
        case .symptom:
            if brainDump.symptoms[item] {
                dates.append(brainDump.timestamp)
            }
        default:
            break
        }
    }

    return dates
}
