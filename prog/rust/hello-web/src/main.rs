use actix_web::{web, App, HttpResponse, HttpServer, Responder, main};

async fn hello() -> impl Responder {
  HttpResponse::Ok().body("Hello World")
}

#[main]
async fn main() -> std::io::Result<()> {
    println!("Listening on port 8080");
    HttpServer::new(|| {
        App::new().route("/hello", web::get().to(hello))
    })
    .bind("127.0.0.1:8080")?
    .run()
    .await
}
