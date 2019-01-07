## otus code challenge
R program to reads wikipedia files organized hourly, cleans the data by removing na, null and empty strings and process the data to fetch the following analytics
- Most requested article for that day
- Least requested article for that day
- Top 5 categories for that day
- Which hour had the most requests? How many? Which article?
- Which hour had the least requests? How many? Which article?

## Code repo structure
create a your own project folder on your system, example: "yourProjectFolder". Under that folder save otusCodeChallenge.R in the same folder create "data" folder, that will hold hourly wikipedia data. 

- yourProjectFolder --> otusCodeChallenge.R
- yourProjectFolder --> data

## Running the code
If R is not locally installed, please follow the article https://www.datacamp.com/community/tutorials/installing-R-windows-mac-ubuntu
to install related R software for your enviroment

After R is installed on your machine go to "yourProjectFolder" and run the following command

Rscript otusCodeChallenge.R


## Sample output

File wikipedia_e_20140913.11.tsv is used as input 
```
- Most requested article of the day is: English_alphabet
```
```
- Least requested article of the day is: E!E
```

- Top 5 categories for the day
```
                                    categories count
9899                         All_stub_articles  8777
55702                            Living_people  5285
9882    All_articles_with_unsourced_statements  4989
28509                  Coordinates_on_Wikidata  4073
95128 Wikipedia_articles_with_VIAF_identifiers  3927
Most requested article of the day is English_alphabet"
```

```
- The hour that has most requests is wikipedia_e_20140913.11.tsv
- Number of requests in that hour: 960
- Most requested Article of that hourEnglish_alphabet
```

```
- The hour that has least requests is wikipedia_e_20140913.11.tsv
- Number of requests in that hour: 1
- Least requested Article of that hour: E!E
```

