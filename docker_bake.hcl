variable "TARGET_NAME" {
}
variable "TAG" {
    default = "latest"
}
variable "CONTAINER_NAME" {
}
variable "REPO_URL" {
    default = "docker.io"
}
group "default" {
    targets = ["amd64"]
}

target "multi" {
    context = "./${TARGET_NAME}/"
    dockerfile = "Dockerfile"
    tags = ["${REPO_URL}/${CONTAINER_NAME}:${TAG}"]
    platforms = ["linux/amd64", "linux/arm64"]
}

target "amd64" {
    context = "./${TARGET_NAME}/"
    dockerfile = "Dockerfile"
    tags = ["${REPO_URL}/${CONTAINER_NAME}:${TAG}"]
    platforms = ["linux/amd64"]
}
