# say yes to UI
ui = true

# simple file system
storage "file" {
  path = "/vault/file"
}

# listen to all address
listener "tcp" {
 address     = "0.0.0.0:8200"
 tls_disable = 1
}
