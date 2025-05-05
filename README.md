# iPad POS

這是一款基於 SwiftUI + Firebase 的 POS 系統，專為餐飲業設計。目標是以最少成本建立一個具有線上點餐功能的 POS 系統。
線上網頁的原始碼在 [online-order-system](https://github.com/brianchou452/online-order-system)

## Development

- 本專案需要自行建立 Firebase 專案，將 Firebase 的設定檔放到 `pos/GoogleService-Info.plist`

- 本專案使用 MinIO 作為 S3 的免費替代方案，請在 `pos/Config.xcconfig` 中設定以下內容

    ```swift
    // Config.xcconfig
    // Configuration settings file format documentation can be found at:
    // https://help.apple.com/xcode/#/dev745c5c974

    S3_STORAGE_ENDPOINT = your-storage-api.company.com
    S3_STORAGE_ACCESS_KEY = your-access-key
    S3_STORAGE_SECRET_KEY = your-secret-key
    ```
