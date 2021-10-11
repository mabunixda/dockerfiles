variable "TARGET_NAME" {
    default = ""
}
variable "TAG" {
    default = "latest"
}

group "default" {
    targets = ["amd64"]
}

target "multi" {
    dockerfile = "${TARGET_NAME}/Dockerfile"
    tags = ["docker.io/mabunixda/${TARGET_NAME}:${TAG}"]
    platforms = ["linux/amd64", "linux/arm64"]
}

target "amd64" {
    context = "./${TARGET_NAME}/"
    dockerfile = "Dockerfile"
    tags = ["docker.io/mabunixda/${TARGET_NAME}:${TAG}"]
    platforms = ["linux/amd64"]
}
