# CMEMS INSITU BS NRT Observations Analysis Toolbox

This MATLAB toolbox is developed to analyze, visualize, and compare INSITU observational data from the Black Sea region using data provided by the Copernicus Marine Environment Monitoring Service (CMEMS).

The toolbox works primarily with data from the following source:

[CMEMS INSITU BS NRT Observations Dataset (FTP)](ftp://nrt.cmems-du.eu/Core/INSITU_BS_NRT_OBSERVATIONS_013_034/bs_multiparameter_nrt/history/PF/)

---

## Objectives

This toolbox is designed to:

- **Map spatial coverage** of in-situ profiles (e.g., ARGO floats, CTDs) over the Black Sea.
- **Generate observation summary tables** comparing:
  - Number of observations from the **NRT (Near Real-Time)** dataset
  - Number of observations from the **REP (Reprocessed)** dataset
- Analyze and debug issues related to **Hovmöller diagrams** for temporal-spatial variability assessment.

---

## Features

| Feature | Description |
|--------|-------------|
| `load_and_parse_profiles.m` | Downloads and parses netCDF profiles from CMEMS FTP |
| `plot_spatial_coverage.m` | Plots georeferenced observation locations on a Black Sea map |
| `generate_observation_table.m` | Counts observations per month/year/platform and compares NRT vs REP |
| `plot_hovmoller.m` | Generates depth-time (Hovmöller) diagrams from INSITU data |
| `utils/` | Contains helper scripts for FTP parsing, QC flag filtering, and interpolation |

---

## Input Datasets

| Dataset | Source | Description |
|---------|--------|-------------|
| **NRT INSITU Data** | [CMEMS FTP](ftp://nrt.cmems-du.eu/Core/INSITU_BS_NRT_OBSERVATIONS_013_034/) | Near real-time multiparameter in-situ profiles |
| **REP INSITU Data** | (If used, local access assumed) | Long-term reprocessed in-situ profiles for Black Sea |

---

## Example Outputs

- **Spatial coverage map**: Identifies geographic extent of observations across years and depths.
- **Observation summary table**: Number of profiles per platform type and year.
- **Hovmöller diagram**: Depth-time heatmaps showing seasonal or interannual changes (e.g., temperature or salinity).

---

## Known Issues / To Investigate

- ⚠️ **Hovmöller inconsistencies**: Investigate temporal gaps, resolution mismatches, or interpolated layers affecting pattern visibility.

---

## Requirements

- MATLAB R2021a or later
- Mapping Toolbox (for geographic plotting)
- Internet access for CMEMS FTP downloads

---

## License

This toolbox is shared under the MIT License (see [LICENSE](LICENSE)).

---

## Author

**Farshid Daryabor**  
  


