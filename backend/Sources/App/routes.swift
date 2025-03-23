import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { _ async in
        "It works!"
    }

//    app.get("hello") { _ async -> String in
//        "Hello, world!"
//    }

//    app.get("hello", ":name") { req in
//        req.redirect(to: "/hello")
//    }
    app.get("hello") { req -> String in
        let hello = try req.query.decode(Hello.self)
//        let name: String? = req.query["name"]
        return "Hello, \(hello.name ?? "Anonymous")"
        
    }
    
    app.post("greeting") { req in
        let greeting = try req.content.decode(Greeting.self)
        print(greeting.hello)
        
        return HTTPStatus.ok
    }

    try app.register(collection: TodoController())
}


struct Greeting: Content {
    var hello: String
}

struct Hello: Content {
    var name: String?
    
    mutating func afterDecode() throws {
        print("After decode")
    }
    mutating func beforeEncode() throws {
        print("Before encode")
    }
}
