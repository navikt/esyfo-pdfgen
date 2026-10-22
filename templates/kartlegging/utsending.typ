#import "/lib/common/sanitize.typ": sanitize
#import "/lib/common/components.typ": nav-document
#import "/lib/kartlegging/content.typ": utsending

#let data = sanitize(json("/data/kartlegging/utsending.json"))
#show: nav-document.with(title: "Kartleggingsspørsmål")
#utsending(data.at("brevdata", default: (:)))
