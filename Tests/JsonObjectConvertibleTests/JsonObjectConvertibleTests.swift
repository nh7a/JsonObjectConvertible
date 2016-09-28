import XCTest
@testable import JsonObjectConvertible

class JsonObjectConvertibleTests: XCTestCase {
    func testArray() {
        let arr = "[null, true, false, 0, 1, 0.0, 0.1, \"foo\", [1,2,3,4,5], {\"key\": \"value\"}]"
        let data = arr.data(using: .utf8)!
        let json = try? JSONSerialization.jsonObject(with: data, options: [])
        
        XCTAssertNil(json[0])
        XCTAssertNil(json[100])
        XCTAssertTrue(json[1] as! Bool)
        XCTAssertFalse(json[2] as! Bool)
        XCTAssertEqual(json[3] as? Int, 0)
        XCTAssertEqual(json[4] as? Int, 1)
        XCTAssertEqual(json[5] as? Double, 0.0)
        XCTAssertEqual(json[6] as? Double, 0.1)
        XCTAssertEqual(json[7] as? String, "foo")
        XCTAssertEqual(json[8] as! [Int], [1,2,3,4,5])
        XCTAssertEqual(json[8][1] as? Int, 2)
        XCTAssertEqual(json[9] as! [String:String], ["key":"value"])
        XCTAssertEqual(json[9]["key"] as? String, "value")
    }
    
    func testDictionary() {
        let dict = "{\"nil\":null, \"true\":true, \"false\":false, \"0\":0, \"1\":1, \"double\":0.5, \"foo\":\"bar\", \"array\":[1,2,3,4,5], \"dict\":{\"key\": \"value\"}}"
        let data = dict.data(using: .utf8)!
        let json = try? JSONSerialization.jsonObject(with: data, options: [])
        
        XCTAssertNil(json["nil"])
        XCTAssertNil(json["bogus"])
        XCTAssertTrue(json["true"] as! Bool)
        XCTAssertFalse(json["false"] as! Bool)
        XCTAssertEqual(json["0"] as? Int, 0)
        XCTAssertEqual(json["1"] as? Int, 1)
        XCTAssertEqual(json["double"] as? Double, 0.5)
        XCTAssertEqual(json["foo"] as? String, "bar")
        XCTAssertEqual(json["array"] as! [Int], [1,2,3,4,5])
        XCTAssertEqual(json["array"][1] as? Int, 2)
        XCTAssertEqual(json["dict"] as! [String:String], ["key":"value"])
        XCTAssertEqual(json["dict"]["key"] as? String, "value")
    }

    func testSample() {
        guard let data = loadInputFile("sample.json").data(using: .utf8) else {
            fatalError("sample.json isn't a file")
        }
        let json = try? JSONSerialization.jsonObject(with: data, options: [])
        
        XCTAssertEqual(json["data"][0]["from"]["name"] as? String, "Tom Brady")
        XCTAssertEqual(json["data"][1]["from"]["name"] as? String, "Peyton Manning")
    }
    
    static var allTests : [(String, (JsonObjectConvertibleTests) -> () throws -> Void)] {
        return [
            ("testArray", testArray),
            ("testDictionary", testDictionary),
            ("testSample", testSample),
        ]
    }
}

private func loadInputFile(_ name: String) -> String {
    let arr = #file.components(separatedBy: "/")
    let path = (arr.prefix(upTo: arr.count-1) + [name]).joined(separator: "/")
    do {
        return try String(contentsOfFile: path)
    } catch {
        fatalError("File not found: \(name)")
    }
}
