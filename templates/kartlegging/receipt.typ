#import "/lib/common/sanitize.typ": sanitize
#import "/lib/common/components.typ": nav-document
#import "/lib/kartlegging/content.typ": receipt

#let data = sanitize(json("/data/kartlegging/receipt.json"))
#show: nav-document.with(title: "Kartlegging – Kvittering på ditt svar")
#receipt(data.at("brevdata", default: (:)))
