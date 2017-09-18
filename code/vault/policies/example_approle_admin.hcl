path "auth/approle/role/example*" {
  policy = "write"
  capabilities = ["create","update","list","read"]
}

path "sys/capabilities-self" {
  policy = "read"
}
