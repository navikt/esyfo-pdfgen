// PDF/A and PDF/UA export fails when a character has no glyph in the document
// font, so user-supplied text is restricted to what Source Sans 3 covers
// (Windows-1252, Latin Extended-A, Greek and Cyrillic incl. Ukrainian) and
// emoji with their sequence components (ZWJ, VS16, keycap, tags), rendered by
// the Noto Color Emoji fallback.
#let placeholder = "?"

#let unsupported = regex(
  "[^\\n\\p{Emoji}\\x{200D}\\x{FE0F}\\x{20E3}\\x{E0020}-\\x{E007F}"
    + "\\x{20}-\\x{7E}\\x{A0}-\\x{17F}\\x{218}-\\x{21B}"
    + "\\x{384}-\\x{38A}\\x{38C}\\x{38E}-\\x{3A1}\\x{3A3}-\\x{3CE}"
    + "\\x{400}-\\x{45F}\\x{490}-\\x{491}"
    + "\\x{2013}\\x{2014}\\x{2018}-\\x{201A}\\x{201C}-\\x{201E}"
    + "\\x{2020}-\\x{2022}\\x{2026}\\x{2030}\\x{2039}\\x{203A}\\x{20AC}\\x{2122}]+",
)

#let sanitize-text(value) = (
  value
    .replace("\r\n", "\n")
    .replace("\r", "\n")
    .replace("\t", " ")
    .replace(unsupported, placeholder)
)

// Recursively sanitizes every string in decoded JSON data.
#let sanitize(value) = {
  if type(value) == str {
    sanitize-text(value)
  } else if type(value) == array {
    value.map(sanitize)
  } else if type(value) == dictionary {
    value.pairs().map(((key, item)) => (key, sanitize(item))).to-dict()
  } else {
    value
  }
}
