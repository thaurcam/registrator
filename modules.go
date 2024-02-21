package main

import (
	_ "github.com/thaurcam/registrator/bridge"
	_ "github.com/thaurcam/registrator/consul"
	_ "github.com/thaurcam/registrator/consulkv"
	_ "github.com/thaurcam/registrator/etcd"
	_ "github.com/thaurcam/registrator/skydns2"
	_ "github.com/thaurcam/registrator/zookeeper"
)
