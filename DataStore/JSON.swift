import SwiftUI
import UniformTypeIdentifiers

/**
 Struct for JSON file.
 */
struct JSONFile: FileDocument {
    static var readableContentTypes = [UTType.json]
    var text = ""

    init(string: String = "") {
        text = string
    }

    init(configuration: ReadConfiguration) throws {
        if let data = configuration.file.regularFileContents {
            text = String(decoding: data, as: UTF8.self)
        }
    }

    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let data = Data(text.utf8)
        return FileWrapper(regularFileWithContents: data)
    }
}

/**
 Encode `data` struct into a JSON `String`.
 */
func encodeJSONString(data: DataStoreClass) -> String {
    do {
        let jsonData = try JSONEncoder().encode(data.toStruct())
        let jsonString = String(data: jsonData, encoding: .utf8)!
        return jsonString
    } catch {
    }
    return ""
}

/**
 Encode `data` struct into a JSON `String`.
 */
func encodeJSONString(brainDumps: [BrainDumpStruct]) -> String {
    do {
        let jsonData = try JSONEncoder().encode(cleanBrainDumps(brainDumps: brainDumps))
        let jsonString = String(data: jsonData, encoding: .utf8)!
        return jsonString
    } catch {
    }
    return ""
}

/**
 Decode a JSON `url`  into a `DataStoreClass`.
 */
func decodeJSONString(url: URL) throws -> DataStoreStruct  {
    var data = DataStoreStruct()
    //do {
        _ = url.startAccessingSecurityScopedResource()
        let rawData = try Data(contentsOf: url)
        data = try JSONDecoder().decode(DataStoreStruct.self, from: rawData)
        url.stopAccessingSecurityScopedResource()
  //  } catch {
   // }
    return data
}

/**
 Decode a JSON `url`  into a `[BrainDump]` array.
 */
func decodeJSONString(url: URL) throws -> [BrainDumpStruct] {
    var data: [BrainDumpStruct] = []
  //  do {
        _ = url.startAccessingSecurityScopedResource()
        let rawData = try Data(contentsOf: url)
        data = try JSONDecoder().decode([BrainDumpStruct].self, from: rawData)
        url.stopAccessingSecurityScopedResource()
   // } catch {
   // }
    return data
}

/**
 Strip a `[BrainDumpStruct]` array of quotes and custom items.
 */
func cleanBrainDumps(brainDumps: [BrainDumpStruct]) -> [BrainDumpStruct] {
    var filtered: [BrainDumpStruct] = []
    
    for brainDump in brainDumps {
        if brainDump.snapType == .mood || brainDump.snapType == .note || brainDump.snapType == .event || brainDump.snapType == .media {
            filtered.append(brainDump)
        }
    }
    
    return filtered
}

/**
 Decode JSON `data` into a `DataStoreSturct`.
 */
//func decodeJSONStringDataStoreStruct(data: Data) -> DataStoreStruct {
//    var decodedData = DataStoreStruct()
//    do {
//        decodedData = try JSONDecoder().decode(DataStoreStruct.self, from: data)
//    } catch {
//    }
//    return decodedData
//}
