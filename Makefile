.PHONY: default build clean lint fmt test deps source update

PACKAGE = yubi-go
NAMESPACE = github.com/akerl
VERSION ?= $(shell git describe --tags --always --dirty --match=v* 2>/dev/null)
export GOPATH = $(CURDIR)/.gopath
BIN = $(GOPATH)/bin
BASE = $(GOPATH)/src/$(NAMESPACE)/$(PACKAGE)
GOFILES = $(shell find . -type f -name '*.go' ! -path './.*' ! -path './vendor/*')

GO = go
GOFMT = gofmt
GOX = $(BIN)/gox
GOLINT = $(BIN)/golint
GODEP = $(BIN)/dep

build: source deps $(GOX) fmt lint test
	$(GOX) \
		-ldflags '-X $(NAMESPACE)/$(PACKAGE)/cmd.Version=$(VERSION)' \
		-gocmd="$(GO)" \
		-output="bin/$(PACKAGE)_{{.OS}}" \
		-os="darwin linux" \
		-arch="amd64"
	@echo "Build completed"

clean:
	rm -rf $(GOPATH) bin

lint: $(GOLINT)
	$(GOLINT) -set_exit_status ./...

fmt:
	@echo "Running gofmt on $(GOFILES)"
	@files=$$($(GOFMT) -l $(GOFILES)); if [ -n "$$files" ]; then \
		  echo "Error: '$(GOFMT)' needs to be run on:"; \
		  echo "$${files}"; \
		  exit 1; \
		  fi;

test: deps
	cd $(BASE) && $(GO) test ./...

Gopkg.toml: source $(GODEP)
	cd $(BASE) && $(GODEP) init
	cp $(BASE)/Gopkg.{lock,toml} ./

update:
	cd $(BASE) && $(GODEP) ensure -update
	cp $(BASE)/Gopkg.{lock,toml} ./

deps: source Gopkg.toml $(GODEP)
	cd $(BASE) && $(GODEP) ensure

$(BASE):
	mkdir -p $(dir $@)

source: $(BASE)
	rsync -ax --delete --exclude '.gopath' --exclude '.git' --exclude vendor $(CURDIR)/ $(BASE)

$(GOLINT): $(BASE)
	$(GO) get github.com/golang/lint/golint

$(GOX): $(BASE)
	$(GO) get github.com/mitchellh/gox

$(GODEP): $(BASE)
	$(GO) get github.com/golang/dep/cmd/dep
