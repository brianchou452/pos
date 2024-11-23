//
//  S3Service.swift
//  pos
//
//  Created by Brian Chou on 2024/11/16.
//

import Foundation

import AWSS3
import AWSSDKIdentity

import Smithy

import ClientRuntime

/// A class containing all the code that interacts with the AWS SDK for Swift.
public class S3Service {
    let configuration: S3Client.S3ClientConfiguration
    let client: S3Client
    
    enum ServiceError: Error {
        case getObjectBody(String)
        case readGetObjectBody(String)
        case missingContents(String)
    }
    
    /// Initialize and return a new ``S3Service`` object, which is used to drive the AWS calls
    /// used for the example.
    ///
    /// - Returns: A new ``S3Service`` object, ready to be called to
    ///            execute AWS operations.
    public init() async throws {
        let accessKey = S3Configuration.accessKey
        let secretKey = S3Configuration.secretKey
        do {
            let credentials = AWSCredentialIdentity(
                accessKey: accessKey,
                secret: secretKey
            )
            
            let identityResolver = try StaticAWSCredentialIdentityResolver(credentials)
            
            configuration = try await S3Client.S3ClientConfiguration(
                awsCredentialIdentityResolver: identityResolver,
                region: "us-east-1",
                forcePathStyle: true,
                endpoint: S3Configuration.endpoint
            )
            client = S3Client(config: configuration)
        }
        catch {
            print("ERROR: ", dump(error, name: "Initializing S3 client"))
            throw error
        }
    }
    
    /// Upload a file from local storage to the bucket.
    /// - Parameters:
    ///   - bucket: Name of the bucket to upload the file to.
    ///   - key: Name of the file to create.
    ///   - file: Path name of the file to upload.
    public func uploadFile(bucket: String, key: String, file: String) async throws {
        let fileUrl = URL(fileURLWithPath: file)
        do {
            let fileData = try Data(contentsOf: fileUrl)
            let dataStream = ByteStream.data(fileData)
            
            let input = PutObjectInput(
                body: dataStream,
                bucket: bucket,
                key: key
            )
            
            _ = try await client.putObject(input: input)
        }
        catch {
            print("ERROR: ", dump(error, name: "Putting an object."))
            throw error
        }
    }
    
    /// Create a file in the specified bucket with the given name. The new
    /// file's contents are uploaded from a `Data` object.
    ///
    /// - Parameters:
    ///   - bucket: Name of the bucket to create a file in.
    ///   - key: Name of the file to create.
    ///   - data: A `Data` object to write into the new file.
    public func createFile(bucket: String, key: String, withData data: Data) async throws {
        let dataStream = ByteStream.data(data)
        
        let input = PutObjectInput(
            body: dataStream,
            bucket: bucket,
            key: key
        )
        
        do {
            _ = try await client.putObject(input: input)
        }
        catch {
            print("ERROR: ", dump(error, name: "Putting an object."))
            throw error
        }
    }
    
    /// Download the named file to the given directory on the local device.
    ///
    /// - Parameters:
    ///   - bucket: Name of the bucket that contains the file to be copied.
    ///   - key: The name of the file to copy from the bucket.
    ///   - to: The path of the directory on the local device where you want to
    ///     download the file.
    public func downloadFile(bucket: String, key: String, to: String) async throws {
        let fileUrl = URL(fileURLWithPath: to).appendingPathComponent(key)
        
        let input = GetObjectInput(
            bucket: bucket,
            key: key
        )
        do {
            let output = try await client.getObject(input: input)
            
            guard let body = output.body else {
                throw ServiceError.getObjectBody("GetObjectInput missing body.")
            }
            
            guard let data = try await body.readData() else {
                throw ServiceError.readGetObjectBody("GetObjectInput unable to read data.")
            }
            
            try data.write(to: fileUrl)
        }
        catch {
            print("ERROR: ", dump(error, name: "Downloading a file."))
            throw error
        }
    }
    
    /// Read the specified file from the given S3 bucket into a Swift
    /// `Data` object.
    ///
    /// - Parameters:
    ///   - bucket: Name of the bucket containing the file to read.
    ///   - key: Name of the file within the bucket to read.
    ///
    /// - Returns: A `Data` object containing the complete file data.
    public func readFile(bucket: String, key: String) async throws -> Data {
        let input = GetObjectInput(
            bucket: bucket,
            key: key
        )
        do {
            let output = try await client.getObject(input: input)
            
            guard let body = output.body else {
                throw ServiceError.getObjectBody("GetObjectInput missing body.")
            }
            
            guard let data = try await body.readData() else {
                throw ServiceError.readGetObjectBody("GetObjectInput unable to read data.")
            }
            
            return data
        }
        catch {
            print("ERROR: ", dump(error, name: "Reading a file."))
            throw error
        }
    }
    
    /// Copy a file from one bucket to another.
    ///
    /// - Parameters:
    ///   - sourceBucket: Name of the bucket containing the source file.
    ///   - name: Name of the source file.
    ///   - destBucket: Name of the bucket to copy the file into.
    public func copyFile(from sourceBucket: String, name: String, to destBucket: String) async throws {
        let srcUrl = "\(sourceBucket)/\(name)".addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)
        
        let input = CopyObjectInput(
            bucket: destBucket,
            copySource: srcUrl,
            key: name
        )
        do {
            _ = try await client.copyObject(input: input)
        }
        catch {
            print("ERROR: ", dump(error, name: "Copying an object."))
            throw error
        }
    }
    
    /// Deletes the specified file from Amazon S3.
    ///
    /// - Parameters:
    ///   - bucket: Name of the bucket containing the file to delete.
    ///   - key: Name of the file to delete.
    ///
    public func deleteFile(bucket: String, key: String) async throws {
        let input = DeleteObjectInput(
            bucket: bucket,
            key: key
        )
        
        do {
            _ = try await client.deleteObject(input: input)
        }
        catch {
            print("ERROR: ", dump(error, name: "Deleting a file."))
            throw error
        }
    }
    
    /// Returns an array of strings, each naming one file in the
    /// specified bucket.
    ///
    /// - Parameter bucket: Name of the bucket to get a file listing for.
    /// - Returns: An array of `String` objects, each giving the name of
    ///            one file contained in the bucket.
    public func listBucketFiles(bucket: String) async throws -> [String] {
        do {
            let input = ListObjectsV2Input(
                bucket: bucket
            )
            
            // Use "Paginated" to get all the objects.
            // This lets the SDK handle the 'continuationToken' in "ListObjectsV2Output".
            let output = client.listObjectsV2Paginated(input: input)
            var names: [String] = []
            
            for try await page in output {
                guard let objList = page.contents else {
                    print("ERROR: listObjectsV2Paginated returned nil contents.")
                    continue
                }
                
                for obj in objList {
                    if let objName = obj.key {
                        names.append(objName)
                    }
                }
            }
            
            return names
        }
        catch {
            print("ERROR: ", dump(error, name: "Listing objects."))
            throw error
        }
    }
    
    /// Returns the URL of the specified file in the specified bucket.
    /// - Parameters:
    ///  - bucket: Name of the bucket containing the file.
    ///  - key: Name of the file.
    ///  - expires: The number of seconds until the URL expires.
    ///
    ///  - Returns: A URL object that can be used to download the file.
    public func getSignedUrl(bucket: String, key: String, expires: Int) async throws -> URL {
        let getObjectRequest = GetObjectInput(bucket: bucket, key: key)
        let expirationInSeconds: TimeInterval = Double(expires)
        
        do {
            let downloadUrl = try await getObjectRequest.presignURL(config: configuration, expiration: expirationInSeconds)
            if let downloadUrl = downloadUrl {
                return downloadUrl
            }
        }
        catch {
            print("ERROR: ", dump(error, name: "Getting a signed URL."))
        }
        throw ServiceError.missingContents("No signed URL returned.")
    }
}
