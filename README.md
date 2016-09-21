# JsonObjectConvertible

This is yet another Swifty JSON library.

## Why not SwiftyJSON

When we already have `JSONSerialization` in Foundation, why don't we simply use it so that we don't have to worry about bugs and compatibility issues with new version of Swift?  This simple hack only adds a couple of short hands to `Any?`, and that's it.

## Usage
    let json = try? JSONSerialization.jsonObject(with: data, options: [])
    if let name = json["data"][0]["from"]["name"] as? String {
      ...
    }

For more sample, please check out [JsonObjectConvertibleTests.swift](https://raw.githubusercontent.com/nh7a/JsonObjectConvertible/master/JsonObjectConvertibleTests/JsonObjectConvertibleTests.swift).

## Installation

Copy [JsonObjectConvertible.swift](https://raw.githubusercontent.com/nh7a/JsonObjectConvertible/master/JsonObjectConvertible/JsonObjectConvertible.swift) into your project.

## Author

Naoki Hiroshima, n@h7a.org
