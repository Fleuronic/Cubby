<p align="center">
    <img src="Logo.png" width="400" max-width="90%" alt="Cubby" />
</p>

<div align="center">
    
[![SwiftPM](https://img.shields.io/badge/SPM-macOS%20%7C%20iOS%20%7C%20watchOS%20%7C%20tvOS-success?logo=swift&color=orange)](https://swift.org)
![Swift Version](https://img.shields.io/badge/swift-5.5-success?color=informational&logo=swift)

![Version](https://img.shields.io/badge/version-1.0.0-success?color=yellow)
![License](https://img.shields.io/github/license/Fleuronic/Cubby?color=blueviolet)
![Issues](https://img.shields.io/github/issues/Fleuronic/Cubby?logo=github)
![Downloads](https://img.shields.io/github/downloads/Fleuronic/Cubby/total)

[![Bitrise](https://img.shields.io/bitrise/176b03ebf96e978e?label=macOS&logo=bitrise&token=CMi7PpmIVLHq8_FbpsGVlA)](https://app.bitrise.io/app/176b03ebf96e978e)
[![Codecov](https://img.shields.io/codecov/c/github/Fleuronic/Cubby?logo=codecov)](https://codecov.io/gh/Fleuronic/Cubby)
[![Codacy](https://img.shields.io/codacy/grade/ca1a60cc3c404d5d939a3dc2111cc12f?logo=codacy)](https://app.codacy.com/gh/Fleuronic/Cubby)

[![Tweet](https://img.shields.io/twitter/url?url=https%3A%2F%2Fshields.io)](https://twitter.com/intent/tweet?text=Check%20out%20github.com/Fleuronic/Cubby%20from%20@Fleuronic%2C%20a%20Swift%20wrapper%20around%20the%20@JSONBin%20API.)
[![Follow](https://img.shields.io/twitter/follow/Fleuronic?label=@Fleuronic)](https://twitter.com/intent/follow?screen_name=Fleuronic)
[![Github](https://img.shields.io/github/followers/jordanekay?label=@jordanekay&style=social)](https://github.com/jordanekay)
    
</div>

**Cubby** is a Swift wrapper around the [JSONBin](https://jsonbin.io) API that provides a simple interface for storing, categorizing, and fetching Swift structs in the cloud.

## API Support

Cubby provides full support for both v2 and v3 of the JSONBin API. 

### Version 2.0

- [X] Bin
    - [X] Create
    - [X] Read
    - [X] Update
    - [X] Delete
- [X] Collection
    - [X] Create
    - [X] Read
- [X] Experimental
    - [X] Request Count
- [X] Geolocation
    - [X] Lookup
- [X] Schema Doc
    - [X] Create
    - [X] Read
    - [X] Update

### Version 3.0

- [X] Bin
    - [X] Create
    - [X] Read
    - [X] Version Count
    - [X] Update
    - [X] Update Name
    - [X] Update Privacy
    - [X] Delete
    - [X] Delete Versions
- [X] Collection
    - [X] Create
    - [X] Fetch in Collection
    - [X] Fetch Uncategorized
    - [X] Update Name
    - [X] Add Schema Doc
    - [X] Remove Schema Doc
- [X] Other
    - [X] List Usage Logs
    - [X] Download Usage Log
- [X] Schema Doc
    - [X] Create
    - [X] Read
    - [X] Update
    - [X] Update Name

## Usage

Cubby uses specification protocols to indicate which endpoints each API version supports. Use an appropriate instantiation of `JSONBin.V2.API` or `JSONBin.V3.API` depending on the endpoint you want to call. (Note that version 2 of the JSONBin API is planned for deprecation on January 1, 2022.)

### Bin

Create, read, update, or delete bins that represent Swift structs. Each bin represents a single Swift struct and has a privacy setting, an optional name, and an optional collection it belongs to.

```swift
public protocol JSONBinV2APIBinSpec: JSONBinV2APISpec {
    func createBin<Resource: Encodable>(named name: String?, with resource: Resource, inCollectionWith id: Collection.ID?, private: Bool?) -> Request<Creation<Resource>>
    func readBin<Resource: Decodable>(with id: ID, of type: Resource.Type, at version: Version?) -> Request<Resource>
    func updateBin<Resource: Encodable>(with id: ID, using resource: Resource, versioning: Bool?) -> Request<Update<Resource>>
    func deleteBin(with id: ID) -> Request<Deletion>
}

public protocol JSONBinV3APIBinSpec: JSONBinV3APISpec {
    func createBin<Resource: Encodable>(named name: String?, with resource: Resource, inCollectionWith id: Collection.ID?, private: Bool?) -> Request<Creation<Resource>>
    func readBin<Resource: Decodable>(with id: ID, of type: Resource.Type, at version: Version?, includingMetadata: Bool?, usingDotPath dotPath: String?) -> Request<Read<Resource>>
    func versionCount(ofBinWith id: ID) -> Request<VersionCount>
    func updateBin<Resource: Encodable>(with id: ID, using resource: Resource, versioning: Bool?) -> Request<Update<Resource>>
    func updateName(ofBinWith id: ID, toName name: String) -> Request<NameUpdate>
    func updatePrivacy(ofBinWith id: ID, toPrivate private: Bool) -> Request<PrivacyUpdate>
    func deleteBin(with id: ID) -> Request<Deletion>
    func deleteVersions(ofBinWith id: ID, preservingLatest: Bool?) -> Request<Deletion>
}
```

<details>
<summary>Creation Example</summary>

```swift
var apple = Company(name: "Apple Computer", remoteWorkPolicy: .hybrid)

let request = api.createBin(named: "Apple", with: company)
let creation = try await request.returnedResource
let id = creation.metadata.id

print(creation.resource) // Company(name: "Apple Computer", remoteWorkPolicy: .hybrid)
```

</details>

<details>
<summary>Read Example</summary>

```swift
let request = api.readBin(with: id, of type: Company.self, at: .number(1), includingMetadata: false)
let company = try await request.returnedResource

print(company) // Company(name: "Apple Computer", remoteWorkPolicy: .hybrid)
```

</details>

<details>
<summary>Update Name Example</summary>

```swift
let request = api.updateName(ofBinWith: id, toName: "Apple")
let update = try await request.returnedResource

print(update.resource) // Company(name: "Apple", remoteWorkPolicy: .hybrid)
```

</details>

<details>
<summary>Update Example</summary>

```swift
apple.remoteWorkPolicy = .disallowed

let request = api.updateBin(with: id, using: apple)
let update = try await request.returnedResource

print(update.resource) // Company(name: "Apple", remoteWorkPolicy: .disallowed)
```

</details>

<details>
<summary>Version Count Example</summary>

```swift
let request = api.versionCount(ofBinWith: id)
let versionCount = try await request.returnedResource.metadata.versionCount

print(versionCount) // 1
```

</details>

<details>
<summary>Deletion Versions Example</summary>

```swift
let request = api.deleteVersions(ofBinWithID: id, preservingLatest: true)
let deletion = try await request.returnedResource

print(deletion.message) // "Versions for the Bin are deleted successfully and latest version preserved on the base record."
```

</details>

<details>
<summary>Deletion Example</summary>

```swift
let request = api.deleteBin(with: id)
let deletion = try await request.returnedResource

print(deletion.message) // "Bin deleted successfully"
```

</details>

### Collection

Create, fetch bins from, or update collections that contain your Swift structs. To ensure a collection only contains structs of the same type, attach a schema document (see below) representing that type to the collection. Once attached, attempting to create a bin in a collection of a different type (i.e., one that cannot be validated by the schema) will fail.

```swift
public protocol JSONBinV2APICollectionSpec: JSONBinV2APISpec {
    func createCollection(named name: String) -> Request<Creation>
    func updateCollection(with id: ID, using action: Action) -> Request<Update>
}

public protocol JSONBinV3APICollectionSpec: JSONBinV3APISpec {
    func createCollection(named name: String) -> Request<Creation>
    func fetchBins(inCollectionWith id: ID, sortedBy sortOrder: Fetch.SortOrder?) -> Request<[Fetch.Result]>
    func fetchUncategorizedBins(sortedBy sortOrder: Fetch.SortOrder?) -> Request<[Fetch.Result]>
    func updateName(ofCollectionWith id: ID, toName name: String) -> Request<NameUpdate>
    func addSchemaDoc(with id: SchemaDoc.ID, toCollectionWith collectionID: ID) -> Request<Addition>
    func removeSchemaDoc(fromCollectionWith id: ID) -> Request<Removal>
}
```

<details>
<summary>Creation Example</summary>

```swift
let request = api.createCollection(named: "WFH Companies")
let creation = try await request.returnedResource
let id = creation.metadata.id

print(creation.metadata.name) // "Remote Companies"
```

</details>

<details>
<summary>Fetch Example</summary>

```swift
let request = api.fetchBins(inCollectionWith: id)
let companies = try await request.returnedResource

print(companies) // [Company(name: "Twitter", remoteWorkPolicy: .allowed), Company(name: "GitHub", remoteWorkPolicy: .distributed)]
```

</details>

<details>
<summary>Update Name Example</summary>

```swift
let request = api.updateName(ofCollectionWith: id, toName: "Remote Companies")
let update = try await request.returnedResource

print(update.metadata.name) // "Remote Companies"
```

</details>

<details>
<summary>Add Schema Doc Example</summary>

```swift
let request = api.addSchemaDoc(with: schemaDocID, toCollectionWith: id)
request() // Adds a schema doc to the collection
```

</details>

<details>
<summary>Remove Schema Doc Example</summary>

```swift
let request = api.removeSchemaDoc(fromCollectionWith: id)
request() // Removes the schema doc from the collection
```

</details>

### Schema Doc

Create, read, or update schema documents that can be attached to collections.

```swift
public protocol JSONBinV2APISchemaDocSpec: JSONBinV2APISpec {
    func createSchemaDoc<Resource>(for type: Resource.Type, named name: String) -> Request<Response<Resource>>
    func readSchemaDoc<Resource>(with id: ID, for type: Resource.Type) -> Request<Schema<Resource>>
    func updateSchemaDoc<Resource>(with id: ID, toSchemaFor type: Resource.Type) -> Request<Response<Resource>>
}

public protocol JSONBinV3APISchemaDocSpec: JSONBinV3APISpec {
    func createSchemaDoc<Resource>(for type: Resource.Type, named name: String) -> Request<Response<Resource>>
    func readSchemaDoc<Resource>(with id: ID, for type: Resource.Type) -> Request<Response<Resource>>
    func updateSchemaDoc<Resource>(with id: ID, toSchemaFor type: Resource.Type) -> Request<Update<Resource>>
    func updateName(ofSchemaDocWith id: ID, toName name: String) -> Request<NameUpdate>
}
```

<details>
<summary>Creation Example</summary>

```swift
extension Company: SchemaAdhering {
    static var description: String? {
        "A company has both a name and a remote work policy."
    }

    static var properties: [CodingKeys: SchemaType] {
        [
            .name: .string,
            .remoteWorkPolicy: .string
        ]
    }
}

let request = api.createSchemaDoc(for: Company.self, named: "Company Schema Doc")
let creation = try await request.returnedResource
let id = creation.metadata.id

print(creation.metadata.name) // "Company Schema Doc"
print(creation.schema.title) // "Company"
print(creation.schema.description) // "A company has both a name and a remote work policy."
print(creation.schema.properties) // [.name: .string, .remoteWorkPolicy: .string]
```

</details>

<details>
<summary>Read Example</summary>

```swift
let request = api.readSchemaDoc(with: id)
let read = try await request.returnedResource

print(read.metadata.name) // "Company Schema Doc"
print(read.schema.title) // "Company"
print(read.schema.description) // "A company has both a name and a remote work policy."
print(read.schema.properties) // [.name: .string, .remoteWorkPolicy: .string]
```

</details>

<details>
<summary>Update Example</summary>

```swift
extension Company: SchemaAdhering {
    static var description: String? {
        "A company has both a name, a remote work policy, and a number of employees."
    }

    static var properties: [CodingKeys: SchemaType] {
        [
            .name: .string,
            .remoteWorkPolicy: .string,
            .employeeCount: .integer
        ]
    }
}

let request = api.updateSchemaDoc(with: id, toSchemaFor: Company.self)
let update = request.returnedResource

print(update.metadata.name) // "Company Schema Doc"
print(update.schema.title) // "Company"
print(update.schema.description) // "A company has, a name, a remote work policy, and a number of employees."
print(update.schema.properties) // [.name: .string, .remoteWorkPolicy: .string, .employeeCount: .integer]
```

</details>

<details>
<summary>Update Name Example</summary>

```swift
let request = api.updateName(ofSchemaDocWith: id, toName: "Company Schema Document")
let update = try await request.returnedResource

print(update.metadata.name) // "Company Schema Document"
```

</details>

### Experimental

Get the number of requests remaining for this account.

```swift
public protocol JSONBinV2APIExperimentalSpec: JSONBinV2APISpec {
    func requestCount() -> Request<Count>
}
```

<details>
<summary>Request Count Example</summary>

```swift
let request = api.requestCount()
let count = try await request.returnedResource

print(count.value) // 1000000
```

</details>

### GeoIP

Look up geolocation data for an IP address.

```swift
public protocol JSONBinV2APIGeoIPSpec: JSONBinV2APISpec {
    func lookUpGeolocation(for ipAddress: IPAddress) -> Request<Lookup>
}
```

<details>
<summary>Look Up Geolocation Example</summary>

```swift
let ipAddress = IPAddress("141.158.45.225")
let request = api.lookUpGeolocation(for: ipAddress)
let lookupData = await request.returnedResource.data

print(lookupData.range) // 2375953408..<2375953919
print(lookupData.countryCode) // "US"
print(lookupData.regiounCode) // "PA"
print(lookupData.timeZone) // "America/New_York"
print(lookupData.city) // "Philadelphia"
print(lookupData.coordinates.latitude) // 39.934
print(lookupData.coordinates.longitude) // -75.16
print(lookupData.metroCode) // 504
print(lookupData.accuracyRadius) // 1
```

</details>

### Other

List the usage logs for this account, or download a specific usage log.

```swift
public protocol JSONBinV3APIOtherSpec: JSONBinV3APISpec {
    func listUsageLogs() -> Request<UsageLog.List>
    func downloadUsageLog(named name: String) -> Request<UsageLog>
}
```

<details>
<summary>List Usage Logs Example</summary>

```swift
let ipAddress = IPAddress("141.158.45.225")
let request = api.listUsageLogs
let list = await request.returnedResource

print(list.logNames) // ["12-31-2022", "01-01-2022", "01-02-2022"]
```

</details>

<details>
<summary>Download Usage Log Example</summary>

```swift
let ipAddress = IPAddress("141.158.45.225")
let request = api.downloadUsageLog(named: "01-01-2022")
let usageLog = await request.returnedResource

print(usageLog.compressed) // ZIP data of log contents
```

</details>

## Installation

Cubby is distributed using the [Swift Package Manager](https://swift.org/package-manager). To install it into a project, simply add it as a dependency within your `Package.swift` manifest:

```swift
let package = Package(
    ...
    dependencies: [
        .package(url: "https://github.com/Fleuronic/Cubby", from: "1.0.0")
    ],
    ...
)
```

Then import Cubby wherever you’d like to use it:

```swift
import Cubby
```

For more information on how to use the Swift Package Manager, check out [this article](https://www.swiftbysundell.com/articles/managing-dependencies-using-the-swift-package-manager), or [its official documentation](https://github.com/apple/swift-package-manager/tree/master/Documentation).
