#let data = json("/data/example/test.json")

#set document(
    title: "Test"
)

= Eksempel

#data.at("message", default: "Dette er en test")