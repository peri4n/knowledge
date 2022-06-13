package main

import (
	"net/http"
	"text/template"
)

func main() {
  mux := http.NewServeMux()
  files := http.FileServer(http.Dir("/public"))
  mux.Handle("/static", http.StripPrefix("/static/", files))

  mux.Handle("/", index)
  mux.Handle("/err", err)

  mux.Handle("/login", login)
  mux.Handle("/logout", logout)
  mux.Handle("/signup", signup)
  mux.Handle("/signup_account", signup_account)
  mux.Handle("/authenticate", authenticate)

  mux.Handle("/thread/new", newThread)
  mux.Handle("/thread/create", createThread)
  mux.Handle("/thread/post", postThread)
  mux.Handle("/thread/read", readThread)

  server := &http.Server{
    Addr: "0.0.0.0:8080",
    Handler: mux,
  }

  server.ListenAndServe()
}

func index(w http.ResponseWriter, r *http.Request) {
  files := []string{
    "templates/layout.html",
    "templates/navbar.html",
    "templates/index.html",
  }

  templates := template.Must(template.ParseFiles(files...))
  threads, err := data.Threads()

  if err == nil {
    templates.ExecuteTemplate(w, "layout", threads)
  }

}
