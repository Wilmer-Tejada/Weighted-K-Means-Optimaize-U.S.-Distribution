# Weighted-K-Means-Optimaize-U.S.-Distribution
This file contains instructions on what is contained within our project as well as
how you can run the code.

Description
==================================

Our project was built on top of the programing language R. It uses 3 separate libraries, namely shiny, tidyverse, and
leaflet. The shiny library is used to create the structure our application, which includes creating both the front end
and the back end. The front end allows users to interact with the back end by using sliders and switches. The backend is
where our K-means model is built. The leaflet library is simply used to display the map visualization. Finally, the
tidyverse library is used for data wrangling and creating the proper dataset to feed to our K-means model.

Installation
==================================
Our web app is hosted on the internet and can be accessed at: https://wilmer-tejada.shinyapps.io/Kmeans_USCities/

If instead a user wants to run and/or modify the application on their own computer, then the user must download the R
programming language and the R Studio IDE. Links to download both of these are provided below:

R: https://cran.r-project.org/mirrors.html
R Studio IDE: https://www.rstudio.com/products/rstudio/download/

Once the R programming language has been installed, you can open the R Studio IDE and install the necessary libraries
by running the following command:

```
install.packages(c("tidyverse", "shiny", "shinyWidgets","leaflet"))
```

After installing the necessary libraries, download the all the files listed below as well as the dataset needed for this project which can be found here:
https://simplemaps.com/data/us-cities

The necessary files are listed below:
Project scaling.ipynb
Kmeans for US Cities.proj
UPS-Fedex Locations.csv
app.R
FedEx_logo.png
ups-log-0.png

In order to get a proper dataset for this project, you will need to scale the dataset that you got from the simplemaps website. This can be done by loading this dataset into the Project scaling.ipynb file which is a jupyter notebook. Instructions on how to use jupyter can be found here:
https://www.dataquest.io/blog/jupyter-notebook-tutorial/

In the Project scaling file, replace "uscities-csv.csv" with the location of downloaded file on your local computer and run the code. This should output a working file that can directly be accessed by our application.

Execution
==================================

Once all the files are present on your local computer, open the project file (Kmeans for US Cities.proj) and after R
Studio opens your project, you can open the app.R file within the project. At the top right corner of your app.R script, you should be able
to see a "Run App" button. You can click this, and if all files and libraries are present, the application should render
successfully.


