#let data = json("/data/example/test.json")

#set document(
    title: "Test"
)
#set text(font: "Source Sans 3", lang: "nb", size: 11pt, fallback: false)

= Eksempel

#data.at("message", default: "Dette er en test")