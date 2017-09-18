# CRUD on sys
path "sys/*" {
    capabilities = ["delete","update","list","read","create"]
}

# CRUD on policies
path "sys/policy/*" {
    capabilities = ["delete","update","list","read","create"]
}

# CRUD on 'secret' path
path "secret/*" {
    capabilities = ["delete","update","list","read","create"]
}

# CRUD on auth
path "auth/*" {
    capabilities = ["delete","update","list","read","create"]
}

# CRUD on approle
path "auth/approle/*" {
  capabilities = ["delete","update","list","read","create"]
}

# CRUD on users
path "auth/userpass/*" {
    capabilities = ["delete","update","list","read","create"]
}
