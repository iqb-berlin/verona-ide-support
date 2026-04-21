plugins {
    id("org.jetbrains.intellij.platform") version "2.14.0"
}

group = providers.gradleProperty("group").get()
version = providers.gradleProperty("version").get()

repositories {
    mavenCentral()
    intellijPlatform {
        defaultRepositories()
    }
}

dependencies {
    intellijPlatform {
        intellijIdea("2025.3")
        bundledPlugin("com.intellij.modules.json")
    }
}

tasks {
    buildSearchableOptions {
        enabled = false
    }
}
