# a hash comment
// a slash comment
/* a block comment */

resource "aws_instance" "example" {
  ami = "ami-12345678" # an inline hash comment
}
