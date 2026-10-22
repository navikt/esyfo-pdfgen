// Equivalent output to iso_to_long_date (Norwegian d. MMMM yyyy).
// Missing input renders empty; invalid input fails without echoing user data.
#let iso-to-long-date(value) = {
  if value == none { return "" }
  assert(type(value) == str, message: "Expected an ISO date")
  // Validate before numeric conversion so diagnostics never contain input.
  let offset = "(?:[Zz]|[+-](?:(?:0[0-9]|1[0-7]):[0-5][0-9](?::[0-5][0-9])?|18:00(?::00)?))"
  let time = "(?:[Tt](?:[01][0-9]|2[0-3]):[0-5][0-9](?::[0-5][0-9](?:\\.[0-9]{1,9})?)?)?"
  let pattern = regex("^[0-9]{4}-[0-9]{2}-[0-9]{2}" + time + offset + "?$")
  assert(value.match(pattern) != none, message: "Expected an ISO date or datetime")
  let date = value.slice(0, 10)
  let parts = date.split("-")
  assert(parts.len() == 3, message: "Expected an ISO date")
  let year = int(parts.at(0))
  let month = int(parts.at(1))
  let day = int(parts.at(2))
  let leap = calc.rem(year, 4) == 0 and (calc.rem(year, 100) != 0 or calc.rem(year, 400) == 0)
  let days = (31, if leap { 29 } else { 28 }, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31)
  assert(month >= 1 and month <= 12, message: "Invalid ISO month")
  assert(day >= 1 and day <= days.at(month - 1), message: "Invalid ISO day")
  let months = ("januar", "februar", "mars", "april", "mai", "juni", "juli", "august", "september", "oktober", "november", "desember")
  // Java's yyyy uses a padded year-of-era, including ISO year zero.
  let formatted-year = if year == 0 { "0001" } else { parts.at(0) }
  str(day) + ". " + months.at(month - 1) + " " + formatted-year
}
