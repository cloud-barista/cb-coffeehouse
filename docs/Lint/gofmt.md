
## `gofmt`

### one-line-command to handle multiple `gofmt` errors
When I execute `golangci-lint`, I sometimes encountered multiple `gofmt` errors. 
I think it's related to the newline conversion issue of `git`.

Hope the one-line command below will save your time =)

```bash
$GOPATH/bin/golangci-lint run | grep gofmt | while read line; do f=(`echo $line | cut -d ':' -f 1`); echo $f; gofmt -s -w $f; done
```

In-detail
```bash
$GOPATH/bin/golangci-lint run | grep gofmt | while read line
do 
   f=(`echo $line | cut -d ':' -f 1`)
   echo $f
   gofmt -s -w $f
done
```