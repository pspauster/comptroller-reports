library(httr2)
library(jsonlite)

reports <- request("https://comptroller.nyc.gov/reports/") |>
  req_method("POST") |>
  req_headers(
    accept = "*/*",
    `accept-language` = "en-US,en;q=0.9",
    dnt = "1",
    origin = "https://comptroller.nyc.gov",
    priority = "u=1, i",
    referer = "https://comptroller.nyc.gov/reports/",
    `sec-ch-ua` = '"Not(A:Brand";v="99", "Google Chrome";v="133", "Chromium";v="133"',
    `sec-ch-ua-mobile` = "?1",
    `sec-ch-ua-platform` = '"Android"',
    `sec-fetch-dest` = "empty",
    `sec-fetch-mode` = "cors",
    `sec-fetch-site` = "same-origin",
    `sec-gpc` = "1",
    `user-agent` = "Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Mobile Safari/537.36",
    cookie = "_ga=GA1.1.735885569.1725385004; _ga_7FM414V4W9=GS1.1.1725630511.2.0.1725630511.0.0.0; visid_incap_1216935=y40F6a0SRQ+ZtXC9ktZqDRMNxmcAAAAAQUIPAAAAAAB2biEOTZ1fDp5XviWcoh4K; _ga_GYRKWPJBCL=GS1.1.1741064755.2.0.1741064755.0.0.0; PHPSESSID=jsto6s50bp2u81qreeuh8fmk3b; nlbi_1216935=WXSXUuU4amjkz5OBq3Ux7gAAAADsutS2Kij0ncmE8sAgWt+j; incap_ses_180_1216935=YQeRIBcAomzgVlxiT31/Ar2HyGcAAAAA2Vh2XQLYPQzeJ7nHcx9Wkg==; _ga_BLHED8K050=GS1.1.1741195198.7.0.1741195198.0.0.0"
  ) |>
  req_body_raw(
    '{"action":"facetwp_refresh","data":{"facets":{"type":[],"topic":[],"agency":[],"date":[],"search":""},"frozen_facets":{},"http_params":{"get":{},"uri":"reports","url_vars":[]},"template":"wp","extras":{"pager":true,"counts":true,"sort":"default"},"soft_refresh":0,"is_bfcache":1,"first_load":0,"paged":1}}',
    type = "application/json"
  ) |>
  req_perform()

# Decompress the response body
raw_body <- resp_body_raw(reports)
decompressed_body <- memDecompress(raw_body, type = "gzip")

# Convert raw bytes to character string
json_text <- rawToChar(raw_body)

# Parse JSON to list
parsed_data <- fromJSON(json_text)

# Check structure
str(parsed_data)

# Convert to dataframe (modify based on JSON structure)
df <- as.data.frame(parsed_data)

# Print the dataframe
print(df)

