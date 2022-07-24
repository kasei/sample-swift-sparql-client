import Kineo
import Foundation

let sparql = """
SELECT DISTINCT ?city ?cityLabel ?population ?country ?countryLabel ?loc WHERE {
  {
    SELECT (MAX(?population_) AS ?population) ?country WHERE {
      ?city wdt:P31/wdt:P279* wd:Q515 .
      ?city wdt:P1082 ?population_ .
      ?city wdt:P17 ?country .
    }
    GROUP BY ?country
    ORDER BY DESC(?population)
  }
  ?city wdt:P31/wdt:P279* wd:Q515 .
  ?city wdt:P1082 ?population .
  ?city wdt:P17 ?country .
  ?city wdt:P625 ?loc .
  SERVICE wikibase:label {
    bd:serviceParam wikibase:language "en" .
  }
}
ORDER BY DESC(?population)
"""

let endpoint = URL(string: "http://query.wikidata.org/sparql")!
let client = SPARQLClient(endpoint: endpoint, silent: false)
do {
    let result = try client.execute(sparql)
    for r in result.bindings {
        let country = r["countryLabel"]?.value ?? ""
        let city = r["cityLabel"]?.value ?? ""
        let pop = Int(r["population"]?.numericValue ?? 0.0)
        print(String(format: "%9d\t%40@\t%20@", pop, country.padding(toLength: 40, withPad: " ", startingAt: 0), city))
    }
} catch let e {
    print("error: \(e)")
}
