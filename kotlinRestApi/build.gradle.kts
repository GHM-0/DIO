import org.jetbrains.kotlin.gradle.tasks.KotlinCompile

plugins {
//  id("java")
    id("org.springframework.boot") version "3.2.2"
    id("io.spring.dependency-management") version "1.1.4"
//  id("org.hibernate.orm") version "6.4.1.Final"
    id("org.graalvm.buildtools.native") version "0.9.28"
//  id("org.asciidoctor.jvm.convert") version "3.3.2"
    id("org.flywaydb.flyway") version "10.8.1"
    
    kotlin("jvm") version "1.9.22"
    kotlin("plugin.allopen") version "1.9.22"
    kotlin("plugin.spring") version "1.9.22"
    kotlin("plugin.jpa") version "1.9.22"

}

group = "me.dio"
version = "0.0.1-SNAPSHOT"

java {
    sourceCompatibility = JavaVersion.VERSION_21
}

configurations {
    compileOnly {
        extendsFrom(configurations.annotationProcessor.get())
    }
}

repositories {
    mavenCentral()
}

//extra["snippetsDir"] = file("build/generated-snippets")
val snippetsDir by extra { file("build/generated-snippets") }

dependencies {
    implementation("org.springframework.boot:spring-boot-starter-data-jpa")
    implementation("org.springframework.boot:spring-boot-starter-validation")
    implementation("org.springdoc:springdoc-openapi-starter-webmvc-ui:2.3.0")
    implementation("org.springframework.boot:spring-boot-starter-web")
    implementation("com.fasterxml.jackson.module:jackson-module-kotlin")
    implementation("org.jetbrains.kotlin:kotlin-reflect")
    implementation("org.flywaydb:flyway-mysql:8.3.0")
//	implementation("org.springframework.boot:spring-boot-starter-security")
//  compileOnly("org.projectlombok:lombok")
//	developmentOnly("org.springframework.boot:spring-boot-devtools")
    runtimeOnly("com.mysql:mysql-connector-j")
    annotationProcessor("org.projectlombok:lombok")
    testImplementation("org.springframework.boot:spring-boot-starter-test") {
        exclude(module = "mockito-core")
    }
    testImplementation("org.springframework.restdocs:spring-restdocs-mockmvc")
//	testImplementation("org.springframework.security:spring-security-test")
//  testImplementation("io.mockk:mockk:1.13.9")
    testImplementation("com.ninja-squad:springmockk:4.0.2")

}

tasks.withType<KotlinCompile> {
    kotlinOptions {
        freeCompilerArgs += "-Xjsr305=strict"
        jvmTarget = "21"
    }
}

tasks.withType<Test> {
    useJUnitPlatform()
}

tasks.test {
    outputs.dir(snippetsDir)
    jvmArgs(
        "--add-opens", "java.base/java.lang.reflect=ALL-UNNAMED"
    )
}

//tasks.asciidoctor {
//    inputs.dir(snippetsDir)
//    dependsOn(tasks.test)
//}

//hibernate {
//    enhancement {
//        enableAssociationManagement.set(true)
//    }
//}

