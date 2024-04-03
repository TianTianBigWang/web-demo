package main

import (
	"github.com/kataras/iris/v12"
	"os"
)

func main() {
	name := os.Getenv("NAME")
	if name == "" {
		name = "World"
	}
	app := iris.New()
	app.Use(iris.Compression)

	app.Get("/", func(ctx iris.Context) {
		ctx.HTML("Hello <strong>%s</strong>!", name)
	})

	app.Listen(":8080")
}
