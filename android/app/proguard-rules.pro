# Flutter-specific rules
-keep class io.flutter.** { *; }
-dontwarn io.flutter.**
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.embedding.** { *; }

# Kotlin-specific rules
-keep class kotlin.** { *; }
-keep class kotlin.Metadata { *; }
-dontwarn kotlin.**
-keepclassmembers class **$WhenMappings {
    <fields>;
}
-keepclassmembers class kotlin.Metadata {
    public <methods>;
}

# Keep classes and members for JSON serialization (json_annotation, freezed, json_serializable)
-keep class **.JsonSerializable { *; }
-keepclassmembers class **.JsonSerializable {
    <fields>;
    <methods>;
}
-keep class **.Freezed { *; }
-keepclassmembers class **.Freezed {
    <fields>;
    <methods>;
}
-keepattributes *Annotation*
-keepattributes Signature
-keepattributes EnclosingMethod

# Dio (HTTP client)
-keep class com.github.dio.** { *; }
-dontwarn com.github.dio.**
-keep class retrofit2.** { *; }
-dontwarn retrofit2.**

# Riverpod and hooks_riverpod
-keep class dev.riverpod.** { *; }
-dontwarn dev.riverpod.**
-keep class riverpod.** { *; }
-dontwarn riverpod.**

# Geolocator and Geocoding
-keep class com.baseflow.geolocator.** { *; }
-dontwarn com.baseflow.geolocator.**
-keep class com.baseflow.geocoding.** { *; }
-dontwarn com.baseflow.geocoding.**

# Flutter Map and latlong2
-keep class com.google.maps.** { *; }
-dontwarn com.google.maps.**
-keep class com.mapbox.mapboxsdk.** { *; }
-dontwarn com.mapbox.mapboxsdk.**
-keep class latlong2.** { *; }
-dontwarn latlong2.**

# Image Picker
-keep class com.github.dhaval2404.imagepicker.** { *; }
-dontwarn com.github.dhaval2404.imagepicker.**

# URL Launcher
-keep class io.github.ponnamkarthik.url_launcher.** { *; }
-dontwarn io.github.ponnamkarthik.url_launcher.**

# Lottie
-keep class com.airbnb.lottie.** { *; }
-dontwarn com.airbnb.lottie.**

# Shared Preferences
-keep class io.flutter.plugins.sharedpreferences.** { *; }
-dontwarn io.flutter.plugins.sharedpreferences.**

# HTML parsing
-keep class org.jsoup.** { *; }
-dontwarn org.jsoup.**

# Font Awesome
-keep class com.fontawesome.** { *; }
-dontwarn com.fontawesome.**

# Country Code Picker
-keep class com.hbb20.CountryCodePicker { *; }
-dontwarn com.hbb20.CountryCodePicker

# Package Info Plus
-keep class io.flutter.plugins.packageinfo.** { *; }
-dontwarn io.flutter.plugins.packageinfo.**

# Upgrader
-keep class com.larryhsiao.upgrader.** { *; }
-dontwarn com.larryhsiao.upgrader.**

# General Android rules
-keep class androidx.** { *; }
-dontwarn androidx.**
-keep class com.google.android.** { *; }
-dontwarn com.google.android.**

# Prevent R8 from removing unused classes
-keep class **.R { *; }
-keepclassmembers class **.R$* {
    public static <fields>;
}

# Keep model classes and their members
-keep class com.org.hand_car_app.** { *; }
-keepclassmembers class com.org.hand_car_app.** {
    <fields>;
    <methods>;
}

# Suppress warnings for libraries that might not be used
-dontwarn okio.**
-dontwarn okhttp3.**
-dontwarn javax.annotation.**
-dontwarn com.google.common.**

# Preserve line numbers for debugging
-keepattributes SourceFile,LineNumberTable

# Keep enums
-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}

# Keep Parcelable classes
-keep class * implements android.os.Parcelable {
    public static final android.os.Parcelable$Creator *;
}