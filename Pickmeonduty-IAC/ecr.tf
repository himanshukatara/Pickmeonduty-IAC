resource "aws_ecr_repository" "pickme-dev" {
  name                 = "pickme-dev"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}


resource "aws_ecr_repository" "onduty-dev" {
  name                 = "onduty-dev"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}
