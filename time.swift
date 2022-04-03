#!/usr/bin/env swift

import Foundation

class Time {
	
	init() {	}

	func run () {
//		let langId = Locale.current.collatorIdentifier
		
		let date = Date()
		
		let dateTimeFormatter = DateFormatter()
		let dateFormat = DateFormatter()

		dateTimeFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
		
		let datetime = dateTimeFormatter.string(from: date)
		
		dateFormat.dateFormat = "YYYY-MM-dd"
		
		let dateStr = dateFormat.string(from: date)

		let timezone = TimeZone.current.identifier
		
		
		let formatter = ISO8601DateFormatter()
		formatter.formatOptions.insert(.withFractionalSeconds)
		
		
//		if ["zh-Hans", "zh-Hant", "zh_CN", "zh_TW", "zh_HK"].contains(langId!) {
//			dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
//		} else if ["en_US"].contains(langId!) {
//			dateFormatter.dateFormat = "MM-dd-YYYY"
//		} else {
//			dateFormatter.dateFormat = "dd-MM-YYYY"
//		}
		
		let timeStamp = date.timeIntervalSince1970

		
		let alfredResult = AlfredResult(items: [
			AlfredItem(arg: datetime, title: datetime, subtitle: "本机时间，时间"),
			AlfredItem(arg: String(Int(timeStamp)), title: String(Int(timeStamp)), subtitle: "本机时间，时间戳（秒）"),
			AlfredItem(arg: String(timeStamp), title: String(timeStamp), subtitle: "本机时间，时间戳（毫秒）"),
			AlfredItem(arg: dateStr, title: dateStr, subtitle: "本机时间，时间戳（毫秒）"),
			AlfredItem(arg: timezone, title: timezone, subtitle: "本机时区"),
			AlfredItem(arg: formatter.string(from: date), title: formatter.string(from: date), subtitle: "ISO8610 UTC时间"),
//			AlfredItem(arg: formatter, title: formatter, subtitle: "格林威治时间（GMT）/ 标准时间"),
			
		])
		
		prettyPrint(alfredResult)
		return
		
	}
	
	func prettyPrint<T: Encodable>(_ v: T) {
		let encoder = JSONEncoder()
		encoder.outputFormatting = .prettyPrinted
		guard let data = try? encoder.encode(v) else { return }
		print(String(data: data, encoding: .utf8)!)
	}

	
	struct AlfredResult: Codable {
		let items: [AlfredItem]
	}

	struct AlfredItem: Codable {
		var arg: String
		var title: String
		var subtitle: String
		var match: String?
		var mods: AlfredItemMod?
	}
	
	struct AlfredItemMod: Codable {
		var cmd: AlfredItemModItem
	}
	
	struct AlfredItemModItem: Codable {
		var valid: Bool
		var arg: String
		var subtitle: String
	}

}

struct Empty: Decodable { }
extension UnkeyedDecodingContainer {
	public mutating func skip() throws {
		_ = try decode(Empty.self)
	}
}

Time().run()
