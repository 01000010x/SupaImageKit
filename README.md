# SupaImageKit

<pre>
```swift
.package(url: "https://github.com/01000010x/SupaImageKit", from: "1.0.0")
```
</pre>

🖼️ SwiftUI async image loader + cache for Supabase Storage.

## Features
- Loads images from Supabase Storage
- Caches them locally
- Shows placeholder while loading
- 100% SwiftUI compatible

## Usage

```swift
SupaImageView(
    imageName: "photo.jpg",
    cache: MyImageCache(),
    downloader: MySupabaseDownloader()
)
.resizable()
.aspectRatio(contentMode: .fill)
```

## Missing things
1. Image loading error management
2. Adapt to use others downloaders (but maybe just use Nuke or KingFisher in this case)
3. Add tests
