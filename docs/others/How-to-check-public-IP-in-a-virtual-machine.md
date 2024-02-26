# How to check public IP in a virtual machine

I hope the command below will help you :blush:


## `dig`
> Precondition: `dig` is installed.

### OpenDNS
```
dig +short myip.opendns.com @resolver1.opendns.com
```

Result format:
```
XXX.XXX.XXX.XXX
```

### Google
```
dig TXT +short o-o.myaddr.l.google.com @ns1.google.com
```

Result format:
```
"XXX.XXX.XXX.XXX"
```

---

## `host`
Additional information comes with public IP
```
host myip.opendns.com resolver1.opendns.com
```

Result format:
```
Using domain server:
Name: resolver1.opendns.com
Address: XXX.XXX.XXX.XXX#XX
Aliases: 

myip.opendns.com has address XXX.XXX.XXX.XXX
Host myip.opendns.com not found: 3(NXDOMAIN)
Host myip.opendns.com not found: 3(NXDOMAIN)
```

---


## `curl`
> Precondition: `curl` is installed.
```
curl ipecho.net/plain; echo
```

Result format:
```
XXX.XXX.XXX.XXX
```

```
curl icanhazip.com
```

Result format:
```
XXX.XXX.XXX.XXX
```

```
curl ifconfig.co
```

Result format:
```
XXX.XXX.XXX.XXX
```

---

## `wget`
> Precondition: `wget` is installed.
```
wget -qO- http://ipecho.net/plain ; echo
```

Result format:
```
XXX.XXX.XXX.XXX
```

---

## `lynx`
> Precondition: `lynx` is installed.
```
lynx -dump checkip.dyndns.org
```


Result format:
```
Current IP Address: XXX.XXX.XXX.XXX
```

## Reference
- [IWINV Public(공인) IP 확인 방법](https://idchowto.com/?p=32574)

---

# How about `Go`
> Precondition: `github.com/chyeh/pubip` is imported.

- [You can see here!!](https://github.com/cloud-barista/cb-spider/blob/9ce2c5ac980543624395e5d382f340c13d1b111d/api-runtime/rest-runtime/CBSpiderRuntime.go#L54)

