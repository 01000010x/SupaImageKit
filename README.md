# SupaImageKit

🖼️ SwiftUI async image loader + cache for Supabase Storage for iOS

## Features
- Loads images from Supabase Storage
- Caches images locally
- Shows placeholder while loading
- 100% SwiftUI compatible

## Usage

```swift
SupabaseImageView(
    imageName: image_name_or_path_in_bucket,
    bucketName: bucket_name,
    client: your_supabase_client_instance,
    cacheType: disk_or_memory (.disk or .memory)
) { image in
    image
        .resizable()
        .scaledToFit()
}
```

## Missing things
1. Image loading error management
2. Adapt to use others downloaders (but maybe just use Nuke or KingFisher in this case)
3. Add tests
