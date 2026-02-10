<details open>

<summary>English version</summary>

[Leaflet](https://github.com/Leaflet/Leaflet) is an open-source JavaScript library for interactive maps. lod4leaflet is curently used to read [BEACON files](https://gbv.github.io/beaconspec/beacon.html) with IDs of buildings for which literature is referenced in [BMS online](https://musikforschung.github.io/bms_beacon/). Further information on these IDs is retrieved from [Entity-Facts](https://www.dnb.de/DE/Professionell/Metadatendienste/Datenbezug/Entity-Facts/entityFacts_node.html). If necessary, coordinates of buildings are added from [Wikidata](https://www.wikidata.org/wiki/Wikidata:Main_Page). The enriched data is finally transformed into JavaScript arrays for visualization with Leaflet. 
Two use cases are conceivable.
1. For smaller projects, CSV files with GND identifiers are read and automatically enriched with relevant information from the GND. Coordinates are added from Wikidata as needed. This data serves as the basis for determining further information.
2. As is currently the case, the data is used to visualize bibliographic references for buildings from BMS online.


# Currently supported data fields
* id (string, URI)
* preferredName (string))
* entityType (string (person/place/organisation/event)
* label (string)
address
* country (string)
* street (string)
* streetNumber (string)
* addressSource (string (string (text,url,date))
coordinates
* latitude (decimal degrees - EPSG:4326, points (ISO 6709) NOT NULL
* longitude (decimal degrees - EPSG:4326, points (ISO 6709) NOT NULL
* coordinatesSource (string (string (text,url,date))
* dateOfEstablishment (string)
* dateOfEstablishmentSource (string (text,url,date))
* dateOfTermination (string)
* dateOfTerminationSource (string (text,url,date))
* dateOfEvent (string)
* dateOfEventSource (string (text/URL,date))
* sameAsName (string)
* sameAsURL (string/URL)
* biographicalOrHistoricalInformation (string)
* biographicalOrHistoricalInformationSource (string (text,url,date)) 
* depictionName (string (directory path/URL)
* depictionFormat (string (jpg or png))
* depictionWidth (integer (pixel))
* depictionHight (integer (pixel))
* depictionText (string)
* depictionCeator (string)
* depictionPublisher (string)
* depictionSource (string, directory path/URL)
* depictionLicense (string)
* depictionLicenseURI (string, URI)

# Author

René Wallor, wallor at sim.spk-berlin.de

# Licence

Leaflet - BSD 2-Clause License

</details>