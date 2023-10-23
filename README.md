# Paintings, Prices, and Characteristics

### Project Information
  - DS 4002
  - Project 2
  - Team: AAI
  - This repository is a collaboration between Ishan Koroth, Ashley Huang, and Ana Cristina Cordova for DS 4002 Project 2

## Context

Paintings are everywhere we look. Whether in our own houses or the doctor's waiting room, we see them all the time. Some paintings are really expensive while some paintings are cheap; however, have you wondered if certain characteristics such as color or date relate to the price of painting? There are various famous paintings throughout history, but there are some more valuable than others. We want to look into what characteristics make these paintings more expensive. 

For Project 2 we are going to look into the characteristics that associate with the 200 most expensive paintings. We want to see if certain colors, dates, or artists are associated with higher priced paintings. Many people are not aware of how paintings are priced. Next time you buy a painting for yourself it will help to know what makes it more or less expensive. 

## Repository Contents 
All code used for this project can be found in the [SRC](https://github.com/ik4vrb/ds-4002-team-aai-project-2/tree/main/SRC) folder.

### Code Installing/Building

This project was created using Python. Here are the steps:

1. Do a git clone or download the zip file to install everything.
2. Open the Image_Extractor.py file in an IDE that runs Python.
3. Proceed by running the code, which will execute the code and output results for image entropy and number of colors used.
NOTE: A csv file called "Image_URL_Data.csv" will be outputted from this code. Also, remember to install the necessary modules used in the script.
4. Open the RMD file in an IDE that runs R, preferably RStudio or something like that.
5. Run every chunk of the RMD to output results to build models comparing the metadata and characteristics.
NOTE: If the pd.read_csv does not work, append "Data/" to the beginning of the string in the input. (EX: "Data/Image links - Sheet1.csv")
An alternative to step 6 would be to move the files from Data into the same directory as the Image_Extractor.py file.

### Code Usage

There are two files in the SRC folder:

The first one is called DS_4002_Project_2.py and contains a script that parses through the image urls for entropy and color analysis.
The second file is and RMD file that creates models comparing the metadata and characteristics from the python script with the prices for the paintings.

## Data

All the data for this project can be found in the [Data](https://github.com/ik4vrb/ds-4002-team-aai-project-2/tree/main/Data) folder.
There are two data sets in the folder:
1. painting_medaD_final.csv: The Main Data set used to generate the whole project.
2. Image_URL_Data.csv: An example of what the csv file outped by Image_Extractor.py should look like.
   
### Main Data Set

|    Column     |  Description  |   Type  |
| ------------- | ------------- |------------- |
|    artist     | The name of the artist| Character |
| painting_name | Name of the painting | Character |
|estimated_price| The estimated price of the painting in millions | Character |
|     year      | The year that the painting was created| Numeric |
|  time_period  | The general time frame of when the painting was created: Before 1850, 1850 to 1945, and Postwar and contemporary  | Character (factor variable) |
|estimated_price_millions | The estimated price of the painting in millions|  Numeric |
|  paint_type   | The type of paint used in the painting | Character |
|painting_material | The type of material the painting was painted on | Character |
|  dimentions_cm | The dimentions of the painting  | Character |
|  area_cm2     | The area of the painting in cm^2 | Numeric |
|  image_url    | The url where the image of the painting can be found | URL |
|  image_name   | The name for the image url | Character |

## Visualizations 

|    Figue ID     |  Figure Name  |  Description  |
| ----------------| ------------- | ------------- |
|               |  | |
|                | | |
|               | ||
|                |  |


## Reference
[1] G. Fernández, “The 200 Most Valuable Paintings in private hands” theartwolf.com, May. 2008. [Online]. Available: https://theartwolf.com/art-market/most-valuable-paintings/. [Accessed Oct. 8, 2023]
[2] Ray, “Color, Shape, and Texture: Feature Extraction using OpenCV” medium.com, Feb. 19, 2022. [Online]. Available: https://medium.com/mlearning-ai/color-shape-and-texture-feature-extraction-using-opencv-cb1feb2dbdAccessed Oct. 7, 2023.
