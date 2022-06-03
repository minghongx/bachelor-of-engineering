import re
import requests
import wget
from bs4 import BeautifulSoup
from pathlib import Path

def dl_data(YYYY_or_YYYYdashMM: str, output_dir: str) -> None:
    page = requests.get(f"https://www.caa.co.uk/Data-and-analysis/UK-aviation-market/Airports/Datasets/UK-Airport-data/Airport-data-{YYYY_or_YYYYdashMM}/")
    data_link_pattern = re.compile(r"\/uploadedFiles\/CAA\/Content\/Standard_Content\/Data_and_analysis\/Datasets\/Airport_stats\/.*")

    soup = BeautifulSoup(page.text, "html.parser")
    data_tags = soup.find_all('a', href = data_link_pattern)  # would return an empty list
    data_links = ["https://www.caa.co.uk" + href for data_tag in data_tags if re.match(".*.csv", href := data_tag.attrs["href"])]
    # It is safe to say data_tag.attrs because the for loop will not be executed if data_tags is empty, and this list comprehension will return an empty list.

    for data_link in data_links:  # No output dir will be created and no download will be requested if data_links is empty.
        Path(output_dir).mkdir(parents=True, exist_ok=True)  # check output dir existence every time before downloading
        wget.download(data_link, out=output_dir)


# demo
for year in range(2018, 2022):
    dl_data(year, f"./data/{year}")
    for month in range(1, 13):
        if month < 10:
            dl_data(yyyydashmm := f"{year}-0{month}", f"./data/{yyyydashmm}")
        else:
            dl_data(yyyydashmm := f"{year}-{month}", f"./data/{yyyydashmm}")
