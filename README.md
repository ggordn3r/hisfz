# hisfz: Hawaii single-family zoning
Quantitative and spatial analyses of proposed land use policy changes in Hawaii. Relies heavily on the Hawaii Zoning Atlas.

The repo is organized as follows:
- All **code** lives in the root folder
- Datasets live in the **data** folder
  - **islands** contains outlines of each county. Useful for clipping.
  - **lege** contains State House and Senate districts as of the 2020 redistricting. Necessary for district-level analysis.
  - **zoning_maps** contains spatial versions of the _Hawaii Zoning Atlas_ data. Spring 2024 vintage.
  - **zoning_text** contains non-spatial versions of the same.
  - Also included: datasets that have been used for one-off analyses (parcels, SMA, SLUD, etc.)
- Tables and charts live in the **output** folder
  - of note: the **by_district** subfolder is generated iteratively by `house_district_analysis.ipynb`

# Bills analyzed

## State of Hawaii
- [SOH SB 3202 (2024)](https://legiscan.com/HI/research/SB3202/2024) - Passed as Act 39. Requires counties to adopt policies that will permit 2 ADUs on most residential parcels.
  - `conference_analysis.ipynb` maps the effective area of the final (conference) draft of the bill, which excludes certain State Land Use Districts, Special Management Areas, and hazard areas. Outputs tables and maps.
  - `house_district_analysis.ipynb` calculates single-family zoning area by House District to understand the impact that the Starter Homes Bill might have on each district. Includes handy code for creating a statewide zoning dataset, and for iteratively generating tables and graphs for each district.
  - `sb3202.ipynb` explores an intermediate draft of the bill. Useful mainly for reference in using KML files, and in grouping and mapping zones.

## Maui
- [Maui Bill 103 (2024)](https://mauicounty.legistar.com/LegislationDetail.aspx?ID=6782739&GUID=A0F86483-9113-4B25-BE47-869E0743AB02) - Proposal to increase the number of units allowed per parcel in residential areas from 1 per 6000-10000 sqft of lot area to 1 per 2500. Excludes Molokai.
    - `maui_density_bill.ipynb` joins Maui zoning and parcel data to explore the potential impacts of the bill on zoned capacity. 
    - Processed spatial dataset is stored as `data\maui_gdf.geojson`. 
    - Tabular results are exported as `output\maui_nui_parcels_with_zoning.csv`.

## Honolulu
- TBD

## Hawaii (Big Island)
- Hawaii Bill ___ - major update to land use ordinance. I can't remember the bill # right now.
  - `county_analysis.ipynb` is an incomplete county-level exploration of HZA data.

# About the Hawaii Zoning Atlas
The [Hawaii Zoning Atlas](https://www.zoningatlas.org/hawaii) is a comprehensive statewide dataset of zoning regulations with a focus on housing. The data is free for non-commercial use and the latest (Spring 2024) vintage be found as `final.geojson` in the [CodeWithAloha/Hawaii-Zoning-Atlas](https://github.com/CodeWithAloha/Hawaii-Zoning-Atlas/blob/main/data/final.geojson) repo. That README includes more background on the creation of the dataset.

For a data dictionary, see [_How to Make a Zoning Atlas 2.0: The Official Methodology of the National Zoning Atlas_](https://papers.ssrn.com/sol3/papers.cfm?abstract_id=4476927). The use of a national data standard allows researchers to compare Hawaii with other jurisdictions and with itself over successive policy changes.

[HZA kickoff](https://www.youtube.com/watch?v=1BLN3iTP4zs) - the first 25 minutes of this video include a discussion of exclusionary zoning in Hawaii, a demonstration of the Atlas, and potential applications of the underlying dataset.

[Regulatory utilization](https://www.youtube.com/watch?v=Q039zSy9blc) - HZA director Trey Gordner's masters thesis discusses how to use open GIS data (like the zoning atlas, which came later) to estimate the restrictiveness of land use regulations.