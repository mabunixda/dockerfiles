variable "TARGET_NAME" {
}
variable "TAG" {
    default = "latest"
}
variable "CONTAINER_NAME" {
}

group "default" {
    targets = ["amd64"]
}

target "multi" {
    context = "./${TARGET_NAME}/"
    dockerfile = "Dockerfile"
    tags = ["docker.io/mabunixda/${CONTAINER_NAME}:${TAG}"]
    platforms = ["linux/amd64", "linux/arm64"]
}

target "amd64" {
    context = "./${TARGET_NAME}/"
    dockerfile = "Dockerfile"
    tags = ["docker.io/mabunixda/${CONTAINER_NAME}:${TAG}"]
    platforms = ["linux/amd64"]
}
