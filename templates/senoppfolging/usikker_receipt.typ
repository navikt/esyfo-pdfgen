#import "/lib/common/sanitize.typ": sanitize
#import "/lib/common/components.typ": nav-document
#import "/lib/senoppfolging/receipts.typ": situation-receipt

#let data = sanitize(json("/data/senoppfolging/usikker_receipt.json"))
#show: nav-document.with(title: "Snart slutt på sykepenger")
#situation-receipt(data.at("brevdata", default: (:)), "usikker")
